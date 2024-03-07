export interface api__executeRawResponse<Error = any> {
  data?: api__executeRawResponseData
  error?: Error
}

export interface api__listPublicResponse<Error = any> {
  data?: api__listPublicResponseData
  error?: Error
}

export interface api__queryRawResponse<Error = any> {
  data?: api__queryRawResponseData
  error?: Error
}

export interface area__createOneResponse<Error = any> {
  data?: area__createOneResponseData
  error?: Error
}

export interface area__findManyResponse<Error = any> {
  data?: area__findManyResponseData
  error?: Error
}

export interface area__findMaxSubCodeResponse<Error = any> {
  data?: area__findMaxSubCodeResponseData
  error?: Error
}

export interface area__findNamesResponse<Error = any> {
  data?: area__findNamesResponseData
  error?: Error
}

export interface log__createOneResponse<Error = any> {
  data?: log__createOneResponseData
  error?: Error
}

export interface log__deleteManyResponse<Error = any> {
  data?: log__deleteManyResponseData
  error?: Error
}

export interface log__findManyResponse<Error = any> {
  data?: log__findManyResponseData
  error?: Error
}

export interface menu__createOneResponse<Error = any> {
  data?: menu__createOneResponseData
  error?: Error
}

export interface menu__deleteManyResponse<Error = any> {
  data?: menu__deleteManyResponseData
  error?: Error
}

export interface menu__findManyResponse<Error = any> {
  data?: menu__findManyResponseData
  error?: Error
}

export interface menu__findMenuByPathResponse<Error = any> {
  data?: menu__findMenuByPathResponseData
  error?: Error
}

export interface menu__findUniqueResponse<Error = any> {
  data?: menu__findUniqueResponseData
  error?: Error
}

export interface menu__updateOneResponse<Error = any> {
  data?: menu__updateOneResponseData
  error?: Error
}

export interface post__author__findManyResponse<Error = any> {
  data?: post__author__findManyResponseData
  error?: Error
}

export interface post__category__createOneResponse<Error = any> {
  data?: post__category__createOneResponseData
  error?: Error
}

export interface post__category__deleteManyResponse<Error = any> {
  data?: post__category__deleteManyResponseData
  error?: Error
}

export interface post__category__findManyResponse<Error = any> {
  data?: post__category__findManyResponseData
  error?: Error
}

export interface post__category__findUniqueResponse<Error = any> {
  data?: post__category__findUniqueResponseData
  error?: Error
}

export interface post__category__updateOneResponse<Error = any> {
  data?: post__category__updateOneResponseData
  error?: Error
}

export interface post__createOneResponse<Error = any> {
  data?: post__createOneResponseData
  error?: Error
}

export interface post__deleteManyResponse<Error = any> {
  data?: post__deleteManyResponseData
  error?: Error
}

export interface post__findManyResponse<Error = any> {
  data?: post__findManyResponseData
  error?: Error
}

export interface post__findUniqueResponse<Error = any> {
  data?: post__findUniqueResponseData
  error?: Error
}

export interface post__updateOneResponse<Error = any> {
  data?: post__updateOneResponseData
  error?: Error
}

export interface role__api__findManyResponse<Error = any> {
  data?: role__api__findManyResponseData
  error?: Error
}

export interface role__createOneResponse<Error = any> {
  data?: role__createOneResponseData
  error?: Error
}

export interface role__deleteManyResponse<Error = any> {
  data?: role__deleteManyResponseData
  error?: Error
}

export interface role__findManyResponse<Error = any> {
  data?: role__findManyResponseData
  error?: Error
}

export interface role__findUniqueResponse<Error = any> {
  data?: role__findUniqueResponseData
  error?: Error
}

export interface role__updateOneResponse<Error = any> {
  data?: role__updateOneResponseData
  error?: Error
}

export interface role__user__updateManyResponse<Error = any> {
  data?: role__user__updateManyResponseData
  error?: Error
}

export interface user__casdoor__addUserResponse<Error = any> {
  data?: user__casdoor__addUserResponseData
  error?: Error
}

