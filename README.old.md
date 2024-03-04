# 飞布后台管理项目介绍

本项目为飞布后台管理项目，是学习了解进而玩转飞布的最佳实践。采用 Mysql 数据库，开发使用 Golang 语言。

飞布官网：https://www.fireboom.io/

采用飞布可以快速开发后端增删改查接口，也可以自定义数据操作完成复杂任务的开发，大大缩减了项目交付的时间，让后端开发人员从增删改查中解放出来，更注重于业务层面。可以说是一种全新的后端开发形式。

前端项目请移步：https://github.com/Echoidf/fireboom-admin-web.git

## 开发环境依赖

- go > 1.20
- node > 18
- pnpm > 8

# 本地启动

git clone

pnpm i

下载 oidc 文件放入根目录 oidc 文件夹中

chmod +x oidc/oidc

cd backend/custom-go

go mod tidy

sh update.sh (必须在 backend 目录执行，否则生成的飞布文件会在执行时的目录)

回根目录

vscode 使用插件穿透到 freetalk 服务器

启动vscode 内终端页

点击 PORT 增加一个 3306 的端口映射

pnpm dev 启动前端

pnpm fb 启动后端

## 快速启动

使用docker-compose启动飞布后台管理系统。直接执行start.sh或者进入backend目录下面，执行docker-compose up -d 快速启动飞布的前端和后端。

注意⚠️：

1.dokcer-compose.yaml文件规定了启动的前端容器和后端容器的名字，由于需要跨容器进行通信，所以在front目录下存在nginx.conf.template文件，对前端发起的请求进行了转发，proxy_pass的host地址为后端容器的名称，如果需要修改，需先修改docker-compose.yaml中后端容器的名字，在修改nginx.conf.template中proxy_pass的地址。

2.docker-compose.yaml启动已经配置了数据库启动，服务能否正常运行需要等待数据库启动完成之后将所需的数据写入，这可能会花费一些时间，之后重新编译飞布即可。

## 登录认证

我们的演示服务基于 **Casdoor** 进行了精简，自研部署了一套符合 OIDC 协议的登录认证服务，将其作为 **OpenAPI数据源**注册到飞步，支持手机短信登录和密码登录

> OIDC 是一种用于身份验证和授权的开放式协议。它建立在OAuth 2.0基础上，并为第三方应用程序提供了一种方便的方法来验证用户身份并获取用户信息，例如名称、邮件地址等。OIDC还支持单点登录（SSO），以便用户只需在一个地方登录，就可以访问多个应用程序。

可能刚入门的同学对OIDC并不了解，在传统的单体服务架构中，我们对接口的安全控制只需要使用JWT进行签发token，在后端对需要安全拦截的接口进行token认证就可以了，在Java SpringBoot项目中可以很方便地使用一些框架或者类库（如Shiro/SpringSecurity等）实现这一点。但是在分布式架构中，我们的服务可能还要接入第三方服务商，比如使用微信、QQ登录，此时token认证商是三方的服务，这个时候就有可能需要我们提供token认证的方法给三方服务。`cert`通常代表着公私钥对中的私钥，用于对JWT进行签名，验证Token时使用公钥进行解密和验证。那么我们是需要把公钥暴露给三方服务的。在飞布控制台我们可以去按照一定的规范添加身份验证商。详细请见角色和权限控制。

## 数据增删改查

利用飞步控制台**图形化界面**快速开发增删改查接口，并且可以自动生成 swagger 文档【飞布内部集成】

