package generated


type Role__api__findManyResponseData struct {
    Data []string `json:"data"`
    Total int64 `json:"total"`
}

type Role__user__updateManyInternalInput struct {
    Data []*Admin_admin_role_userCreateManyInput `json:"data"`
    UserId string `json:"userId,omitempty"`
}

type Admin_NestedIntNullableFilter struct {
    Equals int64 `json:"equals,omitempty"`
    Gt int64 `json:"gt,omitempty"`
    Gte int64 `json:"gte,omitempty"`
    In []int64 `json:"in,omitempty"`
    Lt int64 `json:"lt,omitempty"`
    Lte int64 `json:"lte,omitempty"`
    Not *Admin_NestedIntNullableFilter `json:"not,omitempty"`
    NotIn []int64 `json:"notIn,omitempty"`
}

type Admin_NestedDateTimeFilter struct {
    Equals string `json:"equals,omitempty"`
    Gt string `json:"gt,omitempty"`
    Gte string `json:"gte,omitempty"`
    In []string `json:"in,omitempty"`
    Lt string `json:"lt,omitempty"`
    Lte string `json:"lte,omitempty"`
    Not *Admin_NestedDateTimeFilter `json:"not,omitempty"`
    NotIn []string `json:"notIn,omitempty"`
}

type Admin_userOrderByWithRelationInput struct {
    Admin_log *Admin_admin_logOrderByRelationAggregateInput `json:"admin_log,omitempty"`
    Avatar Admin_SortOrder `json:"avatar,omitempty"`
    Country_code Admin_SortOrder `json:"country_code,omitempty"`
    Created_at Admin_SortOrder `json:"created_at,omitempty"`
    Id Admin_SortOrder `json:"id,omitempty"`
    Name Admin_SortOrder `json:"name,omitempty"`
    Password Admin_SortOrder `json:"password,omitempty"`
    Password_salt Admin_SortOrder `json:"password_salt,omitempty"`
    Password_type Admin_SortOrder `json:"password_type,omitempty"`
    Phone Admin_SortOrder `json:"phone,omitempty"`
    Updated_at Admin_SortOrder `json:"updated_at,omitempty"`
    User_id Admin_SortOrder `json:"user_id,omitempty"`
}

type Post__category__createOneInput struct {
    Name string `json:"name"`
}

type Role__findManyInput struct {
    Code string `json:"code,omitempty"`
    Name string `json:"name,omitempty"`
    OrderBy []*Admin_admin_roleOrderByWithRelationInput `json:"orderBy,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type Admin_DateTimeFilter struct {
    Equals string `json:"equals,omitempty"`
    Gt string `json:"gt,omitempty"`
    Gte string `json:"gte,omitempty"`
    In []string `json:"in,omitempty"`
    Lt string `json:"lt,omitempty"`
    Lte string `json:"lte,omitempty"`
    Not *Admin_NestedDateTimeFilter `json:"not,omitempty"`
    NotIn []string `json:"notIn,omitempty"`
}

type Menu__findMenuByPathInput struct {
    Path string `json:"path"`
}

type User__casdoor__refreshTokenInternalInput struct {
    Platform string `json:"platform"`
    RefreshToken string `json:"refreshToken"`
}

type User__casdoor__updateUserInput struct {
    Avatar string `json:"avatar,omitempty"`
    Name string `json:"name,omitempty"`
    Password string `json:"password,omitempty"`
    Phone string `json:"phone,omitempty"`
    UserId string `json:"userId,omitempty"`
}

type Admin_demo_area_roleOrderByRelationAggregateInput struct {
    Count Admin_SortOrder `json:"_count,omitempty"`
}

type Admin_admin_logOrderByWithRelationInput struct {
    Body Admin_SortOrder `json:"body,omitempty"`
    Cost Admin_SortOrder `json:"cost,omitempty"`
    CreatedAt Admin_SortOrder `json:"createdAt,omitempty"`
    Error Admin_SortOrder `json:"error,omitempty"`
    Id Admin_SortOrder `json:"id,omitempty"`
    Ip Admin_SortOrder `json:"ip,omitempty"`
    Method Admin_SortOrder `json:"method,omitempty"`
    Path Admin_SortOrder `json:"path,omitempty"`
    RequestId Admin_SortOrder `json:"requestId,omitempty"`
    Status Admin_SortOrder `json:"status,omitempty"`
    Ua Admin_SortOrder `json:"ua,omitempty"`
    User *Admin_userOrderByWithRelationInput `json:"user,omitempty"`
    UserId Admin_SortOrder `json:"userId,omitempty"`
}

type Menu__findUniqueResponseData_data struct {
    Apis string `json:"apis,omitempty"`
    Code string `json:"code,omitempty"`
    CreatedAt string `json:"createdAt"`
    Icon string `json:"icon,omitempty"`
    Id int64 `json:"id"`
    Label string `json:"label"`
    Level int64 `json:"level"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path,omitempty"`
    Permission string `json:"permission,omitempty"`
    Roles []Menu__findUniqueResponseData_data_roles `json:"roles,omitempty"`
    Schema string `json:"schema,omitempty"`
    Sort int64 `json:"sort"`
    Type string `json:"type,omitempty"`
    UpdatedAt string `json:"updatedAt"`
    VisibleInMenu bool `json:"visibleInMenu"`
}

type Post__author__findManyResponseData_options struct {
    CreatedAt string `json:"createdAt"`
    Email string `json:"email"`
    Id int64 `json:"id"`
    Name string `json:"name"`
}

type Post__createOneInternalInput struct {
    AuthorId int64 `json:"authorId"`
    CategoryId int64 `json:"categoryId"`
    Content string `json:"content"`
    Poster string `json:"poster,omitempty"`
    Title string `json:"title"`
    UpdatedAt string `json:"updatedAt"`
}

type Admin_IntNullableFilter struct {
    Equals int64 `json:"equals,omitempty"`
    Gt int64 `json:"gt,omitempty"`
    Gte int64 `json:"gte,omitempty"`
    In []int64 `json:"in,omitempty"`
    Lt int64 `json:"lt,omitempty"`
    Lte int64 `json:"lte,omitempty"`
    Not *Admin_NestedIntNullableFilter `json:"not,omitempty"`
    NotIn []int64 `json:"notIn,omitempty"`
}

type Post__category__deleteManyInput struct {
    Ids []int64 `json:"ids"`
}

type Post__category__updateOneResponseData_data struct {
    Id int64 `json:"id"`
}

type Admin_admin_role_userCreateManyInput struct {
    CreatedAt string `json:"createdAt,omitempty"`
    Id int64 `json:"id,omitempty"`
    RoleId int64 `json:"roleId"`
    UserId string `json:"userId"`
}

type Post__category__createOneResponseData struct {
    Data Post__category__createOneResponseData_data `json:"data,omitempty"`
}

