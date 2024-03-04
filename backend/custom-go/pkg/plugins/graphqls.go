package plugins

import (
	"bytes"
	"custom-go/pkg/base"
	"custom-go/pkg/consts"
	"custom-go/pkg/embeds"
	"custom-go/pkg/utils"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/graphql-go/graphql/language/ast"
	"github.com/tidwall/gjson"
	"github.com/tidwall/sjson"
	"io"
	"math"
	"net/http"
	"os"
	"path/filepath"
	"runtime"
	"strings"

	"github.com/buger/jsonparser"
	graphql "github.com/graphql-go/graphql"
	"github.com/graphql-go/graphql/gqlerrors"
	"github.com/labstack/echo/v4"
	"github.com/r3labs/sse/v2"
	"github.com/wundergraph/graphql-go-tools/pkg/pool"
)

var (
	lBrace        = []byte("{")
	rBrace        = []byte("}")
	lBrack        = []byte("[")
	rBrack        = []byte("]")
	comma         = []byte(",")
	colon         = []byte(":")
	quote         = []byte("\"")
	null          = []byte("null")
	literalData   = []byte("data")
	literalErrors = []byte("errors")
)

var (
	internalError     = "internal error"
	headerData        = []byte("data:")
	headerEvent       = []byte("event:")
	eventTypeComplete = []byte("complete")
	eventTypeNext     = []byte("next")
)

const (
	graphqlResultErrorsPath = "errors.0.message"
	graphqlResultDataPath   = "data.__schema"
)

type GraphQLServerConfig struct {
	ServerName            string
	Schema                graphql.Schema
	ApiNamespace          string
	EnableGraphQLEndpoint bool
	RouteUrl              string
	ContextFactory        func(struct{})
	SkipRenameRootFields  []string
	customResolverFactory func(struct{})
}

type graphqlBody struct {
	Query         string                 `json:"query"`
	Variables     map[string]interface{} `json:"variables"`
	OperationName string                 `json:"operationName"`
	Extensions    map[string]any         `json:"extensions"`
}

func GetCallerName(prefix string) string {
	if !strings.HasSuffix(prefix, "/") {
		prefix += "/"
	}

	_, callerFilename, _, _ := runtime.Caller(2)
	_, callerName, ok := strings.Cut(callerFilename, prefix)
	if !ok {
		return ""
	}

	return strings.TrimSuffix(callerName, filepath.Ext(callerName))
}

var htmlBytesMap = make(map[string][]byte, 0)

func RegisterGraphql(schema *graphql.Schema) {
	// eg. customize/test
	callerName := GetCallerName(consts.CUSTOMIZE)
	routeUrl := fmt.Sprintf(`/gqls/%s/graphql`, callerName)
	var hasSubscriptionFieldResolveFn bool
	if subscriptionType := schema.SubscriptionType(); subscriptionType != nil {
		for _, definition := range subscriptionType.Fields() {
			if definition.Subscribe != nil {
				hasSubscriptionFieldResolveFn = true
				break
			}
		}
	}
	base.AddEchoRouterFunc(func(e *echo.Echo) {
		e.Logger.Debugf(`Registered gqlServer (%s)`, routeUrl)
		e.GET(routeUrl, echo.WrapHandler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			var htmlBytes []byte
			if val, ok := htmlBytesMap[routeUrl]; ok {
				htmlBytes = val
			} else {
				filePath := "helix.html"
				fileBytes, err := os.ReadFile(filePath)
				if err != nil {
					http.Error(w, err.Error(), http.StatusInternalServerError)
					return
				}
				htmlBytes = bytes.ReplaceAll(fileBytes, []byte("${graphqlEndpoint}"), []byte(routeUrl))
				htmlBytesMap[routeUrl] = htmlBytes
			}
			_, _ = w.Write(htmlBytes)
		})))

		e.POST(routeUrl, func(c echo.Context) error {
			var body graphqlBody
			err := utils.CopyAndBindRequestBody(c.Request(), &body)
			if err != nil {
				return buildEchoGraphqlError(c, err)
			}

			brc := c.(*base.BaseRequestContext)
			grc := &base.GraphqlRequestContext{
				Request:        c.Request(),
				Context:        c.Request().Context(),
				User:           brc.User,
				InternalClient: brc.InternalClient,
				Logger:         brc.Logger(),
			}
			param := graphql.Params{
				Schema:         *schema,
				OperationName:  body.OperationName,
				RequestString:  body.Query,
				VariableValues: body.Variables,
				Context:        grc,
			}

			if hasSubscriptionFieldResolveFn && strings.HasPrefix(body.Query, "subscription") {
				result := graphql.Subscribe(param)
				return handleSSEFromChan(brc, result)
			}

			result := graphql.Do(param)
			if grc.Result != nil {
				return handleSSE(brc, grc.Result)
			}

			return c.JSON(http.StatusOK, result)
		})
	})

	// 注册 healthFunc
	base.AddHealthFunc(func(e *echo.Echo, address string, report *base.HealthReport) {
		// 内省自身并输出到文件
		introspectBytes, err := embeds.EmbedIntrospect.ReadFile(consts.INTROSPECT_FILE)
		if err != nil {
			e.Logger.Errorf("get embed introspect.json failed, err: %v", err.Error())
			return
		}
		headers := map[string]string{echo.HeaderContentType: echo.MIMEApplicationJSON}
		respBody, err := utils.HttpPost(consts.HTTP_PREFIX+address+routeUrl, introspectBytes, headers, 5)
		if err != nil {
			e.Logger.Errorf("post req failed, uri: %s, err: %v", routeUrl, err.Error())
			return
		}

		if errorMsg := gjson.GetBytes(respBody, graphqlResultErrorsPath); errorMsg.Exists() {
			e.Logger.Error(errorMsg.String())
			return
		}
		res := gjson.GetBytes(respBody, graphqlResultDataPath).String()

		// 写入文件--eg. custom-go/customize/test.go  --> custom-go/customize/test.json
		err = os.WriteFile(filepath.Join(consts.CUSTOMIZE, callerName)+consts.JSON_EXT, []byte(res), 0644)
		if err != nil {
			e.Logger.Errorf("write file failed, err: %v", err.Error())
			return
		}

		report.Lock()
		defer report.Unlock()
		report.Customizes = append(report.Customizes, callerName)
	})
}

