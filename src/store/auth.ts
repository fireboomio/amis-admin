import type { MenuDataItem } from '@ant-design/pro-components'
import { message } from 'antd'
import { groupBy } from 'lodash-es'
import { create } from 'zustand'

import { client } from '@/api'
import type {
  user__casdoor__updateUserInput,
  user__meResponseData_data,
  user__meResponseData_data_menus
} from '@/api/models'
import { Casdoor_login_post_input_object_loginType_enum as LoginType } from '@/api/models'
import { Path, StoreKey } from '@/constants'
import { setTokenStorage, tokenStorage, TokenStorageKey } from '@/utils/storage'

type User = user__meResponseData_data

export { LoginType }

async function fetchMe() {
  const resp = await client.query({
    operationName: 'user/me'
  })
  if (!resp.error) {
    const user = resp.data!.data!
    // 处理用户被删除但是仍然能返回的情况
    if (user.id) {
      return { user, error: null }
    }
  }
  return { user: null, error: resp.error }
}

export type AuthState = {
  accessToken: string | null
  user: User | null
  ready: boolean
  loading: boolean
  computed: {
    logged: boolean
    username?: string
    avatar?: string
    roles: string[]
    availableRoutes: string[]
  }
  init: () => Promise<User | null>
  login: (
    type: LoginType,
    args: {
      username?: string
      password?: string
      phone?: string
      code?: string
      rememberMe?: boolean
    }
  ) => Promise<[boolean, User | Error]>
  logout: (showMsg?: boolean) => void
  getGroupedMenus: (
    inMenu: boolean,
    keyValueField?: keyof user__meResponseData_data_menus,
    keyField?: string,
    labelField?: string,
    showPermissionCode?: boolean
  ) => MenuDataItem[]
  refreshMe: () => Promise<User | null>
  updateMyInfo: (args: Omit<user__casdoor__updateUserInput, 'userId'>) => Promise<boolean>
  updateMyPassword: (newPassword: string) => Promise<boolean>
}

export const useAuth = create<AuthState>((set, get) => ({
  accessToken: null,
  user: null,
  ready: false,
  loading: false,
  computed: {
    get logged() {
      return Boolean(get().user)
    },
    get username() {
      return get().user?.name
    },
    get avatar() {
      return get().user?.avatar
    },
    get roles() {
      return get().user?.roles || []
    },
    get availableRoutes() {
      return (
        get().user?.menus.reduce<string[]>((arr, m) => {
          if (m.path) {
            arr.push(m.path)
          }
          return arr
        }, []) ?? []
      )
    }
  },
  getGroupedMenus(inMenu, keyValueField = 'path', keyField = 'path', labelField = 'name', showPermissionCode = false) {
    const menus = get().user?.menus ?? []
    const grouped = groupBy(inMenu ? menus.filter(m => m.visibleInMenu) : menus, m =>
      m.parentId === 0 ? null : m.parentId
    )
    function childrenOf(parentId: number | null): MenuDataItem[] {
      return (grouped[parentId || 'null'] || [])
        .sort((a, b) => (a.sort || 0) - (b.sort || 0))
        .map<MenuDataItem>(menu => ({
          [keyField]: menu[keyValueField]?.toString(),
          [labelField]: menu.label + (showPermissionCode ? ' ' + (menu?.permission ?? '') : ''),
          icon: menu.icon,
          parentId,
          children: childrenOf(menu.id)
        }))
    }
    const ret = childrenOf(null)
    return ret
  },
  async init() {
    set({ loading: true })
    // 先读取token存在哪里
    const tokenStoreType = localStorage.getItem(StoreKey.TokenStorageType)
    if (tokenStoreType === TokenStorageKey.SessionStorage) {
      setTokenStorage('sessionStorage')
    }
    const accessToken = tokenStorage.getItem(StoreKey.AccessToken)
    if (accessToken) {
      client.setAuthorizationToken(accessToken)
      const { user } = await fetchMe()
      if (user) {
        set({ accessToken, user, ready: true, loading: false })
        return user
      }
      tokenStorage.removeItem(StoreKey.AccessToken)
      tokenStorage.removeItem(StoreKey.RefreshToken)
      client.unsetAuthorization()
    }
    set({ ready: true, loading: false })
    return null
  },
  async login(loginType, { rememberMe = false, ...args }) {
    const { error, data } = await client.mutate({
      operationName: 'user/casdoor/login',
      input: {
        loginType,
        ...args
      }
    })
    if (!error) {
      const { accessToken, refreshToken } = data!.data!.data!
      client.setAuthorizationToken(accessToken!)
      const { user, error } = await fetchMe()
      if (user) {
        set({ accessToken, user })
        // 记住我用localStorage存，不记住用sessionStorage
        if (rememberMe) {
          localStorage.setItem(StoreKey.TokenStorageType, TokenStorageKey.LocalStorage)
          localStorage.setItem(StoreKey.AccessToken, accessToken!)
          // 记住refreshToken
          localStorage.setItem(StoreKey.RefreshToken, refreshToken!)
        } else {
          localStorage.setItem(StoreKey.TokenStorageType, TokenStorageKey.SessionStorage)
          sessionStorage.setItem(StoreKey.AccessToken, accessToken!)
        }
        return [true, user]
      }
      client.unsetAuthorization()
      return [false, error]
    } else {
      return [false, error]
    }
  },
  async refreshMe() {
    const { user } = await fetchMe()
    if (user) {
      set({ user })
      return user
    }
    // 退出
    get().logout(false)
    return null
  },
  logout(showMsg = true) {
    tokenStorage.removeItem(StoreKey.AccessToken)
    tokenStorage.removeItem(StoreKey.RefreshToken)
    client.unsetAuthorization()
    set({ accessToken: null, user: null })
    if (showMsg) {
      message.success('你已成功退出')
    }
    window.location.href = Path.Login
  },
  async updateMyInfo(args) {
    if (!get().computed.logged) {
      return false
    }
    const { user } = get()
    const { error } = await client.mutate({
      operationName: 'user/casdoor/updateUser',
      input: {
        userId: user!.userId!,
        ...args
      }
    })
    if (!error) {
      set({ user: { ...user!, ...args } })
      message.success('个人信息更新成功')
      return true
    }
    return false
  },
  async updateMyPassword(newPwd) {
    const { user, logout } = get()
    const { error } = await client.mutate({
      operationName: 'user/casdoor/updateUser',
      input: {
        userId: user!.userId!,
        password: newPwd
      }
    })
    if (!error) {
      message.success('密码已修改，请重新登录')
      setTimeout(() => {
        logout(false)
      }, 2000)
      return true
    } else {
      message.error('密码修改失败')
      return false
    }
  }
}))
