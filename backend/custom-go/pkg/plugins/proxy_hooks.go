package plugins

import (
	"custom-go/pkg/base"
	"custom-go/pkg/consts"
	"custom-go/pkg/utils"
	"custom-go/pkg/wgpb"
	"encoding/json"
	"github.com/labstack/echo/v4"
	"os"
	"path"
	"path/filepath"
)

type httpProxyHookFunction func(*base.HttpTransportHookRequest, *HttpTransportBody) (*base.ClientResponse, error)

func RegisterProxyHook(hookFunc httpProxyHookFunction, operationType ...wgpb.OperationType) {
	callerName := utils.GetCallerName(consts.PROXY)
	apiPrefixPath := "/" + consts.PROXY
	apiPath := path.Join(apiPrefixPath, callerName)

	base.AddEchoRouterFunc(func(e *echo.Echo) {
		e.Logger.Debugf(`Registered hookFunction [%s]`, apiPath)
		e.POST(apiPath, BuildHookFunc(hookFunc))
	})

	base.AddHealthFunc(func(e *echo.Echo, s string, report *base.HealthReport) {
		operation := &wgpb.Operation{}
		operationJsonPath := filepath.Join(consts.PROXY, callerName) + consts.JSON_EXT

		// 读文件，保留原有配置，只需更新schema
		if !utils.NotExistFile(operationJsonPath) {
			utils.ReadStructAndCacheFile(operationJsonPath, operation)
		} else {
			operation.Name = callerName
			operation.Path = apiPath
			operation.OperationType = wgpb.OperationType_MUTATION
		}

		if operationType != nil && len(operationType) > 0 {
			operation.OperationType = operationType[0]
		}

		operationBytes, err := json.Marshal(operation)
		if err != nil {
			e.Logger.Errorf("json marshal failed, err: %v", err.Error())
			return
		}
		err = os.WriteFile(operationJsonPath, operationBytes, 0644)
		if err != nil {
			e.Logger.Errorf("write file failed, err: %v", err.Error())
			return
		}

		report.Lock()
		defer report.Unlock()
		report.Proxys = append(report.Proxys, callerName)
	})
}
