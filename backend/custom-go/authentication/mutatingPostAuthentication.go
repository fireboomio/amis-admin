package auth

import (
	"custom-go/generated"
	latest "custom-go/generated/latest"
	"custom-go/pkg/base"
	"custom-go/pkg/plugins"
)

func MutatingPostAuthentication(hook *base.AuthenticationHookRequest) (*plugins.AuthenticationResponse, error) {
	userResp, err := latest.User__me.Execute(generated.User__meInternalInput{UserId: hook.User.UserId})
	if err != nil {
		return nil, err
	}

	hook.User.Roles = userResp.Data.Roles
	if hook.User.CustomClaims == nil {
		hook.User.CustomClaims = make(map[string]any)
	}
	if len(userResp.Data.AreaCodes) > 0 {
		hook.User.CustomClaims["areaCodes"] = userResp.Data.AreaCodes
	}
	hook.User.CustomClaims["permission"] = map[string][]string{
		"areacodes": {"user", "role"},
	}
	return &plugins.AuthenticationResponse{User: hook.User, Status: "ok"}, nil
}