type User__findUniqueResponseData_data struct {
    Avatar string `json:"avatar,omitempty"`
    CountryCode string `json:"countryCode,omitempty"`
    CreatedAt string `json:"createdAt"`
    Id int64 `json:"id"`
    Name string `json:"name,omitempty"`
    Password string `json:"password,omitempty"`
    PasswordSalt string `json:"passwordSalt,omitempty"`
    PasswordType string `json:"passwordType,omitempty"`
    Phone string `json:"phone,omitempty"`
    Roles []string `json:"roles"`
    UserId string `json:"userId"`
}

type User__meResponseData_data struct {
    AreaCodes []string `json:"areaCodes"`
    Avatar string `json:"avatar,omitempty"`
    Id int64 `json:"id"`
    Menus []User__meResponseData_data_menus `json:"menus"`
    Name string `json:"name,omitempty"`
    Roles []string `json:"roles"`
    UserId string `json:"userId"`
}

type Menu__updateOneInternalInput struct {
    Apis string `json:"apis,omitempty"`
    Icon string `json:"icon,omitempty"`
    Id int64 `json:"id"`
    Label string `json:"label,omitempty"`
    Level int64 `json:"level,omitempty"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path,omitempty"`
    Permission string `json:"permission,omitempty"`
    Schema string `json:"schema,omitempty"`
    Sort int64 `json:"sort,omitempty"`
    Type string `json:"type,omitempty"`
    UpdatedAt string `json:"updatedAt"`
    VisibleInMenu bool `json:"visibleInMenu,omitempty"`
}

type User__casdoor__loginInternalInput struct {
    Code string `json:"code,omitempty"`
    LoginType Casdoor_login_post_input_object_loginType_enum `json:"loginType"`
    Password string `json:"password,omitempty"`
    Phone string `json:"phone,omitempty"`
    Platform string `json:"platform,omitempty"`
    Username string `json:"username,omitempty"`
}

type User__deleteManyResponseData struct {
    Data int64 `json:"data,omitempty"`
}

type Area__findMaxSubCodeInput struct {
    ParentCode string `json:"parentCode"`
}

type Log__deleteManyInternalInput struct {
    Ids []int64 `json:"ids"`
}

type Post__deleteManyResponseData struct {
    Data Post__deleteManyResponseData_data `json:"data,omitempty"`
}

type Admin_admin_roleOrderByWithRelationInput struct {
    Admin_menu_role *Admin_admin_menu_roleOrderByRelationAggregateInput `json:"admin_menu_role,omitempty"`
    Admin_role_user *Admin_admin_role_userOrderByRelationAggregateInput `json:"admin_role_user,omitempty"`
    Code Admin_SortOrder `json:"code,omitempty"`
    CreatedAt Admin_SortOrder `json:"createdAt,omitempty"`
    Demo_area_role *Admin_demo_area_roleOrderByRelationAggregateInput `json:"demo_area_role,omitempty"`
    Description Admin_SortOrder `json:"description,omitempty"`
    Id Admin_SortOrder `json:"id,omitempty"`
    Name Admin_SortOrder `json:"name,omitempty"`
    UpdatedAt Admin_SortOrder `json:"updatedAt,omitempty"`
}

type Admin_admin_menu_roleOrderByRelationAggregateInput struct {
    Count Admin_SortOrder `json:"_count,omitempty"`
}

type Menu__updateOneResponseData struct {
    Data Menu__updateOneResponseData_data `json:"data,omitempty"`
}

type Post__category__deleteManyResponseData struct {
    Data Post__category__deleteManyResponseData_data `json:"data,omitempty"`
}

type Post__category__updateOneInput struct {
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name,omitempty"`
}

type Post__createOneResponseData_data struct {
    Id int64 `json:"id"`
}

type Post__findManyResponseData struct {
    Data []Post__findManyResponseData_data `json:"data"`
    Total int64 `json:"total"`
}

type User__casdoor__sendCodeInput struct {
    /* Country code, default CN */
CountryCode string `json:"countryCode,omitempty"`
    /* Destination phone number */
Dest string `json:"dest"`
}

type Api__listPublicInput struct {
}

type Area__createOneResponseData struct {
    Data Area__createOneResponseData_data `json:"data,omitempty"`
}

type Log__createOneInternalInput struct {
    Body string `json:"body,omitempty"`
    Cost float64 `json:"cost,omitempty"`
    Error string `json:"error,omitempty"`
    Ip string `json:"ip"`
    Method string `json:"method"`
    Path string `json:"path"`
    RequestId string `json:"requestId"`
    Status string `json:"status,omitempty"`
    Ua string `json:"ua"`
    UserId string `json:"userId,omitempty"`
}

type Role__user__updateManyResponseData struct {
    Created int64 `json:"created,omitempty"`
    Deleted int64 `json:"deleted,omitempty"`
}

type Role__findManyResponseData_data struct {
    Code string `json:"code"`
    CreatedAt string `json:"createdAt"`
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name"`
    UpdatedAt string `json:"updatedAt"`
}

type Role__findUniqueInternalInput struct {
    Id int64 `json:"id"`
}

type Menu__findManyInternalInput struct {
    Level int64 `json:"level,omitempty"`
    OrderBy []*Admin_admin_menuOrderByWithRelationInput `json:"orderBy,omitempty"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type User__deleteManyInternalInput struct {
    UserIds []string `json:"userIds"`
}

type Admin_admin_logOrderByRelationAggregateInput struct {
    Count Admin_SortOrder `json:"_count,omitempty"`
}

type Role__findUniqueResponseData struct {
    Data Role__findUniqueResponseData_data `json:"data,omitempty"`
}

type User__casdoor__sendCodeResponseData struct {
    Data User__casdoor__sendCodeResponseData_data `json:"data,omitempty"`
}

type Role__deleteManyResponseData struct {
    Data int64 `json:"data,omitempty"`
}

type Admin_admin_menuWhereInput struct {
    AND *Admin_admin_menuWhereInput `json:"AND,omitempty"`
    NOT *Admin_admin_menuWhereInput `json:"NOT,omitempty"`
    OR []*Admin_admin_menuWhereInput `json:"OR,omitempty"`
    Admin_menu_role *Admin_Admin_menu_roleListRelationFilter `json:"admin_menu_role,omitempty"`
    Apis *Admin_StringNullableFilter `json:"apis,omitempty"`
    Code *Admin_StringNullableFilter `json:"code,omitempty"`
    CreatedAt *Admin_DateTimeFilter `json:"createdAt,omitempty"`
    Icon *Admin_StringNullableFilter `json:"icon,omitempty"`
    Id *Admin_IntFilter `json:"id,omitempty"`
    Label *Admin_StringFilter `json:"label,omitempty"`
    Level *Admin_IntFilter `json:"level,omitempty"`
    ParentId *Admin_IntNullableFilter `json:"parentId,omitempty"`
    Path *Admin_StringNullableFilter `json:"path,omitempty"`
    Permission *Admin_StringNullableFilter `json:"permission,omitempty"`
    Schema *Admin_StringNullableFilter `json:"schema,omitempty"`
    Sort *Admin_IntFilter `json:"sort,omitempty"`
    Type *Admin_StringNullableFilter `json:"type,omitempty"`
    UpdatedAt *Admin_DateTimeFilter `json:"updatedAt,omitempty"`
    VisibleInMenu *Admin_BoolFilter `json:"visibleInMenu,omitempty"`
}

type Post__category__findUniqueInput struct {
    Id int64 `json:"id"`
}

type Admin_StringFilter struct {
    Contains string `json:"contains,omitempty"`
    EndsWith string `json:"endsWith,omitempty"`
    Equals string `json:"equals,omitempty"`
    Gt string `json:"gt,omitempty"`
    Gte string `json:"gte,omitempty"`
    In []string `json:"in,omitempty"`
    Lt string `json:"lt,omitempty"`
    Lte string `json:"lte,omitempty"`
    Not *Admin_NestedStringFilter `json:"not,omitempty"`
    NotIn []string `json:"notIn,omitempty"`
    StartsWith string `json:"startsWith,omitempty"`
}

type Post__findUniqueResponseData_data_category struct {
    CreatedAt string `json:"createdAt"`
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name"`
    UpdatedAt string `json:"updatedAt"`
}

