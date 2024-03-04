package plugins

import (
	"custom-go/pkg/base"
	"github.com/labstack/echo/v4"
	"net/http"
)

func BuildHookFunc(proxyHook httpProxyHookFunction) echo.HandlerFunc {
	return func(c echo.Context) (err error) {
		brc := c.(*base.HttpTransportHookRequest)

		var reqBody HttpTransportBody
		err = c.Bind(&reqBody)
		if err != nil {
			return echo.NewHTTPError(http.StatusBadRequest, err.Error())
		}

		newResp, err := proxyHook(brc, &reqBody)
		if err != nil {
			return echo.NewHTTPError(http.StatusBadRequest, err.Error())
		}
		resp := map[string]interface{}{
			"op":       reqBody.Name,
			"hook":     "proxyHook",
			"response": map[string]interface{}{},
		}
		if newResp != nil {
			resp["response"].(map[string]interface{})["response"] = newResp
		}
		return c.JSON(http.StatusOK, resp)
	}
}
