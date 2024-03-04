export enum StoreKey {
  TokenStorageType = 'token.store',
  AccessToken = 'access.token',
  RefreshToken = 'access.refresh'
}

export enum Path {
  Home = '/',
  Forbidden = '/403',
  Dashboard = '/dashboard',
  Login = '/login',
  Profile = '/profile',
  ProfileBasic = '/profile/basic',
  ProfileSecurity = '/profile/security'
}

export const PUBLIC_PATH = '/'