type Post__updateOneResponseData_data struct {
    Id int64 `json:"id"`
}

type Role__deleteManyInternalInput struct {
    Codes []string `json:"codes"`
}

type Log__deleteManyInput struct {
    Ids []int64 `json:"ids"`
}

type Admin_Demo_area_roleListRelationFilter struct {
    Every *Admin_demo_area_roleWhereInput `json:"every,omitempty"`
    None *Admin_demo_area_roleWhereInput `json:"none,omitempty"`
    Some *Admin_demo_area_roleWhereInput `json:"some,omitempty"`
}

type Post__category__createOneResponseData_data struct {
    Id int64 `json:"id"`
    Name string `json:"name"`
}

type Role__createOneResponseData_data struct {
    Id int64 `json:"id"`
}
// User__casdoor__loginResponseData_data
/*  UserResponse */
type User__casdoor__loginResponseData_data struct {
    Code int64 `json:"code,omitempty"`
    Data User__casdoor__loginResponseData_data_data `json:"data,omitempty"`
    Msg string `json:"msg,omitempty"`
}

type Admin_admin_menuOrderByWithRelationInput struct {
    Admin_menu_role *Admin_admin_menu_roleOrderByRelationAggregateInput `json:"admin_menu_role,omitempty"`
    Apis Admin_SortOrder `json:"apis,omitempty"`
    Code Admin_SortOrder `json:"code,omitempty"`
    CreatedAt Admin_SortOrder `json:"createdAt,omitempty"`
    Icon Admin_SortOrder `json:"icon,omitempty"`
    Id Admin_SortOrder `json:"id,omitempty"`
    Label Admin_SortOrder `json:"label,omitempty"`
    Level Admin_SortOrder `json:"level,omitempty"`
    ParentId Admin_SortOrder `json:"parentId,omitempty"`
    Path Admin_SortOrder `json:"path,omitempty"`
    Permission Admin_SortOrder `json:"permission,omitempty"`
    Schema Admin_SortOrder `json:"schema,omitempty"`
    Sort Admin_SortOrder `json:"sort,omitempty"`
    Type Admin_SortOrder `json:"type,omitempty"`
    UpdatedAt Admin_SortOrder `json:"updatedAt,omitempty"`
    VisibleInMenu Admin_SortOrder `json:"visibleInMenu,omitempty"`
}

type Area__createOneInput struct {
    Name string `json:"name"`
    ParentCode string `json:"parentCode,omitempty"`
}

type Menu__findManyInput struct {
    Level int64 `json:"level,omitempty"`
    OrderBy []*Admin_admin_menuOrderByWithRelationInput `json:"orderBy,omitempty"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type Role__createOneResponseData struct {
    Data Role__createOneResponseData_data `json:"data,omitempty"`
}

type Admin_admin_menu_roleCreateManyAdmin_roleInputEnvelope struct {
    Data []*Admin_admin_menu_roleCreateManyAdmin_roleInput `json:"data"`
    SkipDuplicates bool `json:"skipDuplicates,omitempty"`
}

type Log__findManyInput struct {
    Ip string `json:"ip,omitempty"`
    Method string `json:"method,omitempty"`
    OrderBy []*Admin_admin_logOrderByWithRelationInput `json:"orderBy,omitempty"`
    Path string `json:"path,omitempty"`
    Phone string `json:"phone,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type Post__deleteManyInternalInput struct {
    Ids []int64 `json:"ids"`
}

type Admin_admin_role_userOrderByRelationAggregateInput struct {
    Count Admin_SortOrder `json:"_count,omitempty"`
}

type Post__findManyResponseData_data_author struct {
    Email string `json:"email"`
    Id int64 `json:"id"`
    Name string `json:"name"`
}

type Api__listPublicInternalInput struct {
}

type Menu__createOneResponseData_data struct {
    Id int64 `json:"id"`
}

type Api__queryRawResponseData struct {
    Data any `json:"data,omitempty"`
}

type User__meResponseData struct {
    Data User__meResponseData_data `json:"data,omitempty"`
}

type Admin_Admin_menuRelationFilter struct {
    Is *Admin_admin_menuWhereInput `json:"is,omitempty"`
    IsNot *Admin_admin_menuWhereInput `json:"isNot,omitempty"`
}

type Role__findUniqueInput struct {
    Id int64 `json:"id"`
}

type User__casdoor__addUserResponseData struct {
    Data User__casdoor__addUserResponseData_data `json:"data,omitempty"`
}

type Admin_admin_role_userWhereInput struct {
    AND *Admin_admin_role_userWhereInput `json:"AND,omitempty"`
    NOT *Admin_admin_role_userWhereInput `json:"NOT,omitempty"`
    OR []*Admin_admin_role_userWhereInput `json:"OR,omitempty"`
    Admin_role *Admin_Admin_roleRelationFilter `json:"admin_role,omitempty"`
    CreatedAt *Admin_DateTimeFilter `json:"createdAt,omitempty"`
    Id *Admin_IntFilter `json:"id,omitempty"`
    RoleId *Admin_IntFilter `json:"roleId,omitempty"`
    UserId *Admin_StringFilter `json:"userId,omitempty"`
}

type User__casdoor__loginResponseData_data_data struct {
    AccessToken string `json:"accessToken,omitempty"`
    ExpireIn int64 `json:"expireIn,omitempty"`
    RefreshToken string `json:"refreshToken,omitempty"`
}

type Menu__findUniqueInput struct {
    Id int64 `json:"id"`
}

