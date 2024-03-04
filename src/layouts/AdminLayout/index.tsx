import './index.scss'

import { LeftOutlined, MenuOutlined, UserOutlined } from '@ant-design/icons'
import type { MenuDataItem, ProLayoutProps } from '@ant-design/pro-components'
import { useRequest } from 'ahooks'
import type { MenuProps } from 'antd'
import { Avatar, ConfigProvider, Drawer, Menu, Spin, Watermark } from 'antd'
import clsx from 'clsx'
import { useMemo, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'

import SVGIcon from '@/components/AdminIcons/SVGIcon'
import { Path } from '@/constants'
import { useDisclosure } from '@/hooks'
import { useAdmin } from '@/store/admin'
/**
 * 模拟 ProLayout，ant pro components 里的 ProLayout 有点问题，会导致每次打开新页面都会报错，刷新后才可解决
 */

type AdminLayoutProps = Pick<
  ProLayoutProps,
  | 'title'
  | 'logo'
  | 'loading'
  | 'siderWidth'
  | 'waterMarkProps'
  | 'location'
  | 'avatarProps'
  | 'menu'
  | 'menuItemRender'
  | 'footerRender'
  | 'token'
  | 'children'
  | 'className'
>

type AntMenuItem = Required<MenuProps>['items'][number]

const AdminLayout = (props: AdminLayoutProps) => {
  const navigate = useNavigate()
  const [mobileMenuOpened, { open: openMobileMenu, close: closeMobileMenu }] = useDisclosure()
  const { isMobile } = useAdmin()
  const [collapsed, setCollapsed] = useState(false)
  const menuRequest = useRequest<MenuProps['items'], []>(async () => {
    if (props.menu?.request) {
      const resp = await props.menu.request({}, [])
      return resp.map(item => convertMenu(item))
    }
  })
  const usernameAndAvatar = useMemo(
    () =>
      props.avatarProps ? (
        <div className="flex items-center h-full">
          <Avatar
            src={props.avatarProps.src}
            icon={props.avatarProps.src ? undefined : props.avatarProps.icon ?? <UserOutlined />}
            size={props.avatarProps.size}
            alt="avatar"
          />
          {props.avatarProps?.title && (
            <span className="ml-2 text-sm">{props.avatarProps?.title}</span>
          )}
        </div>
      ) : null,
    [props.avatarProps]
  )
  const defaultOpenMenus = useMemo(() => {
    if (props.location?.pathname) {
      return props.location.pathname
        .split('/')
        .slice(1)
        .reduce<string[]>((acc, cur) => {
          acc.push(`${acc.length ? acc[acc.length - 1] : ''}/${cur}`)
          return acc
        }, [])
    }
  }, [props.location])

  function convertMenu(menu: MenuDataItem): AntMenuItem {
    const itemRender = props.menuItemRender
    const ret: AntMenuItem = {
      // @ts-ignore
      label: itemRender ? itemRender(menu, menu.name, { collapsed }) : menu.name,
      key: menu.key || menu.path || '',
      icon: menu.icon ? <SVGIcon className="w-4 h-4" url={menu.icon as string} /> : undefined
    }
    if (menu.children?.length) {
      // @ts-ignore
      ret.children = menu.children.map(child => convertMenu(child, itemRender))
    }
    return ret
  }

  const menu$ = (
    <ConfigProvider
      theme={{
        components: {
          Menu: {
            activeBarBorderWidth: 0,
            subMenuItemBg: 'transparent',
            collapsedWidth: 48,
            colorText: 'rgba(0,0,0,65%)',
            groupTitleColor: 'rgba(0,0,0,65%)'
          }
        }
      }}
    >
      <Spin spinning={menuRequest.loading}>
        {/* @ts-ignore */}
        <Menu
          className="min-h-25"
          // mode={isMenuOpen ? 'inline' : 'vertical'}
          mode="inline"
          inlineCollapsed={collapsed}
          inlineIndent={16}
          items={menuRequest.data ?? []}
          selectedKeys={props.location?.pathname ? [props.location?.pathname] : []}
          defaultOpenKeys={defaultOpenMenus}
          onClick={e => {
            navigate(e.key)
            if (isMobile) {
              closeMobileMenu()
            }
          }}
        />
      </Spin>
    </ConfigProvider>
  )

  const collapseIcon = (
    <div
      className={clsx(
        'admin-layout-sider-toggler absolute -right-3 shadow cursor-pointer rounded-2xl bg-white w-6 h-6 inline-flex items-center justify-center z-100',
        isMobile ? 'top-4' : 'top-24'
      )}
      onClick={() => {
        if (isMobile) {
          closeMobileMenu()
        } else {
          setCollapsed(!collapsed)
        }
      }}
    >
      <LeftOutlined className={clsx('transition w-2.5 h-2.5', collapsed ? 'rotate-180' : '')} />
    </div>
  )

  return (
    <Spin spinning={props.loading}>
      <div className={clsx('admin-layout w-full relative', props.className)}>
        <div className="admin-layout-bg" />
        <header className="admin-layout-header fixed left-0 w-full top-0 flex items-center h-14 px-4 z-100">
          {isMobile && (
            <MenuOutlined className="cursor-pointer mr-4 text-lg" onClick={openMobileMenu} />
          )}
          {(props.logo || props.title) && (
            <div className="admin-layout-header-logo">
              <Link to={Path.Home} className="flex items-center min-h-22px text-20px">
                {props.logo}
                {props.title && (
                  <h1 className="ml-2 h-8 text-lg leading-8 font-600">{props.title}</h1>
                )}
              </Link>
            </div>
          )}
          {props.avatarProps && (
            <div className="admin-layout-header-avatar h-full inline-flex items-center justify-center px-3 cursor-pointer ml-auto">
              {props.avatarProps.render
                ? props.avatarProps.render({}, usernameAndAvatar)
                : usernameAndAvatar}
            </div>
          )}
        </header>
        {isMobile && (
          <Drawer
            placement="left"
            width={200}
            closable={false}
            open={mobileMenuOpened}
            onClose={closeMobileMenu}
            styles={{
              body: {
                padding: 0
              }
            }}
          >
            {menu$}
            {collapseIcon}
          </Drawer>
        )}
        <div className="flex flex-1 h-screen">
          {!isMobile && (
            <aside className="h-full flex flex-col relative">
              <div className="h-14 bg-white z-1"></div>
              <div
                className="admin-layout-sider flex-1 px-2 relative bg-white overflow-x-hidden overflow-y-auto"
                style={{
                  width: !collapsed
                    ? props.siderWidth
                      ? `${props.siderWidth}px`
                      : '216px'
                    : '64px'
                }}
              >
                {menu$}
              </div>
              {collapseIcon}
            </aside>
          )}
          <main className="admin-layout-main flex-1 min-w-0">
            <div className="h-full overflow-x-hidden overflow-y-auto">
              <div className="h-14 bg-white z-1"></div>
              {props.waterMarkProps?.content ? (
                <Watermark content={props.waterMarkProps?.content}>{props.children}</Watermark>
              ) : (
                props.children
              )}
              {props.footerRender && (
                <div className="relative">{props.footerRender!({}, null)}</div>
              )}
            </div>
          </main>
        </div>
      </div>
    </Spin>
  )
}

export default AdminLayout
