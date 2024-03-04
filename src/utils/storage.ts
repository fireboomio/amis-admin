export enum TokenStorageKey {
  LocalStorage = 'localStorage',
  SessionStorage = 'sessionStorage'
}

export type StorageType = 'localStorage' | 'sessionStorage'

export function createStorage(type: StorageType): Storage {
  if (type === 'localStorage') {
    return window.localStorage
  } else {
    return window.sessionStorage
  }
}

export let tokenStorage: Storage = createStorage('localStorage')

export function setTokenStorage(type: StorageType) {
  tokenStorage = createStorage(type)
}