type Role__updateOneInternalInput struct {
    Code string `json:"code,omitempty"`
    CreateManyMenuRole *Admin_admin_menu_roleCreateManyAdmin_roleInputEnvelope `json:"createManyMenuRole,omitempty"`
    DeleteManyMenuRoleId int64 `json:"deleteManyMenuRoleId,omitempty"`
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name,omitempty"`
    UpdatedAt string `json:"updatedAt"`
}

type Admin_demo_post_authorOrderByWithRelationInput struct {
    CreatedAt Admin_SortOrder `json:"createdAt,omitempty"`
    Demo_post *Admin_demo_postOrderByRelationAggregateInput `json:"demo_post,omitempty"`
    Email Admin_SortOrder `json:"email,omitempty"`
    Id Admin_SortOrder `json:"id,omitempty"`
    Name Admin_SortOrder `json:"name,omitempty"`
    UpdatedAt Admin_SortOrder `json:"updatedAt,omitempty"`
}

type Menu__createOneInput struct {
    Apis string `json:"apis,omitempty"`
    Code string `json:"code,omitempty"`
    Icon string `json:"icon,omitempty"`
    Label string `json:"label"`
    Level int64 `json:"level"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path"`
    Permission string `json:"permission,omitempty"`
    Sort int64 `json:"sort,omitempty"`
    Type string `json:"type,omitempty"`
    VisibleInMenu bool `json:"visibleInMenu,omitempty"`
}

type User__casdoor__loginInput struct {
    Code string `json:"code,omitempty"`
    LoginType Casdoor_login_post_input_object_loginType_enum `json:"loginType"`
    Password string `json:"password,omitempty"`
    Phone string `json:"phone,omitempty"`
    Platform string `json:"platform,omitempty"`
    Username string `json:"username,omitempty"`
}

type Role__findUniqueResponseData_data_menus struct {
    Apis string `json:"apis,omitempty"`
    Code string `json:"code,omitempty"`
    CreatedAt string `json:"createdAt"`
    Icon string `json:"icon,omitempty"`
    Id int64 `json:"id"`
    Label string `json:"label"`
    Level int64 `json:"level"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path,omitempty"`
    Permission string `json:"permission,omitempty"`
    Schema string `json:"schema,omitempty"`
    Sort int64 `json:"sort"`
    Type string `json:"type,omitempty"`
    UpdatedAt string `json:"updatedAt"`
}

type Api__executeRawInternalInput struct {
    Parameters any `json:"parameters,omitempty"`
    Query string `json:"query"`
}

type User__casdoor__refreshTokenInput struct {
    RefreshToken string `json:"refreshToken"`
}

type User__casdoor__loginResponseData struct {
    /* UserResponse */
Data User__casdoor__loginResponseData_data `json:"data,omitempty"`
}

type Role__updateOneResponseData struct {
    Data Role__updateOneResponseData_data `json:"data,omitempty"`
}

type Role__findUniqueResponseData_data struct {
    Code string `json:"code"`
    CreatedAt string `json:"createdAt"`
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Menus []Role__findUniqueResponseData_data_menus `json:"menus,omitempty"`
    Name string `json:"name"`
    UpdatedAt string `json:"updatedAt"`
    UserIds []string `json:"userIds,omitempty"`
}

type User__casdoor__addUserInput struct {
    Avatar string `json:"avatar,omitempty"`
    /* Country code, default CN */
CountryCode string `json:"countryCode,omitempty"`
    /* User name */
Name string `json:"name,omitempty"`
    /* Password */
Password string `json:"password,omitempty"`
    /* Phone number */
Phone string `json:"phone,omitempty"`
}

type User__findManyInput struct {
    Name string `json:"name,omitempty"`
    OrderBy []*Admin_userOrderByWithRelationInput `json:"orderBy,omitempty"`
    Phone string `json:"phone,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type User__findManyResponseData_data_roles struct {
    Code string `json:"code"`
    Description string `json:"description,omitempty"`
    Name string `json:"name"`
}

type Api__executeRawResponseData struct {
    Data any `json:"data,omitempty"`
}

type Api__queryRawInput struct {
    Parameters any `json:"parameters,omitempty"`
    Query string `json:"query"`
}

type Post__author__findManyInput struct {
}

type Post__category__updateOneResponseData struct {
    Data Post__category__updateOneResponseData_data `json:"data,omitempty"`
}

type User__casdoor__sendCodeResponseData_data struct {
    Code int64 `json:"code,omitempty"`
    Msg string `json:"msg,omitempty"`
}

type Area__findManyResponseData struct {
    Data []Area__findManyResponseData_data `json:"data"`
    Total int64 `json:"total"`
}

type Menu__findMenuByPathInternalInput struct {
    Path string `json:"path"`
}

type Post__findUniqueInternalInput struct {
    Id int64 `json:"id"`
}

type Post__updateOneInternalInput struct {
    AuthorId int64 `json:"authorId,omitempty"`
    CategoryId int64 `json:"categoryId,omitempty"`
    Content string `json:"content,omitempty"`
    Id int64 `json:"id"`
    Poster string `json:"poster,omitempty"`
    Title string `json:"title,omitempty"`
    UpdatedAt string `json:"updatedAt"`
}

type Post__updateOneResponseData struct {
    Data Post__updateOneResponseData_data `json:"data,omitempty"`
}

type Api__listPublicResponseData_data struct {
    Path string `json:"path"`
    Title string `json:"title"`
}

type Area__findNamesResponseData struct {
    Data []string `json:"data"`
}

type Post__category__deleteManyInternalInput struct {
    Ids []int64 `json:"ids"`
}

type User__casdoor__refreshTokenResponseData struct {
    /* UserResponse */
Data User__casdoor__refreshTokenResponseData_data `json:"data,omitempty"`
}

type User__casdoor__updateUserInternalInput struct {
    Authorization string `json:"authorization"`
    Avatar string `json:"avatar,omitempty"`
    Name string `json:"name,omitempty"`
    Password string `json:"password,omitempty"`
    Phone string `json:"phone,omitempty"`
    UserId string `json:"userId,omitempty"`
}

type Admin_Admin_roleRelationFilter struct {
    Is *Admin_admin_roleWhereInput `json:"is,omitempty"`
    IsNot *Admin_admin_roleWhereInput `json:"isNot,omitempty"`
}

type Post__category__updateOneInternalInput struct {
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name,omitempty"`
    UpdatedAt string `json:"updatedAt"`
}

type User__meInternalInput struct {
    IncludeAreaCodesPermission bool `json:"includeAreaCodesPermission,omitempty"`
    Now string `json:"now,omitempty"`
    UserId string `json:"userId"`
}

type User__deleteManyInput struct {
    UserIds []string `json:"userIds"`
}

type User__findManyResponseData struct {
    Data []User__findManyResponseData_data `json:"data"`
    Total int64 `json:"total"`
}

type User__meResponseData_data_menus struct {
    Apis string `json:"apis,omitempty"`
    Code string `json:"code,omitempty"`
    Icon string `json:"icon,omitempty"`
    Id int64 `json:"id"`
    Label string `json:"label"`
    Level int64 `json:"level"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path,omitempty"`
    Permission string `json:"permission,omitempty"`
    Sort int64 `json:"sort"`
    Type string `json:"type,omitempty"`
    VisibleInMenu bool `json:"visibleInMenu"`
}

