package plugins

import (
	"custom-go/pkg/base"
	"github.com/labstack/echo/v4"
	"github.com/spf13/cast"
	"net/http"
)

type GlobalConfiguration struct {
	HttpTransport HttpTransportHooks
	WsTransport   WsTransportHooks
}

type HttpTransportBody struct {
	Request  *base.ClientRequest  `json:"request"`
	Response *base.ClientResponse `json:"response"`
	Name     string               `json:"operationName"`
	Type     string               `json:"operationType"`
}

type WsTransportBody struct {
	DataSourceId string `json:"dataSourceId"`
}

type HttpTransportHooks struct {
	BeforeOriginRequest func(*base.HttpTransportHookRequest, *HttpTransportBody) (*base.ClientRequest, error)
	AfterOriginResponse func(*base.HttpTransportHookRequest, *HttpTransportBody) (*base.ClientResponse, error)
	OnOriginRequest     func(*base.HttpTransportHookRequest, *HttpTransportBody) (*base.ClientRequest, error)
	OnOriginResponse    func(*base.HttpTransportHookRequest, *HttpTransportBody) (*base.ClientResponse, error)
}

type WsTransportHooks struct {
	OnConnectionInit func(*base.WsTransportHookRequest, *WsTransportBody) (any, error)
}

func RegisterGlobalHooks(e *echo.Echo, globalHooks GlobalConfiguration) {
	if globalHooks.HttpTransport.BeforeOriginRequest != nil {
		apiPath := "/global/httpTransport/beforeOriginRequest"
		e.Logger.Debugf(`Registered globalHook [%s]`, apiPath)
		e.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.HttpTransportHookRequest)
			var reqBody HttpTransportBody
			err := c.Bind(&reqBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusBadRequest, err.Error())
			}

			newReq, err := globalHooks.HttpTransport.BeforeOriginRequest(brc, &reqBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}
			resp := map[string]interface{}{
				"op":       reqBody.Name,
				"hook":     "beforeOriginRequest",
				"response": map[string]interface{}{},
			}
			if newReq != nil {
				resp["response"].(map[string]interface{})["request"] = newReq
			}
			return c.JSON(http.StatusOK, resp)
		})
	}

	if globalHooks.HttpTransport.AfterOriginResponse != nil {
		apiPath := "/global/httpTransport/afterOriginResponse"
		e.Logger.Debugf(`Registered globalHook [%s]`, apiPath)
		e.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.HttpTransportHookRequest)
			var respBody HttpTransportBody
			err := c.Bind(&respBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusBadRequest, err.Error())
			}

			newResp, err := globalHooks.HttpTransport.AfterOriginResponse(brc, &respBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}
			resp := map[string]interface{}{
				"op":       respBody.Name,
				"hook":     "onOriginResponse",
				"response": map[string]interface{}{},
			}
			if newResp != nil {
				resp["response"].(map[string]interface{})["response"] = newResp
			}
			return c.JSON(http.StatusOK, resp)
		})
	}

	if globalHooks.HttpTransport.OnOriginRequest != nil {
		apiPath := "/global/httpTransport/onOriginRequest"
		e.Logger.Debugf(`Registered globalHook [%s]`, apiPath)
		e.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.HttpTransportHookRequest)
			var reqBody HttpTransportBody
			err := c.Bind(&reqBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusBadRequest, err.Error())
			}

			newReq, err := globalHooks.HttpTransport.OnOriginRequest(brc, &reqBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}
			resp := map[string]interface{}{
				"op":       reqBody.Name,
				"hook":     "onOriginRequest",
				"response": map[string]interface{}{},
			}
			if newReq != nil {
				resp["response"].(map[string]interface{})["request"] = newReq
			}
			return c.JSON(http.StatusOK, resp)
		})
	}

	if globalHooks.HttpTransport.OnOriginResponse != nil {
		apiPath := "/global/httpTransport/onOriginResponse"
		e.Logger.Debugf(`Registered globalHook [%s]`, apiPath)
		e.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.HttpTransportHookRequest)
			var respBody HttpTransportBody
			err := c.Bind(&respBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusBadRequest, err.Error())
			}

			newResp, err := globalHooks.HttpTransport.OnOriginResponse(brc, &respBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}
			resp := map[string]interface{}{
				"op":       respBody.Name,
				"hook":     "onOriginResponse",
				"response": map[string]interface{}{},
			}
			if newResp != nil {
				resp["response"].(map[string]interface{})["response"] = newResp
			}
			return c.JSON(http.StatusOK, resp)
		})
	}

	if globalHooks.WsTransport.OnConnectionInit != nil {
		apiPath := "/global/wsTransport/onConnectionInit"
		e.Logger.Debugf(`Registered globalHook [%s]`, apiPath)
		e.POST(apiPath, func(c echo.Context) error {
			brc := c.(*base.WsTransportHookRequest)
			var reqBody WsTransportBody
			err := c.Bind(&reqBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusBadRequest, err.Error())
			}
			resp, err := globalHooks.WsTransport.OnConnectionInit(brc, &reqBody)
			if err != nil {
				return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
			}
			return c.JSON(http.StatusOK, map[string]interface{}{
				"hook":     "onConnectionInit",
				"response": resp,
			})
		})
	}

	// handle not found routes
	e.HTTPErrorHandler = func(err error, c echo.Context) {
		if he, ok := err.(*echo.HTTPError); ok {
			_ = c.JSON(he.Code, map[string]string{"error": cast.ToString(he.Message)})
		} else {
			_ = c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
		}
	}
}