func handleSSEFromChan(c *base.BaseRequestContext, resultChan chan *graphql.Result) error {
	flusher, ok := c.Response().Writer.(http.Flusher)
	if !ok {
		return fmt.Errorf("streaming unsupported")
	}

	c.Response().Header().Set("Content-Type", "text/event-stream")
	c.Response().Header().Set("Cache-Control", "no-cache")
	c.Response().Header().Set("Connection", "keep-alive")
	c.Response().WriteHeader(http.StatusOK)
	for {
		select {
		case result, isOpen := <-resultChan:
			if !isOpen {
				return nil
			}
			_, done := result.Extensions["DONE"]
			if done {
				return nil
			}

			if len(result.Errors) > 0 {
				return result.Errors[0]
			}

			bytes, err := json.Marshal(result.Data)
			if err != nil {
				fmt.Println("JSON 序列化失败：", err)
				close(resultChan)
				return err
			}
			buf := pool.BytesBuffer.Get()
			buf.Reset()
			_ = writeGraphqlResponse(bytes, nil, buf)
			_, _ = fmt.Fprintf(c.Response().Writer, "data: %s\n\n", buf.String())
			flusher.Flush()
		}
	}
}

func handleSSE(c *base.BaseRequestContext, sseChan *base.ResultChan) error {
	flusher, ok := c.Response().Writer.(http.Flusher)
	if !ok {
		return fmt.Errorf("streaming unsupported")
	}

	c.Response().Header().Set("Content-Type", "text/event-stream")
	c.Response().Header().Set("Cache-Control", "no-cache")
	c.Response().Header().Set("Connection", "keep-alive")
	c.Response().WriteHeader(http.StatusOK)
	closeFunc := func() {
		close(sseChan.Data)
		close(sseChan.Error)
		close(sseChan.Done)
	}

	// 定义 SSE 事件回调函数，每秒钟发送一个 SSE 事件
	for {
		select {
		case result := <-sseChan.Data:
			if len(result) == 0 {
				continue
			}

			buf := pool.BytesBuffer.Get()
			buf.Reset()
			_ = writeGraphqlResponse(result, nil, buf)
			_, _ = fmt.Fprintf(c.Response().Writer, "data: %s\n\n", buf.String())
			flusher.Flush()
		case errBytes := <-sseChan.Error:
			if errBytes == nil {
				continue
			}

			buf := pool.BytesBuffer.Get()
			buf.Reset()
			errString, _ := sjson.Set("{}", "message", string(errBytes))
			_ = writeGraphqlResponse(nil, []byte(errString), buf)
			_, _ = fmt.Fprintf(c.Response().Writer, "errors: %s\n\n", buf.String())
			flusher.Flush()
			closeFunc()
			return nil
		case done := <-sseChan.Done:
			_, _ = fmt.Fprintf(c.Response().Writer, string(done))
			flusher.Flush()
			closeFunc()
			return nil
		}
	}
}

