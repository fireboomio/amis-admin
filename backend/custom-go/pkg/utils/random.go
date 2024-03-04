package utils

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
	"unsafe"
)

const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

var (
	src  = rand.NewSource(time.Now().UnixNano())
	lock sync.Mutex
)

const (
	// 6 bits to represent a letter index
	letterIdBits = 6
	// All 1-bits as many as letterIdBits
	letterIdMask = 1<<letterIdBits - 1
	letterIdMax  = 63 / letterIdBits
)

func RandStr(n int) string {
	b := make([]byte, n)
	// A rand.Int63() generates 63 random bits, enough for letterIdMax letters!
	for i, cache, remain := n-1, src.Int63(), letterIdMax; i >= 0; {
		if remain == 0 {
			cache, remain = src.Int63(), letterIdMax
		}
		if idx := int(cache & letterIdMask); idx < len(letters) {
			b[i] = letters[idx]
			i--
		}
		cache >>= letterIdBits
		remain--
	}
	return *(*string)(unsafe.Pointer(&b))
}

func GenOrderNumber() string {
	lock.Lock()
	defer lock.Unlock()

	// 当前时间
	now := time.Now()

	// 时间格式化
	datePart := now.Format("20060102150405")

	// 生成一个随机数
	randPart := rand.Intn(999999)

	// 格式化随机数，如果不足6位则在前面补0
	randString := fmt.Sprintf("%06v", randPart)

	// 拼接生成订单号
	orderID := fmt.Sprintf("%s%s", datePart, randString)

	return orderID
}
