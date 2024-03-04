package queryRaw

import (
	"custom-go/generated"
	"custom-go/operation/api/executeRaw"
	"custom-go/pkg/base"
)

func PreResolve(hook *base.HookRequest, body generated.Api__queryRawBody) (res generated.Api__queryRawBody, err error) {
	return body, executeRaw.IsValidParameters(body.Input.Parameters)
}
