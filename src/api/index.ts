import { message } from 'antd'

import { StoreKey } from '@/constants'
import { tokenStorage } from '@/utils/storage'
import { expiredLogin } from '@/utils/token'

import { createClient } from './client'

const omitUrls = ['/operations/user/casdoor/login', '/operations/user/casdoor/sendCode']
const refreshUrl = '/operations/user/casdoor/refreshToken'

let refreshPromise: Promise<string | null> | null = null

export const client = createClient({
  // requestInterceptor({ url, init }) {
  //   const skipValidate = omitUrls.some(u => url.startsWith(u))
  //   const revalidateParam = skipValidate ? '' : '&revalidate'
  //   const _url = `${url}${revalidateParam}`
  //   return { url: _url, init }
  // },
  // response 拦截
  async responseInterceptor({ url, init, response }) {
    const skipValidate = omitUrls.some(u => url.startsWith(u))

    function onInvalid() {
      expiredLogin()
      return new Response(new Blob(), { status: 401, statusText: '登录失效，请重新登录' })
    }

    async function reloadRequest(newToken: string) {
      client.setAuthorizationToken(newToken)
      // 带上之前的参数重新请求
      if (init.headers) {
        ;(init.headers as Record<string, string>)['Authorization'] = `Bearer ${newToken}`
      }
      const resp = await fetch(url, init)
      // 如果仍然401，则认为 refresh token 也过期了
      if (resp.status === 401) {
        return onInvalid()
      }
      return resp
    }

    if (!skipValidate) {
      // 处理登录失效的情况
      if (response.status === 401) {
        if (refreshPromise && !url.startsWith(refreshUrl)) {
          const accessToken = await refreshPromise
          if (accessToken) {
            return await reloadRequest(accessToken)
          }
        }
        // 尝试refreshToken
        const refreshToken = tokenStorage.getItem(StoreKey.RefreshToken)
        if (refreshToken) {
          let _resolve: (value: string | null) => void = () => {}
          refreshPromise = new Promise(resolve => {
            _resolve = resolve
          })
          const { error, data } = await client.mutate({
            operationName: 'user/casdoor/refreshToken',
            input: {
              refreshToken: refreshToken
            }
          })
          if (error) {
            _resolve(null)
            return onInvalid()
          } else {
            if (!data?.data?.data) {
              _resolve(null)
              return onInvalid()
            }
            const { accessToken, refreshToken } = data!.data!.data!
            if (!accessToken) {
              _resolve(null)
              return onInvalid()
            }
            _resolve(accessToken)
            if (refreshToken) {
              tokenStorage.setItem(StoreKey.RefreshToken, refreshToken)
            }
            tokenStorage.setItem(StoreKey.AccessToken, accessToken)
            return await reloadRequest(accessToken)
          }
        } else {
          return onInvalid()
        }
      }
    }
    const clonedResp = response.clone()
    if (!clonedResp.ok) {
      const text = await clonedResp.text()
      message.error(text || clonedResp.statusText)
      return response
    }
    try {
      const clonedBody = await clonedResp.json()
      const { errors } = clonedBody
      // 统一处理错误显示
      if (errors[0].message) {
        message.error(errors[0].message)
      }
    } catch (error) {
      //
    }
    return response
  },
  baseURL: '',
  requestTimeoutMs: 30 * 1000
})