type Log__findManyInternalInput struct {
    Ip string `json:"ip,omitempty"`
    Method string `json:"method,omitempty"`
    OrderBy []*Admin_admin_logOrderByWithRelationInput `json:"orderBy,omitempty"`
    Path string `json:"path,omitempty"`
    Phone string `json:"phone,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type User__casdoor__updateUserResponseData_data struct {
    Code int64 `json:"code,omitempty"`
    Msg string `json:"msg,omitempty"`
}

type Post__findManyResponseData_data struct {
    Author Post__findManyResponseData_data_author `json:"author,omitempty"`
    AuthorId int64 `json:"authorId,omitempty"`
    Category Post__findManyResponseData_data_category `json:"category,omitempty"`
    CategoryId int64 `json:"categoryId,omitempty"`
    Content string `json:"content"`
    CreatedAt string `json:"createdAt"`
    Id int64 `json:"id"`
    Likes int64 `json:"likes"`
    Poster string `json:"poster,omitempty"`
    Title string `json:"title"`
    UpdatedAt string `json:"updatedAt"`
    Views int64 `json:"views"`
}

type Post__findUniqueInput struct {
    Id int64 `json:"id"`
}

type Role__findManyResponseData struct {
    Data []Role__findManyResponseData_data `json:"data"`
    Total int64 `json:"total"`
}

type Area__findMaxSubCodeInternalInput struct {
    ParentCode string `json:"parentCode"`
}

type Log__createOneResponseData_data struct {
    Id int64 `json:"id"`
}

type Menu__updateOneResponseData_data struct {
    Id int64 `json:"id"`
}

type Post__category__findUniqueResponseData_data_posts struct {
    AuthorId int64 `json:"authorId,omitempty"`
    CategoryId int64 `json:"categoryId,omitempty"`
    Content string `json:"content"`
    CreatedAt string `json:"createdAt"`
    Id int64 `json:"id"`
    Poster string `json:"poster,omitempty"`
    Title string `json:"title"`
    UpdatedAt string `json:"updatedAt"`
}
// User__casdoor__refreshTokenResponseData_data
/*  UserResponse */
type User__casdoor__refreshTokenResponseData_data struct {
    Code int64 `json:"code,omitempty"`
    Data User__casdoor__refreshTokenResponseData_data_data `json:"data,omitempty"`
    Msg string `json:"msg,omitempty"`
}

type User__meInput struct {
}

type Admin_demo_areaWhereInput struct {
    AND *Admin_demo_areaWhereInput `json:"AND,omitempty"`
    NOT *Admin_demo_areaWhereInput `json:"NOT,omitempty"`
    OR []*Admin_demo_areaWhereInput `json:"OR,omitempty"`
    Address *Admin_StringNullableFilter `json:"address,omitempty"`
    Code *Admin_StringFilter `json:"code,omitempty"`
    CreatedAt *Admin_DateTimeFilter `json:"createdAt,omitempty"`
    Demo_area_role *Admin_Demo_area_roleListRelationFilter `json:"demo_area_role,omitempty"`
    Id *Admin_IntFilter `json:"id,omitempty"`
    Name *Admin_StringFilter `json:"name,omitempty"`
    ParentCode *Admin_StringFilter `json:"parentCode,omitempty"`
}

type Role__updateOneInput struct {
    Code string `json:"code,omitempty"`
    CreateManyMenuRole *Admin_admin_menu_roleCreateManyAdmin_roleInputEnvelope `json:"createManyMenuRole,omitempty"`
    DeleteManyMenuRoleId int64 `json:"deleteManyMenuRoleId,omitempty"`
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name,omitempty"`
}

type Admin_Demo_areaRelationFilter struct {
    Is *Admin_demo_areaWhereInput `json:"is,omitempty"`
    IsNot *Admin_demo_areaWhereInput `json:"isNot,omitempty"`
}

type Admin_Admin_role_userListRelationFilter struct {
    Every *Admin_admin_role_userWhereInput `json:"every,omitempty"`
    None *Admin_admin_role_userWhereInput `json:"none,omitempty"`
    Some *Admin_admin_role_userWhereInput `json:"some,omitempty"`
}

type Log__findManyResponseData struct {
    Data []Log__findManyResponseData_data `json:"data"`
    Total int64 `json:"total"`
}

type Menu__findMenuByPathResponseData struct {
    Data Menu__findMenuByPathResponseData_data `json:"data,omitempty"`
}

type Post__category__createOneInternalInput struct {
    Name string `json:"name"`
    UpdatedAt string `json:"updatedAt"`
}

type Role__createOneInput struct {
    Code string `json:"code"`
    Description string `json:"description,omitempty"`
    Name string `json:"name"`
}

type Role__updateOneResponseData_data struct {
    Id int64 `json:"id"`
}

type Admin_demo_post_categoryOrderByWithRelationInput struct {
    CreatedAt Admin_SortOrder `json:"createdAt,omitempty"`
    Demo_post *Admin_demo_postOrderByRelationAggregateInput `json:"demo_post,omitempty"`
    Description Admin_SortOrder `json:"description,omitempty"`
    Id Admin_SortOrder `json:"id,omitempty"`
    Name Admin_SortOrder `json:"name,omitempty"`
    UpdatedAt Admin_SortOrder `json:"updatedAt,omitempty"`
}

type Area__findNamesInternalInput struct {
    Codes []string `json:"codes"`
}

type Menu__createOneResponseData struct {
    Data Menu__createOneResponseData_data `json:"data,omitempty"`
}

type Menu__findUniqueInternalInput struct {
    Id int64 `json:"id"`
}

type User__casdoor__updateUserResponseData struct {
    Data User__casdoor__updateUserResponseData_data `json:"data,omitempty"`
}

type Admin_admin_menu_roleWhereInput struct {
    AND *Admin_admin_menu_roleWhereInput `json:"AND,omitempty"`
    NOT *Admin_admin_menu_roleWhereInput `json:"NOT,omitempty"`
    OR []*Admin_admin_menu_roleWhereInput `json:"OR,omitempty"`
    Admin_menu *Admin_Admin_menuRelationFilter `json:"admin_menu,omitempty"`
    Admin_role *Admin_Admin_roleRelationFilter `json:"admin_role,omitempty"`
    CreatedAt *Admin_DateTimeFilter `json:"createdAt,omitempty"`
    Id *Admin_IntFilter `json:"id,omitempty"`
    MenuId *Admin_IntFilter `json:"menuId,omitempty"`
    RoleId *Admin_IntFilter `json:"roleId,omitempty"`
}

type User__countInput struct {
}

