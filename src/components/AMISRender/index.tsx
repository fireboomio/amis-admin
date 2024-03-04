// import 'amis/sdk/antd.css'
// import 'amis/sdk/helper.css'
// import 'amis/sdk/iconfont.css'
import { render as amisRender } from 'amis'
import { useEffect } from 'react'
import { useLocation, useParams, useSearchParams } from 'react-router-dom'

import { StoreKey } from '@/constants'
import { useAdmin } from '@/store/admin'
import { alert, copy, fetcher, injectAmisCss, notify, theme } from '@/utils/amis'
import { tokenStorage } from '@/utils/storage'
interface AMISRenderProps {
  locale?: string
  schema: any
  transform?: Function
  session?: string
  [key: string]: any
}

const AMISRender = ({ locale = 'zh-CN', schema, transform, session, ...rest }: AMISRenderProps) => {
  const adminStore = useAdmin()
  const params = useParams()
  const { pathname } = useLocation()
  const [searchParams] = useSearchParams()
  const _schema = schema.type ? schema : { type: 'page', ...schema }

  useEffect(() => {
    // return injectAmisCss()
  }, [])

  return amisRender(
    _schema,
    {
      locale,
      data: {
        pathname,
        query: Object.fromEntries(searchParams),
        params,
        TOKEN: tokenStorage.getItem(StoreKey.AccessToken),
        BASE_URL: '',
        adminStore
      },
      propsTransform: transform,
      ...rest
    },
    {
      fetcher,
      isCancel: (value: any) => !!value.__CANCEL__,
      notify,
      alert,
      copy,
      theme
    }
  )
}

export default AMISRender