func buildEchoGraphqlError(c echo.Context, err error) error {
	c.Logger().Error(err)
	return c.JSON(http.StatusInternalServerError, graphql.Result{
		Errors: []gqlerrors.FormattedError{{Message: err.Error()}},
	})
}

func GetGraphqlContext(params graphql.ResolveParams) *base.GraphqlRequestContext {
	return params.Context.(*base.GraphqlRequestContext)
}

func ResolveArgs[T any](params graphql.ResolveParams) (grc *base.GraphqlRequestContext, args *T, err error) {
	grc = GetGraphqlContext(params)
	err = ResolveParamsToStruct(params, &args)
	return
}

func ResolveParamsToStruct(params graphql.ResolveParams, input any) error {
	argsBytes, err := json.Marshal(params.Args)
	if err != nil {
		return err
	}

	return json.Unmarshal(argsBytes, &input)
}

func HandleSSEReader(eventStream io.ReadCloser, grc *base.GraphqlRequestContext, handle func([]byte, bool) ([]byte, bool, error)) {
	grc.Result = &base.ResultChan{
		Data:  make(chan []byte),
		Error: make(chan []byte),
		Done:  make(chan []byte),
	}
	sseChan := grc.Result

	go func() {
		defer func() { _ = eventStream.Close() }()
		reader := sse.NewEventStreamReader(eventStream, math.MaxInt)
		for {
			select {
			case <-grc.Context.Done():
				if nil != handle {
					_, _, _ = handle(nil, true)
				}
				return
			default:
				msg, err := reader.ReadEvent()
				if err != nil {
					if err == io.EOF {
						return
					}

					grc.Logger.Infof("sse error: %s", err.Error())
					sseChan.Error <- []byte(internalError)
					return
				}

				if len(msg) == 0 {
					continue
				}

				// normalize the crlf to lf to make it easier to split the lines.
				// split the line by "\n" or "\r", per the spec.
				lines := bytes.FieldsFunc(msg, func(r rune) bool { return r == '\n' || r == '\r' })
				for _, line := range lines {
					switch {
					case bytes.HasPrefix(line, headerData):
						data := trim(line[len(headerData):])

						if len(data) == 0 {
							continue
						}

						if nil != handle {
							afterData, done, handleErr := handle(data, false)
							if handleErr != nil {
								sseChan.Error <- []byte(internalError)
								return
							}
							if done {
								sseChan.Data <- afterData
								sseChan.Done <- afterData
								return
							}
							if len(afterData) == 0 {
								continue
							}
							data = afterData
						}
						sseChan.Data <- data
					case bytes.HasPrefix(line, headerEvent):
						event := trim(line[len(headerEvent):])

						switch {
						case bytes.Equal(event, eventTypeComplete):
							return
						case bytes.Equal(event, eventTypeNext):
							continue
						}
					case bytes.HasPrefix(msg, []byte(":")):
						// according to the spec, we ignore messages starting with a colon
						continue
					default:
						// ideally we should not get here, or if we do, we should ignore it
						// but some providers send a json object with the error messages, without the event header

						// check for errors which came without event header
						data := trim(line)

						val, valueType, _, err := jsonparser.Get(data, "errors")
						switch err {
						case jsonparser.KeyPathNotFoundError:
							continue
						case jsonparser.MalformedJsonError:
							// ignore garbage
							continue
						case nil:
							if valueType == jsonparser.Array {
								response := []byte(`{}`)
								response, err = jsonparser.Set(response, val, "errors")
								if err != nil {
									sseChan.Error <- []byte(err.Error())
									return
								}

								sseChan.Error <- response
								return
							} else if valueType == jsonparser.Object {
								response := []byte(`{"errors":[]}`)
								response, err = jsonparser.Set(response, val, "errors", "[0]")
								if err != nil {
									sseChan.Error <- []byte(err.Error())
									return
								}

								sseChan.Error <- response
								return
							}

						default:
							sseChan.Error <- []byte(internalError)
							return
						}
					}
				}
			}
		}
	}()
}

