package server

import (
	"custom-go/pkg/base"
	"custom-go/pkg/plugins"
	"custom-go/pkg/types"
	"custom-go/pkg/utils"
	"custom-go/pkg/wgpb"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/labstack/gommon/log"
	"golang.org/x/exp/maps"
	"net"
	"net/http"
	"os"
	"os/signal"
	"sync"
	"syscall"
	"time"

	"context"
)

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := startServer(); err != nil {
		os.Exit(1)
	}
}

var (
	address      string
	healthReport *base.HealthReport
)

func configureWunderGraphServer() *echo.Echo {
	// 初始化 Echo 实例
	e := echo.New()
	e.Logger.SetLevel(log.DEBUG)

	// 配置日志中间件
	loggerConfig := middleware.DefaultLoggerConfig
	loggerConfig.Skipper = func(c echo.Context) bool {
		return c.Request().URL.Path == "/health"
	}
	e.Use(middleware.LoggerWithConfig(loggerConfig))

	// 配置 CORS 中间件
	corsCfg := middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodDelete},
		AllowHeaders: []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept},
	}
	e.Use(middleware.CORSWithConfig(corsCfg))

	plugins.RegisterGlobalHooks(e, types.WdgHooksAndServerConfig.Hooks.Global)
	plugins.RegisterAuthHooks(e, types.WdgHooksAndServerConfig.Hooks.Authentication)
	plugins.RegisterUploadsHooks(e, types.WdgHooksAndServerConfig.Hooks.Uploads)

	nodeUrl := utils.GetConfigurationVal(types.WdgGraphConfig.Api.NodeOptions.NodeUrl)
	plugins.SetBaseNodeUrl(nodeUrl)
	internalQueries := plugins.BuildInternalRequest(e.Logger, nodeUrl, wgpb.OperationType_QUERY)
	if queryLen := len(internalQueries); queryLen > 0 {
		plugins.RegisterOperationsHooks(e, maps.Keys(internalQueries), types.WdgHooksAndServerConfig.Hooks.Queries)
		e.Logger.Debugf(`Registered (%d) query operations`, queryLen)
	}
	internalMutations := plugins.BuildInternalRequest(e.Logger, nodeUrl, wgpb.OperationType_MUTATION)
	if mutationLen := len(internalMutations); mutationLen > 0 {
		plugins.RegisterOperationsHooks(e, maps.Keys(internalMutations), types.WdgHooksAndServerConfig.Hooks.Mutations)
		e.Logger.Debugf(`Registered (%d) mutation operations`, mutationLen)
	}
	subscriptionOperations := plugins.FetchSubscriptions()
	if subscriptionLen := len(subscriptionOperations); subscriptionLen > 0 {
		plugins.RegisterOperationsHooks(e, subscriptionOperations, types.WdgHooksAndServerConfig.Hooks.Subscriptions)
		e.Logger.Debugf(`Registered (%d) subscription operations`, subscriptionLen)
	}
	plugins.BuildDefaultInternalClient(internalQueries, internalMutations)

	registerOnce := &sync.Once{}
	e.Use(func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {
			registerOnce.Do(func() {
				for _, registeredHook := range base.GetRegisteredHookArr() {
					go registeredHook(e.Logger)
				}
			})
			if c.Request().Method == http.MethodGet {
				return next(c)
			}

			var body base.BaseRequestBody
			err := utils.CopyAndBindRequestBody(c.Request(), &body)
			if err != nil {
				return err
			}

			if body.Wg.ClientRequest == nil {
				body.Wg.ClientRequest = &base.ClientRequest{
					Method:     c.Request().Method,
					RequestURI: c.Request().RequestURI,
					Headers:    map[string]string{},
				}
			} else {
				for name, value := range body.Wg.ClientRequest.Headers {
					if _, ok := c.Request().Header[name]; !ok {
						c.Request().Header.Set(name, value)
					}
				}
			}
			reqId := c.Request().Header.Get("x-request-id")
			internalClient := base.InternalClientFactoryCall(map[string]string{"x-request-id": reqId}, body.Wg.ClientRequest, body.Wg.User)
			internalClient.Queries = internalQueries
			internalClient.Mutations = internalMutations
			brc := &base.BaseRequestContext{
				Context:        c,
				User:           body.Wg.User,
				InternalClient: internalClient,
			}
			return next(brc)
		}
	})

	for _, routerFunc := range base.GetEchoRouterFuncArr() {
		routerFunc(e)
	}

	e.Server.BaseContext = func(_ net.Listener) context.Context {
		healthReport = &base.HealthReport{Time: time.Now()}
		for _, healthFunc := range base.GetHealthFuncArr() {
			go healthFunc(e, address, healthReport)
		}
		return context.Background()
	}
	// 健康检查
	e.GET("/health", func(c echo.Context) error {
		return c.JSON(http.StatusOK, map[string]interface{}{
			"status": "ok",
			"report": healthReport,
		})
	})

	return e
}

func startServer() error {
	// 配置服务器
	wdgServer := configureWunderGraphServer()

	// 启动服务器
	go func() {
		serverListen := types.WdgGraphConfig.Api.ServerOptions.Listen
		address = utils.GetConfigurationVal(serverListen.Host) + ":" + utils.GetConfigurationVal(serverListen.Port)
		if err := wdgServer.Start(address); err != nil {
			panic(err)
		}
	}()

	// 等待终止信号
	stop := make(chan os.Signal)
	signal.Notify(stop, syscall.SIGINT, syscall.SIGTERM)
	<-stop

	// 优雅地关闭服务器
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if err := wdgServer.Shutdown(ctx); err != nil {
		panic(err)
	}

	return nil
}
