package utils

import (
	"bufio"
	"bytes"
	"encoding/json"
	"errors"
	"io"
	"net"
	"net/http"
	"net/http/httputil"
	"time"
)

func CopyAndBindRequestBody(request *http.Request, result any) (err error) {
	dumpBytes, err := httputil.DumpRequest(request, true)
	if err != nil {
		return err
	}

	requestCopy, err := http.ReadRequest(bufio.NewReader(bytes.NewReader(dumpBytes)))
	if err != nil {
		return err
	}

	bodyBytes, err := io.ReadAll(requestCopy.Body)
	if err != nil {
		return err
	}

	return json.Unmarshal(bodyBytes, &result)
}

func GetIp4() (ip string, err error) {
	addrs, err := net.InterfaceAddrs()
	if err != nil {
		return
	}
	for _, addr := range addrs {
		if ipNet, ok := addr.(*net.IPNet); ok && !ipNet.IP.IsLoopback() {
			if ipNet.IP.To4() != nil {
				ip = ipNet.IP.String()
				break
			}
		}
	}
	return
}

func HttpPost(url string, reqBody []byte, headers map[string]string, timeout ...int) (respBody []byte, err error) {
	r, err := http.NewRequest(http.MethodPost, url, bytes.NewReader(reqBody))
	if err != nil {
		return
	}

	for k, v := range headers {
		r.Header.Add(k, v)
	}

	client := &http.Client{}
	if len(timeout) > 0 {
		client.Timeout = time.Duration(timeout[0]) * time.Second
	}

	resp, err := client.Do(r)
	if err != nil {
		return
	}

	respBody, err = io.ReadAll(resp.Body)
	if err != nil {
		return
	}

	if resp.StatusCode != http.StatusOK {
		err = errors.New(string(respBody))
		respBody = nil
		return
	}

	return
}
