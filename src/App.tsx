import { ConfigProvider } from 'antd'
import zhCN from 'antd/locale/zh_CN'
import { useEffect, useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom'

import FullScreenLoading from '@/components/FullScreenLoading'

import AppRoutes from './components/AppRoutes'
import { Path } from './constants'
import { useAdmin } from './store/admin'
import { useAuth } from './store/auth'

function App() {
  const location = useLocation()
  const navigate = useNavigate()
  const {
    init: initUser,
    ready: initUserReady,
    computed: { logged }
  } = useAuth()
  const { init: initAdmin } = useAdmin()
  const [ready, setReady] = useState(false)

  useEffect(() => {
    if (initUserReady && !logged && location.pathname !== Path.Login) {
      navigate(Path.Login, { replace: true })
    }
  }, [initUserReady, location, logged, navigate])

  useEffect(() => {
    let clearFn: () => void
    initUser().then(async user => {
      if (user) {
        clearFn = initAdmin()
      } else {
        navigate(Path.Login, { replace: true })
      }
      setReady(true)
    })
    return () => {
      clearFn?.()
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  return ready ? (
    <ConfigProvider
      locale={zhCN}
      theme={{
        cssVar: true,
        hashed: false
      }}
    >
      <AppRoutes />
    </ConfigProvider>
  ) : (
    <FullScreenLoading />
  )
}

export default App
