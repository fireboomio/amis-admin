import type { AxiosError } from 'axios'
import axios from 'axios'

const instance = axios.create({
  timeout: 30 * 1000
})

// 处理graphql报错信息
instance.interceptors.response.use(response => {
  if (Array.isArray(response.data.errors) && response.data.errors.length > 0) {
    // 若存在错误信息，返回第一个错误信息
    return Promise.reject(response.data.errors[0])
  }
  return response.data
})

// 处理常规的返回报错信息
instance.interceptors.response.use(undefined, (error: AxiosError) => {
  return Promise.reject({
    ...error,
    message: error.response?.data as string || error.message
  })
})

export default instance