type Area__createOneResponseData_data struct {
    Address string `json:"address,omitempty"`
    Code string `json:"code"`
    CreatedAt string `json:"createdAt"`
    Id int64 `json:"id"`
    Name string `json:"name"`
    ParentCode string `json:"parentCode"`
}

type User__countInternalInput struct {
}

type Log__deleteManyResponseData struct {
    Data int64 `json:"data,omitempty"`
}

type Menu__createOneInternalInput struct {
    Apis string `json:"apis,omitempty"`
    Code string `json:"code,omitempty"`
    Icon string `json:"icon,omitempty"`
    Label string `json:"label"`
    Level int64 `json:"level"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path"`
    Permission string `json:"permission,omitempty"`
    Sort int64 `json:"sort,omitempty"`
    Type string `json:"type,omitempty"`
    UpdatedAt string `json:"updatedAt"`
    VisibleInMenu bool `json:"visibleInMenu,omitempty"`
}

type Post__deleteManyInput struct {
    Ids []int64 `json:"ids"`
}

type Role__deleteManyInput struct {
    Codes []string `json:"codes"`
}

type Admin_NestedIntFilter struct {
    Equals int64 `json:"equals,omitempty"`
    Gt int64 `json:"gt,omitempty"`
    Gte int64 `json:"gte,omitempty"`
    In []int64 `json:"in,omitempty"`
    Lt int64 `json:"lt,omitempty"`
    Lte int64 `json:"lte,omitempty"`
    Not *Admin_NestedIntFilter `json:"not,omitempty"`
    NotIn []int64 `json:"notIn,omitempty"`
}

type User__findUniqueResponseData struct {
    Data User__findUniqueResponseData_data `json:"data,omitempty"`
}

type Api__queryRawInternalInput struct {
    Parameters any `json:"parameters,omitempty"`
    Query string `json:"query"`
}

type Post__category__deleteManyResponseData_data struct {
    Count int64 `json:"count"`
}

type Post__findManyInternalInput struct {
    AuthorId int64 `json:"authorId,omitempty"`
    CategoryId int64 `json:"categoryId,omitempty"`
    Content string `json:"content,omitempty"`
    CreateEndDate string `json:"createEndDate,omitempty"`
    CreateStartDate string `json:"createStartDate,omitempty"`
    Email string `json:"email,omitempty"`
    LikesMax int64 `json:"likesMax,omitempty"`
    LikesMin int64 `json:"likesMin,omitempty"`
    OrderBy *Admin_demo_postOrderByWithRelationInput `json:"orderBy,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
    Title string `json:"title,omitempty"`
    ViewsMax int64 `json:"viewsMax,omitempty"`
    ViewsMin int64 `json:"viewsMin,omitempty"`
}

type Role__api__findManyInput struct {
    Path string `json:"path,omitempty"`
    RoleId int64 `json:"roleId,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type Admin_BoolFilter struct {
    Equals bool `json:"equals,omitempty"`
    Not *Admin_NestedBoolFilter `json:"not,omitempty"`
}

type Post__category__findUniqueInternalInput struct {
    Id int64 `json:"id"`
}

type Admin_demo_postOrderByRelationAggregateInput struct {
    Count Admin_SortOrder `json:"_count,omitempty"`
}

type Post__category__findManyResponseData_options struct {
    CreatedAt string `json:"createdAt"`
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name"`
    PostCount int64 `json:"postCount"`
    UpdatedAt string `json:"updatedAt"`
}

type Role__user__updateManyInput struct {
    Data []*Admin_admin_role_userCreateManyInput `json:"data"`
    UserId string `json:"userId,omitempty"`
}

type Area__createOneInternalInput struct {
    Address string `json:"address,omitempty"`
    Code string `json:"code"`
    Name string `json:"name"`
    ParentCode string `json:"parentCode,omitempty"`
}

type Menu__deleteManyResponseData struct {
    Data int64 `json:"data,omitempty"`
}

type Post__createOneInput struct {
    AuthorId int64 `json:"authorId"`
    CategoryId int64 `json:"categoryId"`
    Content string `json:"content"`
    Poster string `json:"poster,omitempty"`
    Title string `json:"title"`
}

type Admin_Admin_menu_roleListRelationFilter struct {
    Every *Admin_admin_menu_roleWhereInput `json:"every,omitempty"`
    None *Admin_admin_menu_roleWhereInput `json:"none,omitempty"`
    Some *Admin_admin_menu_roleWhereInput `json:"some,omitempty"`
}

type Menu__findManyResponseData struct {
    Data []Menu__findManyResponseData_data `json:"data"`
    Total int64 `json:"total"`
}

type Post__findManyResponseData_data_category struct {
    Id int64 `json:"id"`
    Name string `json:"name"`
}

type Admin_admin_menu_roleCreateManyAdmin_roleInput struct {
    CreatedAt string `json:"createdAt,omitempty"`
    Id int64 `json:"id,omitempty"`
    MenuId int64 `json:"menuId"`
}

type Log__createOneResponseData struct {
    Data Log__createOneResponseData_data `json:"data,omitempty"`
}

type Menu__findUniqueResponseData_data_roles struct {
    Code string `json:"code"`
    CreatedAt string `json:"createdAt"`
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name"`
    UpdatedAt string `json:"updatedAt"`
}

type Menu__updateOneInput struct {
    Apis string `json:"apis,omitempty"`
    Icon string `json:"icon,omitempty"`
    Id int64 `json:"id"`
    Label string `json:"label,omitempty"`
    Level int64 `json:"level,omitempty"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path,omitempty"`
    Permission string `json:"permission,omitempty"`
    Schema string `json:"schema,omitempty"`
    Sort int64 `json:"sort,omitempty"`
    Type string `json:"type,omitempty"`
    VisibleInMenu bool `json:"visibleInMenu,omitempty"`
}

type Post__createOneResponseData struct {
    Data Post__createOneResponseData_data `json:"data,omitempty"`
}

type Admin_demo_postOrderByWithRelationInput struct {
    AuthorId Admin_SortOrder `json:"authorId,omitempty"`
    CategoryId Admin_SortOrder `json:"categoryId,omitempty"`
    Content Admin_SortOrder `json:"content,omitempty"`
    CreatedAt Admin_SortOrder `json:"createdAt,omitempty"`
    Demo_post_author *Admin_demo_post_authorOrderByWithRelationInput `json:"demo_post_author,omitempty"`
    Demo_post_category *Admin_demo_post_categoryOrderByWithRelationInput `json:"demo_post_category,omitempty"`
    Id Admin_SortOrder `json:"id,omitempty"`
    Likes Admin_SortOrder `json:"likes,omitempty"`
    Poster Admin_SortOrder `json:"poster,omitempty"`
    Title Admin_SortOrder `json:"title,omitempty"`
    UpdatedAt Admin_SortOrder `json:"updatedAt,omitempty"`
    Views Admin_SortOrder `json:"views,omitempty"`
}

