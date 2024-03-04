package base

import (
	"context"
	"github.com/labstack/echo/v4"
	"net/http"
	"sync"
	"time"
)

type OperationDefinitions Record[string, InternalRequestFunction]

type OperationArgsWithInput[I any] struct {
	Input I `json:"input"`
}

type InternalRequestFunction func(*InternalClientRequestContext, OperationArgsWithInput[any]) (any, error)

type InternalClientFactory func(map[string]string, ClientRequest) *InternalClient

func InternalClientFactoryCall(headers map[string]string, clientRequest *ClientRequest, user *WunderGraphUser) *InternalClient {
	client := &InternalClient{
		Context: &InternalClientRequestContext{
			ExtraHeaders:  headers,
			ClientRequest: clientRequest,
			User:          user,
		},
	}
	client.WithHeaders = func(headers map[string]string) *InternalClient {
		client.Context.ExtraHeaders = headers
		return client
	}
	return client
}

type InternalClientRequestContext struct {
	ExtraHeaders  map[string]string
	ClientRequest *ClientRequest
	User          *WunderGraphUser
}

type InternalClient struct {
	WithHeaders func(map[string]string) *InternalClient
	Context     *InternalClientRequestContext
	Queries     OperationDefinitions
	Mutations   OperationDefinitions
}

type GraphqlRequestContext struct {
	context.Context
	User           *WunderGraphUser
	InternalClient *InternalClient
	Logger         echo.Logger
	Result         *ResultChan
	Request        *http.Request
}

type ResultChan struct {
	Data  chan []byte
	Error chan []byte
	Done  chan []byte
}

type BaseRequestContext struct {
	echo.Context
	User           *WunderGraphUser
	InternalClient *InternalClient
	Headers        map[string]string
}

type AuthenticationHookRequest = BaseRequestContext
type HookRequest = BaseRequestContext
type HttpTransportHookRequest = BaseRequestContext
type WsTransportHookRequest = BaseRequestContext

type UploadHookRequest = BaseRequestContext

type (
	registeredHook func(echo.Logger)
	healthFunc     func(*echo.Echo, string, *HealthReport)
	HealthReport   struct {
		Customizes []string  `json:"customizes"`
		Functions  []string  `json:"functions"`
		Proxys     []string  `json:"proxys"`
		Time       time.Time `json:"time"`
		sync.Mutex
	}
	routerFunc func(e *echo.Echo)
)

var (
	registeredHookArr []registeredHook
	healthFuncArr     []healthFunc
	routerFuncArr     []routerFunc
)

func GetRegisteredHookArr() []registeredHook {
	return registeredHookArr
}

func GetHealthFuncArr() []healthFunc {
	return healthFuncArr
}

func GetEchoRouterFuncArr() []routerFunc {
	return routerFuncArr
}

func AddRegisteredHook(hook registeredHook) {
	registeredHookArr = append(registeredHookArr, hook)
}

func AddHealthFunc(f healthFunc) {
	healthFuncArr = append(healthFuncArr, f)
}

func AddEchoRouterFunc(f routerFunc) {
	routerFuncArr = append(routerFuncArr, f)
}
