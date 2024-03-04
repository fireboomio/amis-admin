package generated

import "custom-go/pkg/base"

type (

    Api__executeRawBody = *base.OperationBody[Api__executeRawInternalInput, Api__executeRawResponseData]
    
    Api__listPublicBody = *base.OperationBody[Api__listPublicInternalInput, Api__listPublicResponseData]
    
    Api__queryRawBody = *base.OperationBody[Api__queryRawInternalInput, Api__queryRawResponseData]
    
    Area__createOneBody = *base.OperationBody[Area__createOneInternalInput, Area__createOneResponseData]
    
    Area__findManyBody = *base.OperationBody[Area__findManyInternalInput, Area__findManyResponseData]
    
    Area__findMaxSubCodeBody = *base.OperationBody[Area__findMaxSubCodeInternalInput, Area__findMaxSubCodeResponseData]
    
    Area__findNamesBody = *base.OperationBody[Area__findNamesInternalInput, Area__findNamesResponseData]
    
    Log__createOneBody = *base.OperationBody[Log__createOneInternalInput, Log__createOneResponseData]
    
    Log__deleteManyBody = *base.OperationBody[Log__deleteManyInternalInput, Log__deleteManyResponseData]
    
    Log__findManyBody = *base.OperationBody[Log__findManyInternalInput, Log__findManyResponseData]
    
    Menu__createOneBody = *base.OperationBody[Menu__createOneInternalInput, Menu__createOneResponseData]
    
    Menu__deleteManyBody = *base.OperationBody[Menu__deleteManyInternalInput, Menu__deleteManyResponseData]
    
    Menu__findManyBody = *base.OperationBody[Menu__findManyInternalInput, Menu__findManyResponseData]
    
    Menu__findMenuByPathBody = *base.OperationBody[Menu__findMenuByPathInternalInput, Menu__findMenuByPathResponseData]
    
    Menu__findUniqueBody = *base.OperationBody[Menu__findUniqueInternalInput, Menu__findUniqueResponseData]
    
    Menu__updateOneBody = *base.OperationBody[Menu__updateOneInternalInput, Menu__updateOneResponseData]
    
    Post__author__findManyBody = *base.OperationBody[Post__author__findManyInternalInput, Post__author__findManyResponseData]
    
    Post__category__createOneBody = *base.OperationBody[Post__category__createOneInternalInput, Post__category__createOneResponseData]
    
    Post__category__deleteManyBody = *base.OperationBody[Post__category__deleteManyInternalInput, Post__category__deleteManyResponseData]
    
    Post__category__findManyBody = *base.OperationBody[Post__category__findManyInternalInput, Post__category__findManyResponseData]
    
    Post__category__findUniqueBody = *base.OperationBody[Post__category__findUniqueInternalInput, Post__category__findUniqueResponseData]
    
    Post__category__updateOneBody = *base.OperationBody[Post__category__updateOneInternalInput, Post__category__updateOneResponseData]
    
    Post__createOneBody = *base.OperationBody[Post__createOneInternalInput, Post__createOneResponseData]
    
    Post__deleteManyBody = *base.OperationBody[Post__deleteManyInternalInput, Post__deleteManyResponseData]
    
    Post__findManyBody = *base.OperationBody[Post__findManyInternalInput, Post__findManyResponseData]
    
    Post__findUniqueBody = *base.OperationBody[Post__findUniqueInternalInput, Post__findUniqueResponseData]
    
    Post__updateOneBody = *base.OperationBody[Post__updateOneInternalInput, Post__updateOneResponseData]
    
    Role__api__findManyBody = *base.OperationBody[Role__api__findManyInternalInput, Role__api__findManyResponseData]
    
    Role__createOneBody = *base.OperationBody[Role__createOneInternalInput, Role__createOneResponseData]
    
    Role__deleteManyBody = *base.OperationBody[Role__deleteManyInternalInput, Role__deleteManyResponseData]
    
    Role__findManyBody = *base.OperationBody[Role__findManyInternalInput, Role__findManyResponseData]
    
    Role__findUniqueBody = *base.OperationBody[Role__findUniqueInternalInput, Role__findUniqueResponseData]
    
    Role__updateOneBody = *base.OperationBody[Role__updateOneInternalInput, Role__updateOneResponseData]
    
    Role__user__updateManyBody = *base.OperationBody[Role__user__updateManyInternalInput, Role__user__updateManyResponseData]
    
    User__casdoor__addUserBody = *base.OperationBody[User__casdoor__addUserInternalInput, User__casdoor__addUserResponseData]
    
    User__casdoor__loginBody = *base.OperationBody[User__casdoor__loginInternalInput, User__casdoor__loginResponseData]
    
    User__casdoor__refreshTokenBody = *base.OperationBody[User__casdoor__refreshTokenInternalInput, User__casdoor__refreshTokenResponseData]
    
    User__casdoor__sendCodeBody = *base.OperationBody[User__casdoor__sendCodeInternalInput, User__casdoor__sendCodeResponseData]
    
    User__casdoor__updateUserBody = *base.OperationBody[User__casdoor__updateUserInternalInput, User__casdoor__updateUserResponseData]
    
    User__countBody = *base.OperationBody[User__countInternalInput, User__countResponseData]
    
    User__deleteManyBody = *base.OperationBody[User__deleteManyInternalInput, User__deleteManyResponseData]
    
    User__findManyBody = *base.OperationBody[User__findManyInternalInput, User__findManyResponseData]
    
    User__findUniqueBody = *base.OperationBody[User__findUniqueInternalInput, User__findUniqueResponseData]
    
    User__meBody = *base.OperationBody[User__meInternalInput, User__meResponseData]
    )

