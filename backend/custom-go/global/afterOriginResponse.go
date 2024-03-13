package global

import (
	"custom-go/generated"
	latest "custom-go/generated/latest"
	"custom-go/pkg/base"
	"custom-go/pkg/plugins"
	"github.com/spf13/cast"
	"github.com/tidwall/gjson"
	"net/http"
	"net/url"
	"sync"
	"time"
)

type requestLog struct {
	start time.Time
	ip    string
	ua    string
	body  []byte
}

func AfterOriginResponse(hook *base.HttpTransportHookRequest, body *plugins.HttpTransportBody) (*base.ClientResponse, error) {
	defer recordRequestLog(hook, body)
	return nil, nil
}

func recordRequestLog(hook *base.HttpTransportHookRequest, body *plugins.HttpTransportBody) {
	requestId := getRequestLogId(hook)
	value, ok := requestLogMap.LoadAndDelete(requestId)
	if !ok {
		return
	}

	logValue := value.(*requestLog)
	logInput := generated.Log__createOneInternalInput{
		Cost:      time.Since(logValue.start).Seconds(),
		Ip:        logValue.ip,
		Ua:        logValue.ua,
		Body:      string(logValue.body),
		RequestId: requestId,
		Method:    body.Response.Method,
		Path:      body.Response.RequestURI,
		Status:    cast.ToString(body.Response.StatusCode),
	}
	requestURL, _ := url.Parse(body.Response.RequestURI)
	if requestURL != nil {
		logInput.Path = requestURL.Path
	}
	if hook.User != nil {
		logInput.UserId = hook.User.UserId
	}
	if body.Response.StatusCode != http.StatusOK {
		logInput.Error = string(body.Response.OriginBody)
	}
	if errResult := gjson.GetBytes(body.Response.OriginBody, "errors.0.message"); errResult.Exists() {
		logInput.Error = errResult.String()
	}
	_, _ = latest.Log__createOne.Execute(logInput)
}

var requestLogMap = sync.Map{}

func getRequestLogId(hook *base.HttpTransportHookRequest) string {
	return hook.Request().Header.Get("x-request-id")
}
