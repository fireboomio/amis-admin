package plugins

import (
	"custom-go/pkg/base"
	"custom-go/pkg/utils"
	"fmt"
	"github.com/labstack/echo/v4"
	"net/http"
	"path"
	"strconv"
)

const (
	maximumRecursionLimit = 16
)

const (
	mockResolveKey         = "mockResolve"
	preResolveKey          = "preResolve"
	postResolveKey         = "postResolve"
	mutatingPreResolveKey  = "mutatingPreResolve"
	mutatingPostResolveKey = "mutatingPostResolve"
	customResolveKey       = "customResolve"
)

func ConvertBodyFunc[I, O any](oldFunc func(*base.HookRequest, *base.OperationBody[I, O]) (*base.OperationBody[I, O], error)) base.OperationHookFunction {
	return func(hook *base.HookRequest, body *base.OperationBody[any, any]) (res *base.OperationBody[any, any], err error) {
		// 将传入的 OperationBody 转换为需要的类型
		var input = utils.ConvertType[base.OperationBody[any, any], base.OperationBody[I, O]](body)
		// 调用旧函数获取结果
		oldRes, err := oldFunc(hook, input)
		if err != nil {
			return res, err
		}

		res = utils.ConvertType[base.OperationBody[I, O], base.OperationBody[any, any]](oldRes)
		return res, nil
	}
}

func RegisterOperationsHooks(e *echo.Echo, operations []string, operationHooksMap base.OperationHooks) {
	for _, operationPath := range operations {
		registerOperationHooks(e, operationPath, operationHooksMap)
	}
}

func registerOperationHooks(e *echo.Echo, operationPath string, operationHooksMap base.OperationHooks) {
	if operationHook, ok := operationHooksMap[operationPath]; ok {
		pathPrefix := path.Join("/operation", operationPath)
		if operationHook.MockResolve != nil {
			apiPath := path.Join(pathPrefix, mockResolveKey)
			e.Logger.Debugf(`Registered operationHook [%s]`, apiPath)
			e.POST(apiPath, buildOperationHook(operationPath, mockResolveKey, operationHook.MockResolve, mockResolve))
		}

		if operationHook.PreResolve != nil {
			apiPath := path.Join(pathPrefix, preResolveKey)
			e.Logger.Debugf(`Registered operationHook [%s]`, apiPath)
			e.POST(apiPath, buildOperationHook(operationPath, preResolveKey, operationHook.PreResolve, preResolve))
		}

		if operationHook.PostResolve != nil {
			apiPath := path.Join(pathPrefix, postResolveKey)
			e.Logger.Debugf(`Registered operationHook [%s]`, apiPath)
			e.POST(apiPath, buildOperationHook(operationPath, postResolveKey, operationHook.PostResolve, postResolve))
		}

		if operationHook.MutatingPreResolve != nil {
			apiPath := path.Join(pathPrefix, mutatingPreResolveKey)
			e.Logger.Debugf(`Registered operationHook [%s]`, apiPath)
			e.POST(apiPath, buildOperationHook(operationPath, mutatingPreResolveKey, operationHook.MutatingPreResolve, mutatingPreResolve))
		}

		if operationHook.MutatingPostResolve != nil {
			apiPath := path.Join(pathPrefix, mutatingPostResolveKey)
			e.Logger.Debugf(`Registered operationHook [%s]`, apiPath)
			e.POST(apiPath, buildOperationHook(operationPath, mutatingPostResolveKey, operationHook.MutatingPostResolve, mutatingPostResolve))
		}

		if operationHook.CustomResolve != nil {
			apiPath := path.Join(pathPrefix, customResolveKey)
			e.Logger.Debugf(`Registered operationHook [%s]`, apiPath)
			e.POST(apiPath, buildOperationHook(operationPath, customResolveKey, operationHook.CustomResolve, customResolve))
		}
	}
}

func requestContext(c echo.Context) (result *base.HookRequest, err error) {
	body := make(map[string]interface{})
	if err := c.Request().ParseForm(); err != nil {
		return result, err
	}

	result = c.(*base.HookRequest)
	for key, value := range c.Request().Form {
		body[key] = value[0]
	}
	if cycleCounter, ok := body["cycleCounter"].(int); ok {
		if cycleCounter > maximumRecursionLimit {
			return result, fmt.Errorf("maximum recursion limit reached (%d)", maximumRecursionLimit)
		}
		result.InternalClient = result.InternalClient.WithHeaders(map[string]string{"Wg-Cycle-Counter": strconv.Itoa(cycleCounter)})
	}
	return result, nil
}

func mockResolve(in, out *base.OperationBody[any, any]) {
	in.Response = out.Response
	in.SetClientRequestHeaders = out.SetClientRequestHeaders
}
func preResolve(in, out *base.OperationBody[any, any]) {
	in.SetClientRequestHeaders = out.SetClientRequestHeaders
}

func postResolve(in, out *base.OperationBody[any, any]) {
	in.SetClientRequestHeaders = out.SetClientRequestHeaders
}

func mutatingPreResolve(in, out *base.OperationBody[any, any]) {
	in.Input = out.Input
	in.SetClientRequestHeaders = out.SetClientRequestHeaders
}

func mutatingPostResolve(in, out *base.OperationBody[any, any]) {
	in.Response = out.Response
	in.SetClientRequestHeaders = out.SetClientRequestHeaders
	if in.Response != nil && in.Response.DataAny != nil {
		in.Response.Data = in.Response.DataAny
		in.Response.DataAny = nil
	}
}

func customResolve(in, out *base.OperationBody[any, any]) {
	in.Response = out.Response
	in.SetClientRequestHeaders = out.SetClientRequestHeaders
}

func buildOperationHook(operationName, hookName string, hookFunction base.OperationHookFunction, action func(in, out *base.OperationBody[any, any])) echo.HandlerFunc {
	return func(c echo.Context) (err error) {
		c.Response().Header().Set(echo.HeaderContentType, echo.MIMEApplicationJSONCharsetUTF8)
		c.Response().WriteHeader(http.StatusOK)

		var in base.OperationBody[any, any]
		err = c.Bind(&in)
		if err != nil {
			return
		}

		hookRequest, err := requestContext(c)
		if err != nil {
			return
		}

		in.Op = operationName
		in.Hook = hookName
		in.SetClientRequestHeaders = headersToObject(c.Request().Header)
		out, err := hookFunction(hookRequest, &in)
		if err != nil {
			return err
		}

		if out != nil {
			action(&in, out)
		}
		return c.JSON(http.StatusOK, &in)
	}
}

func headersToObject(headers http.Header) map[string]string {
	obj := make(map[string]string)
	for key, values := range headers {
		if len(values) > 0 {
			obj[key] = values[0]
		}
	}
	return obj
}