const (
    Api__listPublic = "api/listPublic"
    Area__findMany = "area/findMany"
    Area__findMaxSubCode = "area/findMaxSubCode"
    Area__findNames = "area/findNames"
    Log__findMany = "log/findMany"
    Menu__findMany = "menu/findMany"
    Menu__findMenuByPath = "menu/findMenuByPath"
    Menu__findUnique = "menu/findUnique"
    Post__author__findMany = "post/author/findMany"
    Post__category__findMany = "post/category/findMany"
    Post__category__findUnique = "post/category/findUnique"
    Post__findMany = "post/findMany"
    Post__findUnique = "post/findUnique"
    Role__api__findMany = "role/api/findMany"
    Role__findMany = "role/findMany"
    Role__findUnique = "role/findUnique"
    User__count = "user/count"
    User__findMany = "user/findMany"
    User__findUnique = "user/findUnique"
    User__me = "user/me"
)

const (
    Api__executeRaw = "api/executeRaw"
    Api__queryRaw = "api/queryRaw"
    Area__createOne = "area/createOne"
    Log__createOne = "log/createOne"
    Log__deleteMany = "log/deleteMany"
    Menu__createOne = "menu/createOne"
    Menu__deleteMany = "menu/deleteMany"
    Menu__updateOne = "menu/updateOne"
    Post__category__createOne = "post/category/createOne"
    Post__category__deleteMany = "post/category/deleteMany"
    Post__category__updateOne = "post/category/updateOne"
    Post__createOne = "post/createOne"
    Post__deleteMany = "post/deleteMany"
    Post__updateOne = "post/updateOne"
    Role__createOne = "role/createOne"
    Role__deleteMany = "role/deleteMany"
    Role__updateOne = "role/updateOne"
    Role__user__updateMany = "role/user/updateMany"
    User__casdoor__addUser = "user/casdoor/addUser"
    User__casdoor__login = "user/casdoor/login"
    User__casdoor__refreshToken = "user/casdoor/refreshToken"
    User__casdoor__sendCode = "user/casdoor/sendCode"
    User__casdoor__updateUser = "user/casdoor/updateUser"
    User__deleteMany = "user/deleteMany"
)
