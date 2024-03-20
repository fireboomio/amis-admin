import { LogoutOutlined, UserOutlined } from '@ant-design/icons'
import { DefaultFooter, PageContainer } from '@ant-design/pro-components'
import { Dropdown, Spin, theme } from 'antd'
import { Suspense, useEffect } from 'react'
import { Outlet, useLocation, useNavigate } from 'react-router-dom'

import FBLogo from '@/assets/fb-logo.png'
import { Path } from '@/constants'
import AdminLayout from '@/layouts/AdminLayout'
import { useAuth } from '@/store/auth'

const { useToken } = theme

const pathWhiteList = [Path.Login.toString(), Path.Home.toString(), Path.Forbidden.toString()]

export default function Layout() {
  const navigate = useNavigate()
  const {
    computed: { username, avatar, availableRoutes, logged },
    getGroupedMenus,
    logout
  } = useAuth()
  const { pathname } = useLocation()
  const token = useToken()

  useEffect(() => {
    if (
      logged &&
      !(
        pathWhiteList.includes(pathname) ||
        pathname.startsWith(Path.Profile) ||
        availableRoutes.includes(pathname)
      )
    ) {
      navigate(Path.Forbidden, { replace: true })
    }
  }, [availableRoutes, navigate, pathname, logged])

  return (
    <AdminLayout
      title="Admin"
      logo={<img src={FBLogo} alt="logo" />}
      loading={false}
      // layout="mix"
      siderWidth={216}
      waterMarkProps={{
        content: username ?? 'Fireboom'
      }}
      location={{ pathname }}
      avatarProps={{
        src: avatar,
        size: 'small',
        title: username,
        render: (_, dom) => {
          return (
            <Dropdown
              menu={{
                items: [
                  {
                    key: 'profile',
                    icon: <UserOutlined />,
                    label: '个人中心',
                    onClick: () => navigate(Path.Profile)
                  },
                  {
                    key: 'logout',
                    icon: <LogoutOutlined />,
                    label: '退出登录',
                    onClick: () => logout()
                  }
                ]
              }}
            >
              {dom}
            </Dropdown>
          )
        }
      }}
      menu={{
        locale: false,
        async request() {
          return getGroupedMenus(true)
        }
      }}
      footerRender={() => <DefaultFooter copyright="2023 Fireboom.io" />}
      token={{
        sider: {
          colorMenuBackground: token.token.colorBgBase,
          colorTextMenuSelected: token.token.colorPrimary,
          colorBgMenuItemSelected: token.token.colorPrimaryBg
        }
      }}
    >
      <PageContainer
        className="overflow-x-hidden min-h-160"
        header={{
          title: null
        }}
      >
        <Suspense fallback={<Spin className="w-full h-full"></Spin>}>
          <Outlet />
        </Suspense>
      </PageContainer>
    </AdminLayout>
  )
}
