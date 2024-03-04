package executeRaw

import (
	"custom-go/generated"
	"custom-go/pkg/base"
	"encoding/json"
	"errors"
	"github.com/spf13/cast"
	"golang.org/x/exp/slices"
	"regexp"
)

func PreResolve(hook *base.HookRequest, body generated.Api__executeRawBody) (res generated.Api__executeRawBody, err error) {
	return body, IsValidParameters(body.Input.Parameters)
}

var ValidParameterRegexp = regexp.MustCompile("^[a-zA-Z0-9!@#$%^&*()_+]+$")

func IsValidParameters(parameters any) error {
	var parameterSlice []any
	parametersBytes, _ := json.Marshal(parameters)
	_ = json.Unmarshal(parametersBytes, &parameterSlice)
	if slices.ContainsFunc(parameterSlice, func(item any) bool {
		return ValidParameterRegexp.MatchString(cast.ToString(item))
	}) {
		return errors.New("非法输入")
	}
	return nil
}
