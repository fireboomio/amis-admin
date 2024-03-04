package plugins

import (
	"custom-go/pkg/base"
	"encoding/base64"
	"errors"
	"github.com/labstack/echo/v4"
	"net/http"
	"path"
	"strings"
)

type AuthenticationResponse struct {
	Message string                `json:"message"`
	Status  string                `json:"status"`
	User    *base.WunderGraphUser `json:"user"`
}

type AuthenticationConfiguration struct {
	PostAuthentication         func(hook *base.AuthenticationHookRequest) error
	MutatingPostAuthentication func(hook *base.AuthenticationHookRequest) (*AuthenticationResponse, error)
	RevalidateAuthentication   func(hook *base.AuthenticationHookRequest) (*AuthenticationResponse, error)
	PostLogout                 func(hook *base.AuthenticationHookRequest) error
}

func TryParseJWT(token string) []byte {
	parts := strings.Split(token, ".")
	if len(parts) != 3 {
		return nil
	}
	payload, err := base64.RawURLEncoding.DecodeString(parts[1])
	if err != nil {
		return nil
	}
	return payload
}

func RegisterAuthHooks(e *echo.Echo, authHooks AuthenticationConfiguration) {
	authPrefix := "/authentication"
	auth := e.Group(authPrefix)
	// preHandler hook - check user context
	auth.Use(func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {
			brc := c.(*base.AuthenticationHookRequest)
			if brc.User == nil {
				return errors.New("user context doesn't exist")
			}
			return next(brc)
		}
	})

	// authentication routes
	if authHooks.PostAuthentication != nil {
		apiPath := "/postAuthentication"
		e.Logger.Debugf(`Registered authHook [%s]`, path.Join(authPrefix, apiPath))
		auth.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.AuthenticationHookRequest)
			err := authHooks.PostAuthentication(brc)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}

			return c.JSON(http.StatusOK, map[string]interface{}{
				"hook": "postAuthentication",
			})
		})
	}

	if authHooks.MutatingPostAuthentication != nil {
		apiPath := "/mutatingPostAuthentication"
		e.Logger.Debugf(`Registered authHook [%s]`, path.Join(authPrefix, apiPath))
		auth.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.AuthenticationHookRequest)
			out, err := authHooks.MutatingPostAuthentication(brc)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}

			return c.JSON(http.StatusOK, map[string]interface{}{
				"hook":                    "mutatingPostAuthentication",
				"response":                out,
				"setClientRequestHeaders": headersToObject(brc.Request().Header),
			})
		})
	}

	if authHooks.RevalidateAuthentication != nil {
		apiPath := "/revalidateAuthentication"
		e.Logger.Debugf(`Registered authHook [%s]`, path.Join(authPrefix, apiPath))
		auth.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.AuthenticationHookRequest)
			out, err := authHooks.RevalidateAuthentication(brc)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}

			return c.JSON(http.StatusOK, map[string]interface{}{
				"hook":                    "revalidateAuthentication",
				"response":                out,
				"setClientRequestHeaders": headersToObject(brc.Request().Header),
			})
		})
	}

	if authHooks.PostLogout != nil {
		apiPath := "/postLogout"
		e.Logger.Debugf(`Registered authHook [%s]`, path.Join(authPrefix, apiPath))
		auth.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.AuthenticationHookRequest)
			err := authHooks.PostLogout(brc)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}

			return c.JSON(http.StatusOK, map[string]interface{}{
				"hook":                    "postLogout",
				"setClientRequestHeaders": headersToObject(brc.Request().Header),
			})
		})
	}
}