type Admin_NestedStringFilter struct {
    Contains string `json:"contains,omitempty"`
    EndsWith string `json:"endsWith,omitempty"`
    Equals string `json:"equals,omitempty"`
    Gt string `json:"gt,omitempty"`
    Gte string `json:"gte,omitempty"`
    In []string `json:"in,omitempty"`
    Lt string `json:"lt,omitempty"`
    Lte string `json:"lte,omitempty"`
    Not *Admin_NestedStringFilter `json:"not,omitempty"`
    NotIn []string `json:"notIn,omitempty"`
    StartsWith string `json:"startsWith,omitempty"`
}

type Post__category__findManyInput struct {
    Name string `json:"name,omitempty"`
}

type Role__api__findManyInternalInput struct {
    Path string `json:"path,omitempty"`
    RoleId int64 `json:"roleId,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type Admin_admin_roleWhereInput struct {
    AND *Admin_admin_roleWhereInput `json:"AND,omitempty"`
    NOT *Admin_admin_roleWhereInput `json:"NOT,omitempty"`
    OR []*Admin_admin_roleWhereInput `json:"OR,omitempty"`
    Admin_menu_role *Admin_Admin_menu_roleListRelationFilter `json:"admin_menu_role,omitempty"`
    Admin_role_user *Admin_Admin_role_userListRelationFilter `json:"admin_role_user,omitempty"`
    Code *Admin_StringFilter `json:"code,omitempty"`
    CreatedAt *Admin_DateTimeFilter `json:"createdAt,omitempty"`
    Demo_area_role *Admin_Demo_area_roleListRelationFilter `json:"demo_area_role,omitempty"`
    Description *Admin_StringNullableFilter `json:"description,omitempty"`
    Id *Admin_IntFilter `json:"id,omitempty"`
    Name *Admin_StringFilter `json:"name,omitempty"`
    UpdatedAt *Admin_DateTimeFilter `json:"updatedAt,omitempty"`
}

type Area__findManyInput struct {
    Address string `json:"address,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type Area__findMaxSubCodeResponseData struct {
    Data string `json:"data,omitempty"`
}

type User__findUniqueInternalInput struct {
    UserId string `json:"userId"`
}

type User__findManyInternalInput struct {
    Name string `json:"name,omitempty"`
    OrderBy []*Admin_userOrderByWithRelationInput `json:"orderBy,omitempty"`
    Phone string `json:"phone,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
    UserId string `json:"userId,omitempty"`
}

type Api__executeRawInput struct {
    Parameters any `json:"parameters,omitempty"`
    Query string `json:"query"`
}

type Area__findManyInternalInput struct {
    OR []*Admin_demo_areaWhereInput `json:"OR"`
    Address string `json:"address,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type Log__createOneInput struct {
    Body string `json:"body,omitempty"`
    Cost float64 `json:"cost,omitempty"`
    Error string `json:"error,omitempty"`
    Ip string `json:"ip"`
    Method string `json:"method"`
    Path string `json:"path"`
    RequestId string `json:"requestId"`
    Status string `json:"status,omitempty"`
    Ua string `json:"ua"`
    UserId string `json:"userId,omitempty"`
}

type Menu__deleteManyInternalInput struct {
    Ids []int64 `json:"ids"`
}

type Post__updateOneInput struct {
    AuthorId int64 `json:"authorId,omitempty"`
    CategoryId int64 `json:"categoryId,omitempty"`
    Content string `json:"content,omitempty"`
    Id int64 `json:"id"`
    Poster string `json:"poster,omitempty"`
    Title string `json:"title,omitempty"`
}

type User__casdoor__addUserResponseData_data struct {
    Code int64 `json:"code,omitempty"`
    Msg string `json:"msg,omitempty"`
}

type Admin_StringNullableFilter struct {
    Contains string `json:"contains,omitempty"`
    EndsWith string `json:"endsWith,omitempty"`
    Equals string `json:"equals,omitempty"`
    Gt string `json:"gt,omitempty"`
    Gte string `json:"gte,omitempty"`
    In []string `json:"in,omitempty"`
    Lt string `json:"lt,omitempty"`
    Lte string `json:"lte,omitempty"`
    Not *Admin_NestedStringNullableFilter `json:"not,omitempty"`
    NotIn []string `json:"notIn,omitempty"`
    StartsWith string `json:"startsWith,omitempty"`
}

type Post__author__findManyResponseData struct {
    Options []Post__author__findManyResponseData_options `json:"options"`
}

