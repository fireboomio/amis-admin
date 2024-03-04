import type { RendererEnv, RenderOptions } from 'amis'
import { message, notification } from 'antd'
import axios from 'axios'
import _copy from 'copy-to-clipboard'
import { format, parse } from 'url'

import { StoreKey } from '@/constants'

import { tokenStorage } from './storage'

export const theme = 'antd'

// 自定义url处理
const customParamsSerializer = (originalUrl: string, newParams: any) => {
  // 解析原始 URL
  const parsedUrl = parse(originalUrl, true)
  // 判断是否有 orderBy, orderDir, page, perPage 参数，并进行处理
  const { orderBy, orderDir, page, perPage, ...rest } = parsedUrl.query
  newParams = newParams || {}
  // 更新其他参数
  Object.keys(rest).forEach(key => {
    if (rest[key] !== '' && rest[key] !== null) {
      newParams[key] = rest[key]
    }
  })
  // 处理 orderBy, orderDir, page, perPage
  if (page && perPage) {
    newParams.take = perPage
    newParams.skip = (+page - 1) * +perPage
  }
  if (orderBy && orderDir) {
    newParams.orderBy = JSON.stringify({
      [orderBy as string]: orderDir
    })
  }

  // 重新构建新的 URL
  const newUrl = format({
    ...parsedUrl,
    search: undefined, // 清除原始 search，因为已经在 query 中更新了参数
    query: newParams
  })

  return newUrl
}

// @ts-ignore
export const fetcher: RenderOptions['fetcher'] = ({ url, method, data, config, headers }) => {
  config = config || {}
  config.headers = config.headers || headers || {}
  // config.withCredentials = true;
  method = method || 'get'

  const token = tokenStorage.getItem(StoreKey.AccessToken)
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }

  if (method !== 'post' && method !== 'put' && method !== 'patch') {
    let newUrl = customParamsSerializer(url, data)
    return (axios as any)[method](newUrl, config)
  } else if (data && data instanceof FormData) {
    // config.headers = config.headers || {};
    // config.headers['Content-Type'] = 'multipart/form-data';
  } else if (
    data &&
    typeof data !== 'string' &&
    !(data instanceof Blob) &&
    !(data instanceof ArrayBuffer)
  ) {
    data = JSON.stringify(data)
    config.headers['Content-Type'] = 'application/json'
  }

  return (axios as any)[method](url, data, config)
}

export const notify: RendererEnv['notify'] = (type, msg) => {
  if (message[type]) {
    message[type](msg)
  } else {
    console.warn('[Notify]', type, msg)
  }
  console.log('[notify]', type, msg)
}

export const alert: RendererEnv['alert'] = (msg, title) => {
  notification.error({
    message: title,
    description: msg
  })
}

export const copy: RendererEnv['copy'] = (contents, options = {}) => {
  const ret = _copy(contents, options)
  ret && (!options || options.shutup !== true) && message.info('内容已拷贝到剪切板')
  return ret
}

const amisCssList = ['antd.css', 'helper.css', 'iconfont.css']
export function injectAmisCss() {
  amisCssList.forEach(file => {
    const link = document.createElement('link')
    link.rel = 'stylesheet'
    link.href = import.meta.env.BASE_URL + `amis/${file}`
    link.id = `amis-css-${file}`
    document.head.appendChild(link)
  })
  return () => {
    amisCssList.forEach(file => {
      const link = document.getElementById(`amis-css-${file}`)
      if (link) {
        document.head.removeChild(link)
      }
    })
  }
}
