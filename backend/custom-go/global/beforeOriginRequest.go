package global

import (
	"custom-go/generated"
	latest "custom-go/generated/latest"
	"custom-go/pkg/base"
	"custom-go/pkg/plugins"
	"math"
	"net/url"
	"os"
	"strings"
	"time"

	"golang.org/x/exp/slices"
)

const (
	headerRbacRequireMatchAll = "x-rbac-requireMatchAll"
	superRoleCodeKey          = "SUPER_ROLE_CODE"
)

func BeforeOriginRequest(hook *base.HttpTransportHookRequest, body *plugins.HttpTransportBody) (*base.ClientRequest, error) {
	requestLogMap.Store(getRequestLogId(hook), &requestLog{
		start: time.Now(),
		ip:    body.Request.Headers["X-Real-Ip"],
		ua:    body.Request.Headers["User-Agent"],
		body:  body.Request.OriginBody,
	})
	requestURL, _ := url.Parse(body.Request.RequestURI)
	if requestURL != nil && !hasSuperRoleCode(hook.User) {
		role2apisResp, _ := latest.Role__api__findMany.Execute(generated.Role__api__findManyInternalInput{Path: requestURL.Path, Take: math.MaxInt16})
		if len(role2apisResp.Data) > 0 {
			body.Request.Headers[headerRbacRequireMatchAll] = strings.Join(role2apisResp.Data, ",")
		}
	}
	body.Request.Headers["X-Permission"] = "user"
	return body.Request, nil
}

func hasSuperRoleCode(user *base.WunderGraphUser) bool {
	superRoleCode := os.Getenv(superRoleCodeKey)
	return len(superRoleCode) > 0 && user != nil && slices.Contains(user.Roles, superRoleCode)
}