type Role__findManyInternalInput struct {
    Code string `json:"code,omitempty"`
    Name string `json:"name,omitempty"`
    OrderBy []*Admin_admin_roleOrderByWithRelationInput `json:"orderBy,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
}

type User__casdoor__addUserInternalInput struct {
    Avatar string `json:"avatar,omitempty"`
    /* Country code, default CN */
CountryCode string `json:"countryCode,omitempty"`
    /* User name */
Name string `json:"name,omitempty"`
    /* Password */
Password string `json:"password,omitempty"`
    /* Phone number */
Phone string `json:"phone,omitempty"`
}

type Admin_NestedStringNullableFilter struct {
    Contains string `json:"contains,omitempty"`
    EndsWith string `json:"endsWith,omitempty"`
    Equals string `json:"equals,omitempty"`
    Gt string `json:"gt,omitempty"`
    Gte string `json:"gte,omitempty"`
    In []string `json:"in,omitempty"`
    Lt string `json:"lt,omitempty"`
    Lte string `json:"lte,omitempty"`
    Not *Admin_NestedStringNullableFilter `json:"not,omitempty"`
    NotIn []string `json:"notIn,omitempty"`
    StartsWith string `json:"startsWith,omitempty"`
}

type Admin_NestedBoolFilter struct {
    Equals bool `json:"equals,omitempty"`
    Not *Admin_NestedBoolFilter `json:"not,omitempty"`
}

type Api__listPublicResponseData struct {
    Data []Api__listPublicResponseData_data `json:"data,omitempty"`
}

type Menu__findUniqueResponseData struct {
    Data Menu__findUniqueResponseData_data `json:"data,omitempty"`
}

type Post__findUniqueResponseData_data struct {
    AuthorId int64 `json:"authorId,omitempty"`
    Category Post__findUniqueResponseData_data_category `json:"category,omitempty"`
    CategoryId int64 `json:"categoryId,omitempty"`
    Content string `json:"content"`
    CreatedAt string `json:"createdAt"`
    Id int64 `json:"id"`
    Poster string `json:"poster,omitempty"`
    Title string `json:"title"`
    UpdatedAt string `json:"updatedAt"`
}

type User__casdoor__sendCodeInternalInput struct {
    /* Country code, default CN */
CountryCode string `json:"countryCode,omitempty"`
    /* Destination phone number */
Dest string `json:"dest"`
}

type Admin_demo_area_roleWhereInput struct {
    AND *Admin_demo_area_roleWhereInput `json:"AND,omitempty"`
    NOT *Admin_demo_area_roleWhereInput `json:"NOT,omitempty"`
    OR []*Admin_demo_area_roleWhereInput `json:"OR,omitempty"`
    Admin_role *Admin_Admin_roleRelationFilter `json:"admin_role,omitempty"`
    AreaId *Admin_IntFilter `json:"areaId,omitempty"`
    CreatedAt *Admin_DateTimeFilter `json:"createdAt,omitempty"`
    Demo_area *Admin_Demo_areaRelationFilter `json:"demo_area,omitempty"`
    Id *Admin_IntFilter `json:"id,omitempty"`
    RoleId *Admin_IntFilter `json:"roleId,omitempty"`
}

type Area__findManyResponseData_data struct {
    Address string `json:"address,omitempty"`
    Code string `json:"code"`
    CreatedAt string `json:"createdAt"`
    Id int64 `json:"id"`
    Name string `json:"name"`
    ParentCode string `json:"parentCode"`
}

type Menu__deleteManyInput struct {
    Ids []int64 `json:"ids"`
}

type Post__category__findUniqueResponseData_data struct {
    CreatedAt string `json:"createdAt"`
    Description string `json:"description,omitempty"`
    Id int64 `json:"id"`
    Name string `json:"name"`
    Posts []Post__category__findUniqueResponseData_data_posts `json:"posts,omitempty"`
    UpdatedAt string `json:"updatedAt"`
}

type Role__createOneInternalInput struct {
    Code string `json:"code"`
    Description string `json:"description,omitempty"`
    Name string `json:"name"`
    UpdatedAt string `json:"updatedAt"`
}

type User__findUniqueInput struct {
    UserId string `json:"userId"`
}

type Post__findUniqueResponseData struct {
    Data Post__findUniqueResponseData_data `json:"data,omitempty"`
}

type User__casdoor__refreshTokenResponseData_data_data struct {
    AccessToken string `json:"accessToken,omitempty"`
    ExpireIn int64 `json:"expireIn,omitempty"`
    RefreshToken string `json:"refreshToken,omitempty"`
}

type User__countResponseData struct {
    Data int64 `json:"data"`
}

type Admin_IntFilter struct {
    Equals int64 `json:"equals,omitempty"`
    Gt int64 `json:"gt,omitempty"`
    Gte int64 `json:"gte,omitempty"`
    In []int64 `json:"in,omitempty"`
    Lt int64 `json:"lt,omitempty"`
    Lte int64 `json:"lte,omitempty"`
    Not *Admin_NestedIntFilter `json:"not,omitempty"`
    NotIn []int64 `json:"notIn,omitempty"`
}

type Area__findNamesInput struct {
    Codes []string `json:"codes"`
}

type Menu__findManyResponseData_data struct {
    Apis string `json:"apis,omitempty"`
    Code string `json:"code,omitempty"`
    CreatedAt string `json:"createdAt"`
    Icon string `json:"icon,omitempty"`
    Id int64 `json:"id"`
    Label string `json:"label"`
    Level int64 `json:"level"`
    ParentId int64 `json:"parentId,omitempty"`
    Path string `json:"path,omitempty"`
    Permission string `json:"permission,omitempty"`
    Schema string `json:"schema,omitempty"`
    Sort int64 `json:"sort"`
    Type string `json:"type,omitempty"`
    UpdatedAt string `json:"updatedAt"`
    VisibleInMenu bool `json:"visibleInMenu"`
}

type Menu__findMenuByPathResponseData_data struct {
    Id int64 `json:"id"`
    Schema string `json:"schema,omitempty"`
}

type Post__category__findUniqueResponseData struct {
    Data Post__category__findUniqueResponseData_data `json:"data,omitempty"`
}

type Log__findManyResponseData_data struct {
    Body string `json:"body,omitempty"`
    Cost float64 `json:"cost,omitempty"`
    CreatedAt string `json:"createdAt"`
    Error string `json:"error,omitempty"`
    Id int64 `json:"id"`
    Ip string `json:"ip"`
    Method string `json:"method"`
    Path string `json:"path"`
    RequestId string `json:"requestId"`
    Status string `json:"status,omitempty"`
    Ua string `json:"ua"`
    UserId string `json:"userId,omitempty"`
}

type Post__author__findManyInternalInput struct {
}

type Post__findManyInput struct {
    AuthorId int64 `json:"authorId,omitempty"`
    CategoryId int64 `json:"categoryId,omitempty"`
    Content string `json:"content,omitempty"`
    CreateEndDate string `json:"createEndDate,omitempty"`
    CreateStartDate string `json:"createStartDate,omitempty"`
    Email string `json:"email,omitempty"`
    LikesMax int64 `json:"likesMax,omitempty"`
    LikesMin int64 `json:"likesMin,omitempty"`
    OrderBy *Admin_demo_postOrderByWithRelationInput `json:"orderBy,omitempty"`
    Skip int64 `json:"skip,omitempty"`
    Take int64 `json:"take,omitempty"`
    Title string `json:"title,omitempty"`
    ViewsMax int64 `json:"viewsMax,omitempty"`
    ViewsMin int64 `json:"viewsMin,omitempty"`
}

type Post__category__findManyInternalInput struct {
    Name string `json:"name,omitempty"`
}

type Post__category__findManyResponseData struct {
    Options []Post__category__findManyResponseData_options `json:"options"`
}

type Post__deleteManyResponseData_data struct {
    Count int64 `json:"count"`
}

type User__findManyResponseData_data struct {
    Avatar string `json:"avatar,omitempty"`
    CountryCode string `json:"countryCode,omitempty"`
    CreatedAt string `json:"createdAt"`
    Id int64 `json:"id"`
    Name string `json:"name,omitempty"`
    Password string `json:"password,omitempty"`
    PasswordSalt string `json:"passwordSalt,omitempty"`
    PasswordType string `json:"passwordType,omitempty"`
    Phone string `json:"phone,omitempty"`
    Roles []User__findManyResponseData_data_roles `json:"roles"`
    UserId string `json:"userId"`
}

type Admin_SortOrder string
const (
    Admin_SortOrder_asc Admin_SortOrder = "asc"
    Admin_SortOrder_desc Admin_SortOrder = "desc"
)
type Casdoor_login_post_input_object_loginType_enum string
const (
    Casdoor_login_post_input_object_loginType_enum_app Casdoor_login_post_input_object_loginType_enum = "app"
    Casdoor_login_post_input_object_loginType_enum_h5 Casdoor_login_post_input_object_loginType_enum = "h5"
    Casdoor_login_post_input_object_loginType_enum_mini Casdoor_login_post_input_object_loginType_enum = "mini"
    Casdoor_login_post_input_object_loginType_enum_password Casdoor_login_post_input_object_loginType_enum = "password"
    Casdoor_login_post_input_object_loginType_enum_sms Casdoor_login_post_input_object_loginType_enum = "sms"
    Casdoor_login_post_input_object_loginType_enum_web Casdoor_login_post_input_object_loginType_enum = "web"
)