支持MySQL 、MongoDB、SQL Server等多种数据源，点击这里查看[支持的数据源](https://ansons-organization.gitbook.io/product-manual/kai-fa-wen-dang/shu-ju-yuan)

## 自定义数据源

飞步拥有良好的扩展能力，当图形化界面无法支持您的需求时，可以自定义数据源和Schema进行操作，可以参考本项目中 statistics 数据源，可以执行原生 SQL 语句对数据进行任意操作、组合和包装。

例如在本项目中自定义了数据源 statistics ，用于编写前端需要的Echarts图表数据，可以在代码中执行原生sql，并支持自定义入参和出参的结构。

如何自定义数据源：

参考下图目录结构，在`custom-go/customize`目录下创建`statistics.go`，即意味着需要创建名为 `statistics `的自定义数据源

![image-20230711091103422](https://zql-oss1.oss-cn-nanjing.aliyuncs.com/notes/image-20230711091103422.png)

该类型的go代码文件格式如下：

```go
var Statistics_schema, _ = graphql.NewSchema(graphql.SchemaConfig{
    Query: ...
    Mutation: ...
})
```

编写完成重启项目后会在 `server/fireboom_server.go`中生成如下代码：

```go
GraphqlServers: []plugins.GraphQLServerConfig{
			{
				ApiNamespace:          "statistics",
				ServerName:            "statistics",
				EnableGraphQLEndpoint: true,
				Schema:                customize.Statistics_schema,
			},
},
```

此时我们就可以在飞布的控制台内省刷新后查看自定义数据源中定义的查询或变更等接口，也可以通过在图形化界面上勾选的方式选择入参和出参

![image-20230719092923644](https://zql-oss1.oss-cn-nanjing.aliyuncs.com/notes/image-20230719092923644.png)

## 自定义 Proxy 钩子

使用 Proxy 钩子可以**自定义接口**，编写的 Proxy 文件位于`custom-go/proxys/` 目录下，注册的接口名称根据目录和文件名生成。例如本项目中`custom-go/proxys/login.go`，则生成的接口名为`proxy/login`。

更多可以参考项目案例：https://github.com/fireboomio/simple-firetalk/blob/master/custom-go%2Fproxys%2FpayNotify%2FaliPay.go

## 角色和权限控制

- 前端控制：

  用户登录时返回动态路由、用户信息、用户权限等数据，前端根据这些数据动态地生成菜单，保存用户数据。比如用户admin具有管理员和普通用户两种角色（注意：用户是可以拥有多种角色的），登录后根据用户角色查询所具有的权限列表，返回给前端，前端使用directive指令判断用户权限是否存在，从而决定是否显示操作对应的按钮或链接等。

- 身份验证：

  参考官方文档：https://ansons-organization.gitbook.io/product-manual/kai-fa-wen-dang/yan-zheng-he-shou-quan/shen-fen-yan-zheng

  根据 casdoor 提供的路由信息在飞布控制台添加并配置身份验证

  ![image-20230710164515669](https://zql-oss1.oss-cn-nanjing.aliyuncs.com/notes/image-20230710164515669.png)

  飞布根据 Issuer 生成服务发现地址，其中 http://127.0.0.1:10021/ 为 casdoor 服务地址，http://127.0.0.1:10021/.well-known/openid-configuration 为服务发现地址，返回数据中定义了包括但不限于：

  - 用户端点url：userinfo_endpoint
  - jwks访问url：jwks_uri

  飞布根据这些信息解析出`jwks_uri`后，就可以对请求进行`token`认证

  补充：

  > JWKS (JSON Web Key Set) 代表了用于身份验证和授权的一组JSON格式的Web密钥。它是OAuth 2.0和OpenID Connect等身份验证和授权协议中的一部分。JWKS通常用于在安全的方式下公开API的公钥和其他安全参数。
  >
  > JWKS包含一个包含一组密钥的JSON对象，每个密钥都有一个唯一的标识符（kid），并提供其算法（alg）、密钥类型（kty）和公钥（用于验证签名）或私钥（用于生成签名）等信息。通常，JWKS中的密钥是使用非对称加密算法生成的，如RSA或ECDSA。
  >
  > 在OAuth 2.0和OpenID Connect中，JWKS用于验证由身份提供者（如认证服务器）签名的访问令牌或ID令牌。客户端可以通过从指定的JWKS端点获取JWKS并验证签名，来确保令牌的身份验证和完整性。
  >
  > 总结来说，JWKS是一个存储公钥和其他安全参数的JSON对象，用于身份验证和授权协议中的安全验证和签名操作。

  **如何通过自定义的身份验证提供商进行请求拦截校验呢？**

  飞布提供了全局的身份验证钩子，可以在钩子函数中进行操作

  ![image-20230711133357144](https://zql-oss1.oss-cn-nanjing.aliyuncs.com/notes/image-20230711133357144.png)

  这里的 `mutatingPostAuthentication` 钩子功能如下：

  用户身份验证后，会调用此函数，可以在此函数中手动控制用户身份验证结果，返回 ok 表示验证通过，deny 表示验证失败。 验证通过时，可以修改返回的user对象，如果不需要修改，则直接返回入参的user即可。

  其他钩子请参考官方文档：[fireboom.io](https://ansons-organization.gitbook.io/product-manual/kai-fa-wen-dang/gou-zi-ji-zhi/node-gou-zi#mutatingpostauthentication)

  在此钩子中，飞布对请求携带的Authorization请求头进行解析，通过前面我们配置的身份验证提供商获取用户信息，并将其传入钩子函数中，我们可以在这个地方查询用户的所属角色，填充用户的角色属性，这样就可以与飞布自带的RBAC指令进行串联，从而实现请求拦截校验的目的。

- 飞布RBAC指令

  在飞布中创建的每一个API都存储在store/list/FbOperation文件中，其中记录了每个API的信息，格式如下：

  ```
  {
  		"content": "mutation QueryRaw($query: String!) {\n      main_queryRaw(query: $query)\n}",
  		"createTime": "2023-06-25 05:44:48Z",
  		"deleteTime": "",
  		"enabled": true,
  		"id": 2019540587708416,
  		"illegal": false,
  		"isPublic": true,
  		"liveQuery": false,
  		"method": "POST",
  		"operationType": "mutations",
  		"remark": "",
  		"restUrl": "",
  		"roleType": "requireMatchAny",
  		"roles": "[\"admin\"]",
  		"title": "/Statistics/QueryRaw",
  		"updateTime": "2023-07-07 07:43:27Z"
  }
  ```

  其中`roles`和`roleType`控制了API访问所需要的角色，`requireMatchAny` 表示只要匹配任意一种角色就可以。

  **飞布底层支持有相关的几个接口：**

  | API                       | 说明                            | 参数                     |
  | ------------------------- | ------------------------------- | ------------------------ |
  | /api/v1/operateApi/opened | 获取通过飞布创建的所有开启的API | 无                       |
  | /api/v1/role/bindApi      | 为角色绑定API                   | roleCode, apis, allRoles |
  | /api/v1/role/apis         | 获取角色已绑定的API             | code, roleType           |

  注：roleType 为可选参数，并且为枚举类型

  | roleType        | 说明                   |
  | --------------- | ---------------------- |
  | requireMatchAll | 需要匹配所有角色       |
  | requireMatchAny | 需要匹配任意一个角色   |
  | denyMatchAll    | 匹配所有角色则拒绝访问 |
  | denyMatchAny    | 匹配任一角色则拒绝访问 |

## Docker 打包部署

### 构建

```sh
# 先打包前端
pnpm build
# 打包linux amd64版本
docker build --platform linux/amd64 -t registry.cn-hangzhou.aliyuncs.com/hao_default/amis-admin:amd64 .
```

### 推送

```sh
docker push registry.cn-hangzhou.aliyuncs.com/hao_default/amis-admin:amd64
```

### 服务器部署

复制项目里的`docker-compose.yml`文件到部署目录，执行

```sh
mkdir -p amis-admin/{html,backend,oidc}
```

接着创建`oidc`服务的配置

```sh
# amis-admin/oidc/config.yaml
mysql:
  host: "localhost"
  port: 3306
  user: "root"
  password: "123456"
  dbname: "oidc"
  max_open_conns: 200
  max_idle_conns: 50
```

接下来创建`fireboom`环境变量配置文件

```sh
# amis-admin/backend/.env
# 从backend/.env里复制，只需要改DB_ADMIN变量
...
DB_ADMIN=DB_ADMIN="mysql://root:123456@172.17.0.1:3306/oidc"
```

然后启动服务

```sh
docker compose up -d
```

~~目前遇到问题是挂载后`html`里的文件权限是`root`，可以使用命令`chown -R nginx:nginx amis-admin/html/`修改为`nginx`可读~~
