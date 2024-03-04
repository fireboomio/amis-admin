package base

import (
	"bytes"
	"encoding/json"
	"net/http"
)

type Record[K comparable, T any] map[K]T

type BaseRequestBody struct {
	Wg BaseRequestBodyWg `json:"__wg"`
}

type BaseRequestBodyWg struct {
	ClientRequest *ClientRequest   `json:"clientRequest"`
	User          *WunderGraphUser `json:"user"`
}

type ClientRequest struct {
	Method     string            `json:"method"`
	RequestURI string            `json:"requestURI"`
	Headers    map[string]string `json:"headers"`
	Body       json.RawMessage   `json:"body"`
	OriginBody []byte            `json:"originBody"`
}

type ClientResponse struct {
	ClientRequest
	Status     string `json:"status"`
	StatusCode int    `json:"statusCode"`
}

func (r *ClientRequest) NewRequest() *http.Request {
	req, _ := http.NewRequest(r.Method, r.RequestURI, bytes.NewReader(r.OriginBody))
	for k, v := range r.Headers {
		req.Header.Set(k, v)
	}
	return req
}

func (r *ClientResponse) Header() http.Header {
	return make(http.Header)
}

func (r *ClientResponse) Write(i []byte) (int, error) {
	r.OriginBody = append(r.OriginBody, i...)
	return len(i), nil
}

func (r *ClientResponse) WriteHeader(statusCode int) {
	r.StatusCode = statusCode
}
