package createOne

import (
	"custom-go/generated"
	latest "custom-go/generated/latest"
	"custom-go/pkg/base"
	"fmt"
	"github.com/spf13/cast"
	"strings"
)

const codeGroupLength = 5

type areaFindNameRespData = generated.Area__findNamesResponseData

func MutatingPreResolve(_ *base.HookRequest, body generated.Area__createOneBody) (res generated.Area__createOneBody, err error) {
	var (
		address    []string
		parentCode string
		maxSubCode string
	)
	if parentCode = body.Input.ParentCode; len(parentCode) > 0 {
		// 将parentCode按照5位一组拆分成数组
		parentCodes := makeCodeArray(body.Input.ParentCode, codeGroupLength)
		var parentNamesResp areaFindNameRespData
		parentNamesResp, err = latest.Area__findNames.Execute(generated.Area__findNamesInternalInput{Codes: parentCodes})
		if err != nil {
			return
		}

		address = parentNamesResp.Data
	}

	// 将当前区域的名称添加到地址后面
	body.Input.Address = strings.Join(append(address, body.Input.Name), "/")
	maxSubCodeResp, err := latest.Area__findMaxSubCode.Execute(generated.Area__findMaxSubCodeInternalInput{ParentCode: parentCode})
	if err != nil {
		return
	}

	maxSubCode = maxSubCodeResp.Data
	if maxSubCodeLen := len(maxSubCode); maxSubCodeLen > codeGroupLength {
		// 截取最后五位防止在转换成int时溢出
		maxSubCode = maxSubCode[maxSubCodeLen-codeGroupLength:]
	}
	maxSubCode = fmt.Sprintf("%0*d", codeGroupLength, cast.ToInt64(maxSubCode)+1)
	body.Input.Code = parentCode + maxSubCode
	return body, nil
}

func makeCodeArray(code string, index int) (codes []string) {
	if len(code) < index {
		return
	}

	codes = append(codes, code[:index])
	codes = append(codes, makeCodeArray(code, index+codeGroupLength)...)
	return
}