func HandleSSEReader2(eventStream io.ReadCloser, handle func([]byte) ([]byte, bool)) chan graphql.Result {
	sseChan := make(chan graphql.Result)

	go func() {
		defer eventStream.Close()
		reader := sse.NewEventStreamReader(eventStream, math.MaxInt)
		for {
			msg, err := reader.ReadEvent()
			if err != nil {
				if err == io.EOF {
					return
				}

				sseChan <- graphql.Result{Errors: []gqlerrors.FormattedError{{Message: internalError}}}
				return
			}

			if len(msg) == 0 {
				continue
			}

			// normalize the crlf to lf to make it easier to split the lines.
			// split the line by "\n" or "\r", per the spec.
			lines := bytes.FieldsFunc(msg, func(r rune) bool { return r == '\n' || r == '\r' })
			for _, line := range lines {
				switch {
				case bytes.HasPrefix(line, headerData):
					data := trim(line[len(headerData):])

					if len(data) == 0 {
						continue
					}

					if nil != handle {
						afterData, done := handle(data)
						if done {
							return
						}
						if len(afterData) == 0 {
							continue
						}
						data = afterData
					}
					sseChan <- graphql.Result{Data: data}
				case bytes.HasPrefix(line, headerEvent):
					event := trim(line[len(headerEvent):])

					switch {
					case bytes.Equal(event, eventTypeComplete):
						return
					case bytes.Equal(event, eventTypeNext):
						continue
					}
				case bytes.HasPrefix(msg, []byte(":")):
					// according to the spec, we ignore messages starting with a colon
					continue
				default:
					// ideally we should not get here, or if we do, we should ignore it
					// but some providers send a json object with the error messages, without the event header

					// check for errors which came without event header
					data := trim(line)

					val, valueType, _, err := jsonparser.Get(data, "errors")
					switch {
					case errors.Is(err, jsonparser.KeyPathNotFoundError):
						continue
					case errors.Is(err, jsonparser.MalformedJsonError):
						// ignore garbage
						continue
					case err == nil:
						if valueType == jsonparser.Array {
							response := []byte(`{}`)
							response, err = jsonparser.Set(response, val, "errors")
							if err != nil {
								sseChan <- graphql.Result{Errors: []gqlerrors.FormattedError{{Message: err.Error()}}}
								return
							}

							sseChan <- graphql.Result{Errors: []gqlerrors.FormattedError{{Message: string(response)}}}
							return
						} else if valueType == jsonparser.Object {
							response := []byte(`{"errors":[]}`)
							response, err = jsonparser.Set(response, val, "errors", "[0]")
							if err != nil {
								sseChan <- graphql.Result{Errors: []gqlerrors.FormattedError{{Message: err.Error()}}}
								return
							}

							sseChan <- graphql.Result{Errors: []gqlerrors.FormattedError{{Message: string(response)}}}
							return
						}
					default:
						sseChan <- graphql.Result{Errors: []gqlerrors.FormattedError{{Message: internalError}}}
						return
					}
				}
			}
		}
	}()

	return sseChan
}

func trim(data []byte) []byte {
	// remove the leading space
	data = bytes.TrimLeft(data, " \t")

	// remove the trailing new line
	data = bytes.TrimRight(data, "\n")

	return data
}

func writeGraphqlResponse(data, errors []byte, writer io.Writer) (err error) {
	hasErrors := len(errors) != 0
	hasData := len(data) != 0

	err = writeSafe(err, writer, lBrace)

	if hasErrors {
		err = writeSafe(err, writer, quote)
		err = writeSafe(err, writer, literalErrors)
		err = writeSafe(err, writer, quote)
		err = writeSafe(err, writer, colon)
		err = writeSafe(err, writer, lBrack)
		err = writeSafe(err, writer, errors)
		err = writeSafe(err, writer, rBrack)
		err = writeSafe(err, writer, comma)
	}

	err = writeSafe(err, writer, quote)
	err = writeSafe(err, writer, literalData)
	err = writeSafe(err, writer, quote)
	err = writeSafe(err, writer, colon)

	if hasData {
		_, err = writer.Write(data)
	} else {
		err = writeSafe(err, writer, null)
	}
	err = writeSafe(err, writer, rBrace)

	return err
}

func writeSafe(err error, writer io.Writer, data []byte) error {
	if err != nil {
		return err
	}
	_, err = writer.Write(data)
	return err
}

func BuildStructScalar[T any](name string) *graphql.Scalar {
	return graphql.NewScalar(graphql.ScalarConfig{
		Name:        name,
		Description: fmt.Sprintf("The `%s` scalar type represents %s.", name, name),
		Serialize: func(value interface{}) interface{} {
			if v, ok := value.(*T); ok {
				if v == nil {
					return nil
				}
				return *v
			}
			return value
		},
		ParseValue: func(value interface{}) interface{} {
			deserializeFn := func(data []byte) (response T) {
				_ = json.Unmarshal(data, &response)
				return
			}
			switch value := value.(type) {
			case []byte:
				return deserializeFn(value)
			case string:
				return deserializeFn([]byte(value))
			case *string:
				if value == nil {
					return nil
				}
				return deserializeFn([]byte(*value))
			default:
				return nil
			}
		},
		ParseLiteral: func(valueAST ast.Value) interface{} {
			switch valueAST := valueAST.(type) {
			case *ast.ObjectValue:
				return valueAST.GetValue()
			}
			return nil
		},
	})
}
