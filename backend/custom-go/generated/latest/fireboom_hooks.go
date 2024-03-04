package generated

import "custom-go/pkg/plugins"
import "custom-go/generated"

var (
    Api__executeRaw = plugins.NewOperationMeta[generated.Api__executeRawInternalInput, generated.Api__executeRawResponseData]("api/executeRaw", 1)
    Api__listPublic = plugins.NewOperationMeta[generated.Api__listPublicInternalInput, generated.Api__listPublicResponseData]("api/listPublic", 0)
    Api__queryRaw = plugins.NewOperationMeta[generated.Api__queryRawInternalInput, generated.Api__queryRawResponseData]("api/queryRaw", 1)
    Area__createOne = plugins.NewOperationMeta[generated.Area__createOneInternalInput, generated.Area__createOneResponseData]("area/createOne", 1)
    Area__findMany = plugins.NewOperationMeta[generated.Area__findManyInternalInput, generated.Area__findManyResponseData]("area/findMany", 0)
    Area__findMaxSubCode = plugins.NewOperationMeta[generated.Area__findMaxSubCodeInternalInput, generated.Area__findMaxSubCodeResponseData]("area/findMaxSubCode", 0)
    Area__findNames = plugins.NewOperationMeta[generated.Area__findNamesInternalInput, generated.Area__findNamesResponseData]("area/findNames", 0)
    Log__createOne = plugins.NewOperationMeta[generated.Log__createOneInternalInput, generated.Log__createOneResponseData]("log/createOne", 1)
    Log__deleteMany = plugins.NewOperationMeta[generated.Log__deleteManyInternalInput, generated.Log__deleteManyResponseData]("log/deleteMany", 1)
    Log__findMany = plugins.NewOperationMeta[generated.Log__findManyInternalInput, generated.Log__findManyResponseData]("log/findMany", 0)
    Menu__createOne = plugins.NewOperationMeta[generated.Menu__createOneInternalInput, generated.Menu__createOneResponseData]("menu/createOne", 1)
    Menu__deleteMany = plugins.NewOperationMeta[generated.Menu__deleteManyInternalInput, generated.Menu__deleteManyResponseData]("menu/deleteMany", 1)
    Menu__findMany = plugins.NewOperationMeta[generated.Menu__findManyInternalInput, generated.Menu__findManyResponseData]("menu/findMany", 0)
    Menu__findMenuByPath = plugins.NewOperationMeta[generated.Menu__findMenuByPathInternalInput, generated.Menu__findMenuByPathResponseData]("menu/findMenuByPath", 0)
    Menu__findUnique = plugins.NewOperationMeta[generated.Menu__findUniqueInternalInput, generated.Menu__findUniqueResponseData]("menu/findUnique", 0)
    Menu__updateOne = plugins.NewOperationMeta[generated.Menu__updateOneInternalInput, generated.Menu__updateOneResponseData]("menu/updateOne", 1)
    Post__author__findMany = plugins.NewOperationMeta[generated.Post__author__findManyInternalInput, generated.Post__author__findManyResponseData]("post/author/findMany", 0)
    Post__category__createOne = plugins.NewOperationMeta[generated.Post__category__createOneInternalInput, generated.Post__category__createOneResponseData]("post/category/createOne", 1)
    Post__category__deleteMany = plugins.NewOperationMeta[generated.Post__category__deleteManyInternalInput, generated.Post__category__deleteManyResponseData]("post/category/deleteMany", 1)
    Post__category__findMany = plugins.NewOperationMeta[generated.Post__category__findManyInternalInput, generated.Post__category__findManyResponseData]("post/category/findMany", 0)
    Post__category__findUnique = plugins.NewOperationMeta[generated.Post__category__findUniqueInternalInput, generated.Post__category__findUniqueResponseData]("post/category/findUnique", 0)
    Post__category__updateOne = plugins.NewOperationMeta[generated.Post__category__updateOneInternalInput, generated.Post__category__updateOneResponseData]("post/category/updateOne", 1)
    Post__createOne = plugins.NewOperationMeta[generated.Post__createOneInternalInput, generated.Post__createOneResponseData]("post/createOne", 1)
    Post__deleteMany = plugins.NewOperationMeta[generated.Post__deleteManyInternalInput, generated.Post__deleteManyResponseData]("post/deleteMany", 1)
    Post__findMany = plugins.NewOperationMeta[generated.Post__findManyInternalInput, generated.Post__findManyResponseData]("post/findMany", 0)
    Post__findUnique = plugins.NewOperationMeta[generated.Post__findUniqueInternalInput, generated.Post__findUniqueResponseData]("post/findUnique", 0)
    Post__updateOne = plugins.NewOperationMeta[generated.Post__updateOneInternalInput, generated.Post__updateOneResponseData]("post/updateOne", 1)
    Role__api__findMany = plugins.NewOperationMeta[generated.Role__api__findManyInternalInput, generated.Role__api__findManyResponseData]("role/api/findMany", 0)
    Role__createOne = plugins.NewOperationMeta[generated.Role__createOneInternalInput, generated.Role__createOneResponseData]("role/createOne", 1)
    Role__deleteMany = plugins.NewOperationMeta[generated.Role__deleteManyInternalInput, generated.Role__deleteManyResponseData]("role/deleteMany", 1)
    Role__findMany = plugins.NewOperationMeta[generated.Role__findManyInternalInput, generated.Role__findManyResponseData]("role/findMany", 0)
    Role__findUnique = plugins.NewOperationMeta[generated.Role__findUniqueInternalInput, generated.Role__findUniqueResponseData]("role/findUnique", 0)
    Role__updateOne = plugins.NewOperationMeta[generated.Role__updateOneInternalInput, generated.Role__updateOneResponseData]("role/updateOne", 1)
    Role__user__updateMany = plugins.NewOperationMeta[generated.Role__user__updateManyInternalInput, generated.Role__user__updateManyResponseData]("role/user/updateMany", 1)
    User__casdoor__addUser = plugins.NewOperationMeta[generated.User__casdoor__addUserInternalInput, generated.User__casdoor__addUserResponseData]("user/casdoor/addUser", 1)
    User__casdoor__login = plugins.NewOperationMeta[generated.User__casdoor__loginInternalInput, generated.User__casdoor__loginResponseData]("user/casdoor/login", 1)
    User__casdoor__refreshToken = plugins.NewOperationMeta[generated.User__casdoor__refreshTokenInternalInput, generated.User__casdoor__refreshTokenResponseData]("user/casdoor/refreshToken", 1)
    User__casdoor__sendCode = plugins.NewOperationMeta[generated.User__casdoor__sendCodeInternalInput, generated.User__casdoor__sendCodeResponseData]("user/casdoor/sendCode", 1)
    User__casdoor__updateUser = plugins.NewOperationMeta[generated.User__casdoor__updateUserInternalInput, generated.User__casdoor__updateUserResponseData]("user/casdoor/updateUser", 1)
    User__count = plugins.NewOperationMeta[generated.User__countInternalInput, generated.User__countResponseData]("user/count", 0)
    User__deleteMany = plugins.NewOperationMeta[generated.User__deleteManyInternalInput, generated.User__deleteManyResponseData]("user/deleteMany", 1)
    User__findMany = plugins.NewOperationMeta[generated.User__findManyInternalInput, generated.User__findManyResponseData]("user/findMany", 0)
    User__findUnique = plugins.NewOperationMeta[generated.User__findUniqueInternalInput, generated.User__findUniqueResponseData]("user/findUnique", 0)
    User__me = plugins.NewOperationMeta[generated.User__meInternalInput, generated.User__meResponseData]("user/me", 0)
)

var (
    UploadClient_tengxunyun = &plugins.UploadClient{"tengxunyun"}
)

const (
)