export interface user__casdoor__loginResponse<Error = any> {
  data?: user__casdoor__loginResponseData
  error?: Error
}

export interface user__casdoor__refreshTokenResponse<Error = any> {
  data?: user__casdoor__refreshTokenResponseData
  error?: Error
}

export interface user__casdoor__sendCodeResponse<Error = any> {
  data?: user__casdoor__sendCodeResponseData
  error?: Error
}

export interface user__casdoor__updateUserResponse<Error = any> {
  data?: user__casdoor__updateUserResponseData
  error?: Error
}

export interface user__countResponse<Error = any> {
  data?: user__countResponseData
  error?: Error
}

export interface user__deleteManyResponse<Error = any> {
  data?: user__deleteManyResponseData
  error?: Error
}

export interface user__findManyResponse<Error = any> {
  data?: user__findManyResponseData
  error?: Error
}

export interface user__findUniqueResponse<Error = any> {
  data?: user__findUniqueResponseData
  error?: Error
}

export interface user__meResponse<Error = any> {
  data?: user__meResponseData
  error?: Error
}


export type role__api__findManyResponseData = {
  data: string[]
  total: number
}
export type admin_NestedIntNullableFilter = {
  equals?: number
  gt?: number
  gte?: number
  in?: number[]
  lt?: number
  lte?: number
  not?: admin_NestedIntNullableFilter
  notIn?: number[]
}
export type admin_NestedDateTimeFilter = {
  equals?: string
  gt?: string
  gte?: string
  in?: string[]
  lt?: string
  lte?: string
  not?: admin_NestedDateTimeFilter
  notIn?: string[]
}
export type admin_userOrderByWithRelationInput = {
  admin_log?: admin_admin_logOrderByRelationAggregateInput
  avatar?: Admin_SortOrder
  country_code?: Admin_SortOrder
  created_at?: Admin_SortOrder
  id?: Admin_SortOrder
  name?: Admin_SortOrder
  password?: Admin_SortOrder
  password_salt?: Admin_SortOrder
  password_type?: Admin_SortOrder
  phone?: Admin_SortOrder
  updated_at?: Admin_SortOrder
  user_id?: Admin_SortOrder
}
export type post__category__createOneInput = {
  name: string
}
export type role__findManyInput = {
  code?: string
  name?: string
  orderBy?: admin_admin_roleOrderByWithRelationInput[]
  skip?: number
  take?: number
}
export type admin_DateTimeFilter = {
  equals?: string
  gt?: string
  gte?: string
  in?: string[]
  lt?: string
  lte?: string
  not?: admin_NestedDateTimeFilter
  notIn?: string[]
}
export type menu__findMenuByPathInput = {
  path: string
}
export type user__casdoor__updateUserInput = {
  avatar?: string
  name?: string
  password?: string
  phone?: string
  userId?: string
}
export type admin_demo_area_roleOrderByRelationAggregateInput = {
  _count?: Admin_SortOrder
}
export type admin_admin_logOrderByWithRelationInput = {
  body?: Admin_SortOrder
  cost?: Admin_SortOrder
  createdAt?: Admin_SortOrder
  error?: Admin_SortOrder
  id?: Admin_SortOrder
  ip?: Admin_SortOrder
  method?: Admin_SortOrder
  path?: Admin_SortOrder
  requestId?: Admin_SortOrder
  status?: Admin_SortOrder
  ua?: Admin_SortOrder
  user?: admin_userOrderByWithRelationInput
  userId?: Admin_SortOrder
}
export type menu__findUniqueResponseData_data = {
  apis?: string
  code?: string
  createdAt: string
  icon?: string
  id: number
  label: string
  level: number
  parentId?: number
  path?: string
  permission?: string
  roles?: menu__findUniqueResponseData_data_roles[]
  schema?: string
  sort: number
  type?: string
  updatedAt: string
  visibleInMenu: boolean
}
export type post__author__findManyResponseData_options = {
  createdAt: string
  email: string
  id: number
  name: string
}
export type admin_IntNullableFilter = {
  equals?: number
  gt?: number
  gte?: number
  in?: number[]
  lt?: number
  lte?: number
  not?: admin_NestedIntNullableFilter
  notIn?: number[]
}
export type post__category__deleteManyInput = {
  ids: number[]
}
export type post__category__updateOneResponseData_data = {
  id: number
}
export type admin_admin_role_userCreateManyInput = {
  createdAt?: string
  id?: number
  roleId: number
  userId: string
}
export type post__category__createOneResponseData = {
  data?: post__category__createOneResponseData_data
}
export type user__findUniqueResponseData_data = {
  avatar?: string
  countryCode?: string
  createdAt: string
  id: number
  name?: string
  password?: string
  passwordSalt?: string
  passwordType?: string
  phone?: string
  roles: string[]
  userId: string
}
export type user__meResponseData_data = {
  areaCodes: string[]
  avatar?: string
  id: number
  menus: user__meResponseData_data_menus[]
  name?: string
  roles: string[]
  userId: string
}
export type user__deleteManyResponseData = {
  data?: number
}
export type area__findMaxSubCodeInput = {
  parentCode: string
}
export type post__deleteManyResponseData = {
  data?: post__deleteManyResponseData_data
}
export type admin_admin_roleOrderByWithRelationInput = {
  admin_menu_role?: admin_admin_menu_roleOrderByRelationAggregateInput
  admin_role_user?: admin_admin_role_userOrderByRelationAggregateInput
  code?: Admin_SortOrder
  createdAt?: Admin_SortOrder
  demo_area_role?: admin_demo_area_roleOrderByRelationAggregateInput
  description?: Admin_SortOrder
  id?: Admin_SortOrder
  name?: Admin_SortOrder
  updatedAt?: Admin_SortOrder
}
export type admin_admin_menu_roleOrderByRelationAggregateInput = {
  _count?: Admin_SortOrder
}
export type menu__updateOneResponseData = {
  data?: menu__updateOneResponseData_data
}
export type post__category__deleteManyResponseData = {
  data?: post__category__deleteManyResponseData_data
}
export type post__category__updateOneInput = {
  description?: string
  id: number
  name?: string
}
export type post__createOneResponseData_data = {
  id: number
}
export type post__findManyResponseData = {
  data: post__findManyResponseData_data[]
  total: number
}
export type user__casdoor__sendCodeInput = {
  /** Country code, default CN */
  countryCode?: string
  /** Destination phone number */
  dest: string
}
export type api__listPublicInput = {}
export type area__createOneResponseData = {
  data?: area__createOneResponseData_data
}
export type role__user__updateManyResponseData = {
  created?: number
  deleted?: number
}
export type role__findManyResponseData_data = {
  code: string
  createdAt: string
  description?: string
  id: number
  name: string
  updatedAt: string
}
export type admin_admin_logOrderByRelationAggregateInput = {
  _count?: Admin_SortOrder
}
export type role__findUniqueResponseData = {
  data?: role__findUniqueResponseData_data
}
export type user__casdoor__sendCodeResponseData = {
  data?: user__casdoor__sendCodeResponseData_data
}
export type role__deleteManyResponseData = {
  data?: number
}
export type admin_admin_menuWhereInput = {
  AND?: admin_admin_menuWhereInput
  NOT?: admin_admin_menuWhereInput
  OR?: admin_admin_menuWhereInput[]
  admin_menu_role?: admin_Admin_menu_roleListRelationFilter
  apis?: admin_StringNullableFilter
  code?: admin_StringNullableFilter
  createdAt?: admin_DateTimeFilter
  icon?: admin_StringNullableFilter
  id?: admin_IntFilter
  label?: admin_StringFilter
  level?: admin_IntFilter
  parentId?: admin_IntNullableFilter
  path?: admin_StringNullableFilter
  permission?: admin_StringNullableFilter
  schema?: admin_StringNullableFilter
  sort?: admin_IntFilter
  type?: admin_StringNullableFilter
  updatedAt?: admin_DateTimeFilter
  visibleInMenu?: admin_BoolFilter
}
export type post__category__findUniqueInput = {
  id: number
}
export type admin_StringFilter = {
  contains?: string
  endsWith?: string
  equals?: string
  gt?: string
  gte?: string
  in?: string[]
  lt?: string
  lte?: string
  not?: admin_NestedStringFilter
  notIn?: string[]
  startsWith?: string
}
export type post__findUniqueResponseData_data_category = {
  createdAt: string
  description?: string
  id: number
  name: string
  updatedAt: string
}
export type post__updateOneResponseData_data = {
  id: number
}
export type log__deleteManyInput = {
  ids: number[]
}
export type admin_Demo_area_roleListRelationFilter = {
  every?: admin_demo_area_roleWhereInput
  none?: admin_demo_area_roleWhereInput
  some?: admin_demo_area_roleWhereInput
}
export type post__category__createOneResponseData_data = {
  id: number
  name: string
}
export type role__createOneResponseData_data = {
  id: number
}
export type user__casdoor__loginResponseData_data = {
  code?: number
  data?: user__casdoor__loginResponseData_data_data
  msg?: string
}
export type admin_admin_menuOrderByWithRelationInput = {
  admin_menu_role?: admin_admin_menu_roleOrderByRelationAggregateInput
  apis?: Admin_SortOrder
  code?: Admin_SortOrder
  createdAt?: Admin_SortOrder
  icon?: Admin_SortOrder
  id?: Admin_SortOrder
  label?: Admin_SortOrder
  level?: Admin_SortOrder
  parentId?: Admin_SortOrder
  path?: Admin_SortOrder
  permission?: Admin_SortOrder
  schema?: Admin_SortOrder
  sort?: Admin_SortOrder
  type?: Admin_SortOrder
  updatedAt?: Admin_SortOrder
  visibleInMenu?: Admin_SortOrder
}
export type area__createOneInput = {
  name: string
  parentCode?: string
}
export type menu__findManyInput = {
  level?: number
  orderBy?: admin_admin_menuOrderByWithRelationInput[]
  parentId?: number
  path?: string
  skip?: number
  take?: number
}
export type role__createOneResponseData = {
  data?: role__createOneResponseData_data
}
export type admin_admin_menu_roleCreateManyAdmin_roleInputEnvelope = {
  data: admin_admin_menu_roleCreateManyAdmin_roleInput[]
  skipDuplicates?: boolean
}
export type log__findManyInput = {
  ip?: string
  method?: string
  orderBy?: admin_admin_logOrderByWithRelationInput[]
  path?: string
  phone?: string
  skip?: number
  take?: number
}
export type admin_admin_role_userOrderByRelationAggregateInput = {
  _count?: Admin_SortOrder
}
export type post__findManyResponseData_data_author = {
  email: string
  id: number
  name: string
}
export type menu__createOneResponseData_data = {
  id: number
}
export type api__queryRawResponseData = {
  data?: any
}
export type user__meResponseData = {
  data?: user__meResponseData_data
}
export type admin_Admin_menuRelationFilter = {
  is?: admin_admin_menuWhereInput
  isNot?: admin_admin_menuWhereInput
}
export type role__findUniqueInput = {
  id: number
}
export type user__casdoor__addUserResponseData = {
  data?: user__casdoor__addUserResponseData_data
}
export type admin_admin_role_userWhereInput = {
  AND?: admin_admin_role_userWhereInput
  NOT?: admin_admin_role_userWhereInput
  OR?: admin_admin_role_userWhereInput[]
  admin_role?: admin_Admin_roleRelationFilter
  createdAt?: admin_DateTimeFilter
  id?: admin_IntFilter
  roleId?: admin_IntFilter
  userId?: admin_StringFilter
}
export type user__casdoor__loginResponseData_data_data = {
  accessToken?: string
  expireIn?: number
  refreshToken?: string
}
export type menu__findUniqueInput = {
  id: number
}
export type admin_demo_post_authorOrderByWithRelationInput = {
  createdAt?: Admin_SortOrder
  demo_post?: admin_demo_postOrderByRelationAggregateInput
  email?: Admin_SortOrder
  id?: Admin_SortOrder
  name?: Admin_SortOrder
  updatedAt?: Admin_SortOrder
}
export type menu__createOneInput = {
  apis?: string
  code?: string
  icon?: string
  label: string
  level: number
  parentId?: number
  path: string
  permission?: string
  sort?: number
  type?: string
  visibleInMenu?: boolean
}
export type user__casdoor__loginInput = {
  code?: string
  loginType: Casdoor_login_post_input_object_loginType_enum
  password?: string
  phone?: string
  platform?: string
  username?: string
}
export type role__findUniqueResponseData_data_menus = {
  apis?: string
  code?: string
  createdAt: string
  icon?: string
  id: number
  label: string
  level: number
  parentId?: number
  path?: string
  permission?: string
  schema?: string
  sort: number
  type?: string
  updatedAt: string
}
export type user__casdoor__refreshTokenInput = {
  refreshToken: string
}
export type user__casdoor__loginResponseData = {
  /** UserResponse */
  data?: user__casdoor__loginResponseData_data
}
export type role__updateOneResponseData = {
  data?: role__updateOneResponseData_data
}
export type role__findUniqueResponseData_data = {
  code: string
  createdAt: string
  description?: string
  id: number
  menus?: role__findUniqueResponseData_data_menus[]
  name: string
  updatedAt: string
  userIds?: string[]
}
export type user__casdoor__addUserInput = {
  avatar?: string
  /** Country code, default CN */
  countryCode?: string
  /** User name */
  name?: string
  /** Password */
  password?: string
  /** Phone number */
  phone?: string
}
export type user__findManyInput = {
  name?: string
  orderBy?: admin_userOrderByWithRelationInput[]
  phone?: string
  skip?: number
  take?: number
}
export type user__findManyResponseData_data_roles = {
  code: string
  description?: string
  name: string
}
export type api__executeRawResponseData = {
  data?: any
}
export type api__queryRawInput = {
  parameters?: any
  query: string
}
export type post__author__findManyInput = {}
export type post__category__updateOneResponseData = {
  data?: post__category__updateOneResponseData_data
}
export type user__casdoor__sendCodeResponseData_data = {
  code?: number
  msg?: string
}
export type area__findManyResponseData = {
  data: area__findManyResponseData_data[]
  total: number
}
export type post__updateOneResponseData = {
  data?: post__updateOneResponseData_data
}
export type api__listPublicResponseData_data = {
  path: string
  title: string
}
export type area__findNamesResponseData = {
  data: string[]
}
export type user__casdoor__refreshTokenResponseData = {
  /** UserResponse */
  data?: user__casdoor__refreshTokenResponseData_data
}
export type admin_Admin_roleRelationFilter = {
  is?: admin_admin_roleWhereInput
  isNot?: admin_admin_roleWhereInput
}
export type user__deleteManyInput = {
  userIds: string[]
}
export type user__findManyResponseData = {
  data: user__findManyResponseData_data[]
  total: number
}
export type user__meResponseData_data_menus = {
  apis?: string
  code?: string
  icon?: string
  id: number
  label: string
  level: number
  parentId?: number
  path?: string
  permission?: string
  sort: number
  type?: string
  visibleInMenu: boolean
}
export type user__casdoor__updateUserResponseData_data = {
  code?: number
  msg?: string
}
export type post__findManyResponseData_data = {
  author?: post__findManyResponseData_data_author
  authorId?: number
  category?: post__findManyResponseData_data_category
  categoryId?: number
  content: string
  createdAt: string
  id: number
  likes: number
  poster?: string
  title: string
  updatedAt: string
  views: number
}
export type post__findUniqueInput = {
  id: number
}
export type role__findManyResponseData = {
  data: role__findManyResponseData_data[]
  total: number
}
export type log__createOneResponseData_data = {
  id: number
}
export type menu__updateOneResponseData_data = {
  id: number
}
export type post__category__findUniqueResponseData_data_posts = {
  authorId?: number
  categoryId?: number
  content: string
  createdAt: string
  id: number
  poster?: string
  title: string
  updatedAt: string
}
export type user__casdoor__refreshTokenResponseData_data = {
  code?: number
  data?: user__casdoor__refreshTokenResponseData_data_data
  msg?: string
}
export type user__meInput = {}
export type admin_demo_areaWhereInput = {
  AND?: admin_demo_areaWhereInput
  NOT?: admin_demo_areaWhereInput
  OR?: admin_demo_areaWhereInput[]
  address?: admin_StringNullableFilter
  code?: admin_StringFilter
  createdAt?: admin_DateTimeFilter
  demo_area_role?: admin_Demo_area_roleListRelationFilter
  id?: admin_IntFilter
  name?: admin_StringFilter
  parentCode?: admin_StringFilter
}
export type role__updateOneInput = {
  code?: string
  createManyMenuRole?: admin_admin_menu_roleCreateManyAdmin_roleInputEnvelope
  deleteManyMenuRoleId?: number
  description?: string
  id: number
  name?: string
}
export type admin_Demo_areaRelationFilter = {
  is?: admin_demo_areaWhereInput
  isNot?: admin_demo_areaWhereInput
}
export type admin_Admin_role_userListRelationFilter = {
  every?: admin_admin_role_userWhereInput
  none?: admin_admin_role_userWhereInput
  some?: admin_admin_role_userWhereInput
}
export type log__findManyResponseData = {
  data: log__findManyResponseData_data[]
  total: number
}
export type menu__findMenuByPathResponseData = {
  data?: menu__findMenuByPathResponseData_data
}
export type role__createOneInput = {
  code: string
  description?: string
  name: string
}
export type role__updateOneResponseData_data = {
  id: number
}
export type admin_demo_post_categoryOrderByWithRelationInput = {
  createdAt?: Admin_SortOrder
  demo_post?: admin_demo_postOrderByRelationAggregateInput
  description?: Admin_SortOrder
  id?: Admin_SortOrder
  name?: Admin_SortOrder
  updatedAt?: Admin_SortOrder
}
export type menu__createOneResponseData = {
  data?: menu__createOneResponseData_data
}
export type user__casdoor__updateUserResponseData = {
  data?: user__casdoor__updateUserResponseData_data
}
export type admin_admin_menu_roleWhereInput = {
  AND?: admin_admin_menu_roleWhereInput
  NOT?: admin_admin_menu_roleWhereInput
  OR?: admin_admin_menu_roleWhereInput[]
  admin_menu?: admin_Admin_menuRelationFilter
  admin_role?: admin_Admin_roleRelationFilter
  createdAt?: admin_DateTimeFilter
  id?: admin_IntFilter
  menuId?: admin_IntFilter
  roleId?: admin_IntFilter
}
export type user__countInput = {}
export type area__createOneResponseData_data = {
  address?: string
  code: string
  createdAt: string
  id: number
  name: string
  parentCode: string
}
export type log__deleteManyResponseData = {
  data?: number
}
export type post__deleteManyInput = {
  ids: number[]
}
export type role__deleteManyInput = {
  codes: string[]
}
export type admin_NestedIntFilter = {
  equals?: number
  gt?: number
  gte?: number
  in?: number[]
  lt?: number
  lte?: number
  not?: admin_NestedIntFilter
  notIn?: number[]
}
export type user__findUniqueResponseData = {
  data?: user__findUniqueResponseData_data
}
export type post__category__deleteManyResponseData_data = {
  count: number
}
export type role__api__findManyInput = {
  path?: string
  roleId?: number
  skip?: number
  take?: number
}
export type admin_BoolFilter = {
  equals?: boolean
  not?: admin_NestedBoolFilter
}
export type admin_demo_postOrderByRelationAggregateInput = {
  _count?: Admin_SortOrder
}
export type post__category__findManyResponseData_options = {
  createdAt: string
  description?: string
  id: number
  name: string
  postCount: number
  updatedAt: string
}
export type role__user__updateManyInput = {
  data: admin_admin_role_userCreateManyInput[]
  userId?: string
}
export type menu__deleteManyResponseData = {
  data?: number
}
export type post__createOneInput = {
  authorId: number
  categoryId: number
  content: string
  poster?: string
  title: string
}
export type admin_Admin_menu_roleListRelationFilter = {
  every?: admin_admin_menu_roleWhereInput
  none?: admin_admin_menu_roleWhereInput
  some?: admin_admin_menu_roleWhereInput
}
export type menu__findManyResponseData = {
  data: menu__findManyResponseData_data[]
  total: number
}
export type post__findManyResponseData_data_category = {
  id: number
  name: string
}
export type admin_admin_menu_roleCreateManyAdmin_roleInput = {
  createdAt?: string
  id?: number
  menuId: number
}
export type log__createOneResponseData = {
  data?: log__createOneResponseData_data
}
export type menu__findUniqueResponseData_data_roles = {
  code: string
  createdAt: string
  description?: string
  id: number
  name: string
  updatedAt: string
}
export type menu__updateOneInput = {
  apis?: string
  icon?: string
  id: number
  label?: string
  level?: number
  parentId?: number
  path?: string
  permission?: string
  schema?: string
  sort?: number
  type?: string
  visibleInMenu?: boolean
}
export type post__createOneResponseData = {
  data?: post__createOneResponseData_data
}
export type admin_demo_postOrderByWithRelationInput = {
  authorId?: Admin_SortOrder
  categoryId?: Admin_SortOrder
  content?: Admin_SortOrder
  createdAt?: Admin_SortOrder
  demo_post_author?: admin_demo_post_authorOrderByWithRelationInput
  demo_post_category?: admin_demo_post_categoryOrderByWithRelationInput
  id?: Admin_SortOrder
  likes?: Admin_SortOrder
  poster?: Admin_SortOrder
  title?: Admin_SortOrder
  updatedAt?: Admin_SortOrder
  views?: Admin_SortOrder
}
export type admin_NestedStringFilter = {
  contains?: string
  endsWith?: string
  equals?: string
  gt?: string
  gte?: string
  in?: string[]
  lt?: string
  lte?: string
  not?: admin_NestedStringFilter
  notIn?: string[]
  startsWith?: string
}
export type post__category__findManyInput = {
  name?: string
}
export type admin_admin_roleWhereInput = {
  AND?: admin_admin_roleWhereInput
  NOT?: admin_admin_roleWhereInput
  OR?: admin_admin_roleWhereInput[]
  admin_menu_role?: admin_Admin_menu_roleListRelationFilter
  admin_role_user?: admin_Admin_role_userListRelationFilter
  code?: admin_StringFilter
  createdAt?: admin_DateTimeFilter
  demo_area_role?: admin_Demo_area_roleListRelationFilter
  description?: admin_StringNullableFilter
  id?: admin_IntFilter
  name?: admin_StringFilter
  updatedAt?: admin_DateTimeFilter
}
export type area__findManyInput = {
  address?: string
  skip?: number
  take?: number
}
export type area__findMaxSubCodeResponseData = {
  data?: string
}
export type api__executeRawInput = {
  parameters?: any
  query: string
}
export type log__createOneInput = {
  body?: string
  cost?: number
  error?: string
  ip: string
  method: string
  path: string
  requestId: string
  status?: string
  ua: string
  userId?: string
}
export type post__updateOneInput = {
  authorId?: number
  categoryId?: number
  content?: string
  id: number
  poster?: string
  title?: string
}
export type user__casdoor__addUserResponseData_data = {
  code?: number
  msg?: string
}
export type admin_StringNullableFilter = {
  contains?: string
  endsWith?: string
  equals?: string
  gt?: string
  gte?: string
  in?: string[]
  lt?: string
  lte?: string
  not?: admin_NestedStringNullableFilter
  notIn?: string[]
  startsWith?: string
}
export type post__author__findManyResponseData = {
  options: post__author__findManyResponseData_options[]
}
export type admin_NestedStringNullableFilter = {
  contains?: string
  endsWith?: string
  equals?: string
  gt?: string
  gte?: string
  in?: string[]
  lt?: string
  lte?: string
  not?: admin_NestedStringNullableFilter
  notIn?: string[]
  startsWith?: string
}
export type admin_NestedBoolFilter = {
  equals?: boolean
  not?: admin_NestedBoolFilter
}
export type api__listPublicResponseData = {
  data?: api__listPublicResponseData_data[]
}
export type menu__findUniqueResponseData = {
  data?: menu__findUniqueResponseData_data
}
export type post__findUniqueResponseData_data = {
  authorId?: number
  category?: post__findUniqueResponseData_data_category
  categoryId?: number
  content: string
  createdAt: string
  id: number
  poster?: string
  title: string
  updatedAt: string
}
export type admin_demo_area_roleWhereInput = {
  AND?: admin_demo_area_roleWhereInput
  NOT?: admin_demo_area_roleWhereInput
  OR?: admin_demo_area_roleWhereInput[]
  admin_role?: admin_Admin_roleRelationFilter
  areaId?: admin_IntFilter
  createdAt?: admin_DateTimeFilter
  demo_area?: admin_Demo_areaRelationFilter
  id?: admin_IntFilter
  roleId?: admin_IntFilter
}
export type area__findManyResponseData_data = {
  address?: string
  code: string
  createdAt: string
  id: number
  name: string
  parentCode: string
}
export type menu__deleteManyInput = {
  ids: number[]
}
export type post__category__findUniqueResponseData_data = {
  createdAt: string
  description?: string
  id: number
  name: string
  posts?: post__category__findUniqueResponseData_data_posts[]
  updatedAt: string
}
export type user__findUniqueInput = {
  userId: string
}
export type post__findUniqueResponseData = {
  data?: post__findUniqueResponseData_data
}
export type user__casdoor__refreshTokenResponseData_data_data = {
  accessToken?: string
  expireIn?: number
  refreshToken?: string
}
export type user__countResponseData = {
  data: number
}
export type admin_IntFilter = {
  equals?: number
  gt?: number
  gte?: number
  in?: number[]
  lt?: number
  lte?: number
  not?: admin_NestedIntFilter
  notIn?: number[]
}
export type area__findNamesInput = {
  codes: string[]
}
export type menu__findManyResponseData_data = {
  apis?: string
  code?: string
  createdAt: string
  icon?: string
  id: number
  label: string
  level: number
  parentId?: number
  path?: string
  permission?: string
  schema?: string
  sort: number
  type?: string
  updatedAt: string
  visibleInMenu: boolean
}
export type menu__findMenuByPathResponseData_data = {
  id: number
  schema?: string
}
export type post__category__findUniqueResponseData = {
  data?: post__category__findUniqueResponseData_data
}
export type log__findManyResponseData_data = {
  body?: string
  cost?: number
  createdAt: string
  error?: string
  id: number
  ip: string
  method: string
  path: string
  requestId: string
  status?: string
  ua: string
  userId?: string
}
export type post__findManyInput = {
  authorId?: number
  categoryId?: number
  content?: string
  createEndDate?: string
  createStartDate?: string
  email?: string
  likesMax?: number
  likesMin?: number
  orderBy?: admin_demo_postOrderByWithRelationInput
  skip?: number
  take?: number
  title?: string
  viewsMax?: number
  viewsMin?: number
}
export type post__category__findManyResponseData = {
  options: post__category__findManyResponseData_options[]
}
export type post__deleteManyResponseData_data = {
  count: number
}
export type user__findManyResponseData_data = {
  avatar?: string
  countryCode?: string
  createdAt: string
  id: number
  name?: string
  password?: string
  passwordSalt?: string
  passwordType?: string
  phone?: string
  roles: user__findManyResponseData_data_roles[]
  userId: string
}

export enum Admin_SortOrder {
  Asc = 'asc',
  Desc = 'desc'
}
export enum Casdoor_login_post_input_object_loginType_enum {
  App = 'app',
  H5 = 'h5',
  Mini = 'mini',
  Password = 'password',
  Sms = 'sms',
  Web = 'web'
}

export type JSONValue = string | number | boolean | JSONObject | Array<JSONValue>;

export type JSONObject = { [key: string]: JSONValue };