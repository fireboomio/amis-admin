import { Path, StoreKey } from '@/constants'

import { tokenStorage } from './storage'

export function expiredLogin() {
  window.location.href = Path.Login + '?expired=1'
  tokenStorage.removeItem(StoreKey.AccessToken)
  tokenStorage.removeItem(StoreKey.RefreshToken)
}
