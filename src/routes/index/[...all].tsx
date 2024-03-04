import { Empty, Spin } from 'antd'
import { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom'

import { client } from '@/api'
import AMISRender from '@/components/AMISRender'

const DynamicPage = () => {
  const params = useParams()
  const path = params['*']
  const [loading, setLoading] = useState(false)
  const [schema, setSchema] = useState<string | undefined>()

  useEffect(() => {
    if (!path) {
      setLoading(false)
      return
    }
    setLoading(true)
    client
      .query({
        operationName: 'menu/findMenuByPath',
        input: {
          path: `/${path}`
        }
      })
      .then(resp => {
        setLoading(false)
        if (!resp.error) {
          setSchema(resp.data!.data?.schema)
        }
      })
  }, [path])

  if (loading) {
    return (
      <div className="w-full h-full flex items-center justify-center">
        <Spin></Spin>
      </div>
    )
  }
  if (!schema) {
    return (
      <div className="w-full h-full flex items-center justify-center">
        <Empty description="页面不存在" />
      </div>
    )
  }
  return <AMISRender schema={JSON.parse(schema)} />
}

export default DynamicPage
