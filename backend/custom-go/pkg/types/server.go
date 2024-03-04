package types

import (
	"custom-go/pkg/base"
	"custom-go/pkg/plugins"
)

var WdgHooksAndServerConfig WunderGraphHooksAndServerConfig

type WunderGraphHooksAndServerConfig struct {
	Webhooks       WebhooksConfig
	Hooks          HooksConfiguration
	GraphqlServers []plugins.GraphQLServerConfig
	Options        ServerOptions
}

type WebhooksConfig map[string]WebhookConfiguration

type WebhookConfiguration struct {
	Verifier
}

type WebhookVerifierKind int

type Verifier struct {
	kind                  WebhookVerifierKind
	secret                EnvironmentVariable[string]
	signatureHeader       string
	signatureHeaderPrefix string
}

type EnvironmentVariable[DefaultValue string] struct {
	Name         string
	DefaultValue DefaultValue
}

type HooksConfiguration struct {
	Global         plugins.GlobalConfiguration
	Authentication plugins.AuthenticationConfiguration
	Queries        base.OperationHooks
	Mutations      base.OperationHooks
	Subscriptions  base.OperationHooks
	Uploads        map[string]plugins.UploadHooks
}

type ServerOptions struct {
	ServerUrl InputVariable
	Listen    ListenOptions
	Logger    ServerLogger
}

type ListenOptions struct {
	Host InputVariable
	Port InputVariable
}

type ServerLogger struct {
	Level InputVariable
}

type PlaceHolder struct {
	Name       string
	Identifier string
}

type InputVariable any
