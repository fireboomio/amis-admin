<div align="center">
  <h1>amis-admin</h1>
  <p>基于 Fireboom 的可视化中后台全栈开发框架</p>
  <a href="https://docs.fireboom.io/kuai-su-ru-men/kuai-su-shang-shou">Quickstart</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://www.fireboom.cloud/">Website</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://docs.fireboom.io">Docs</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://space.bilibili.com/3493080529373820">Bilibili</a>
  <br />
  <hr />
</div>

# amis-admin 介绍

市面上有很多管理后台，为什么还要做 **amis-admin** 呢？若不是其独一无二的特点，我们断然不会班门弄斧。

**amis-admin** 最大的特点是：**融合可视化 API 接口开发**和**可视化拖拽界面**，目标是快速开发中后台系统。

- TA 基于 [Fireboom](https://www.fireboom.cloud) 和 [百度 amis](https://github.com/baidu/amis) 构建，既可以快速构建 API，也可以拖拽生成页面，

- TA 适用于网站管理后台、CMS、CRM、OA 等中后台系统开发。当然，你也可以对TA深度定制。

- TA 是学习了解进而玩转 Fireboom 的最佳实践。

![AMIS-ADMIN界面截图](./docs/img/amis-admin预览.jpg)

[旧版文档](./README.old.md)

## 特性 Feature

- 内置适合管理后台使用的 OIDC 服务
- 常用的用户、角色、菜单、API管理和关联操作
- 快速的 API 构建，快速的页面拖拽生成

## 框架优势

**相对于传统后台管理框架**：**amis-admin** 不仅能可视化构建后台接口，同时还能可视化拖拽构建界面。对于中后台场景的增删改查业务，不需要编写一行代码。

**相对于拖拽构建界面的低代码**：**amis-admin** 不仅能可视化开发 API ，且能用任意后端语言编写钩子（NodeJS、Golang等），实现任意复杂的业务逻辑。此外，对于 amis 无法完成的复杂页面交互，TA 还支持前端 PRO CODE 开发。

> 该项目基于 golang 钩子实现，希望社区能贡献其他语言的实现~

此外， **amis-admin** 具备 Fireboom 的所有优势：

- OIDC身份验证和RBAC角色鉴权，能够实现复杂的权限控制，包括数据权限和接口权限。
- 内置类似 **navicate** 的数据库管理界面，可以进行数据库级别的**数据管理**和**数据建模**。

# 技术栈

## 必备技能

**后端**

- [Fireboom 可视化 API 开发工具](https://www.fireboom.cloud) >2.0
- 钩子 Golang > 1.20（待实现其他语言，如 NodeJS ）
- Mysql 数据库

**前端**

前端项目采用:

- node > 18
- pnpm > 8
- React
- `Ant Design` + `Ant Pro components`
- `amis`
- `Vite`

主要功能：登录、退出、用户名头像修改、密码重置以及权限管理。

- 简单业务需求，在前端通过 `amis-studio` 开发，并配置路由即可访问
- 复杂业务需求，自行编写代码实现

## Fireboom

**Fireboom** 是一个可视化的WEB API开发平台，前后端开发者都能使用。

![FIREBOOM 快速操作](https://camo.githubusercontent.com/404bbcf5eae02b87d4f30a28b8ba114f833c296736930891b7a88d7cb3ee2a23/68747470733a2f2f7777772e66697265626f6f6d2e636c6f75642f5f6e6578742f696d6167653f75726c3d2532465f6e6578742532467374617469632532466d6564696125324676697375616c697a6174696f6e2e32623331353730662e67696626773d37353026713d3735)

使用它即可以快速开发增删改查接口，也可以编写钩子代码完成复杂业务逻辑，进而缩减项目交付时间，让后端开发者从重复工作中解放出来，专注于更有价值的业务逻辑。同时，前端开发者也能快速上手，变身全栈开发。

Fireboom官网：[https://www.fireboom.cloud](https://www.fireboom.cloud)

## 百度 amis

**amis** 是一个低代码前端框架，它使用 **JSON** 配置来生成页面，可以减少页面开发工作量，提升页面开发效率。非常适合管理后台这样的固定的、一致的、重复的场景。

AMIS 官网：[https://baidu.github.io/amis](https://baidu.github.io/amis)

## YuDai oidc 服务

**YuDai OIDC** 是 Fireboom 团队另一个精简版开源 OIDC 项目，它提供了基础的 OIDC 功能，包括：用户名密码登录、手机号+验证码登录、微信登录等功能。

**YuDai OIDC**在本项目中作为 Fireboom 的 [REST API](https://docs.fireboom.io/ji-chu-ke-shi-hua-kai-fa/shu-ju-yuan/rest-api) 数据源，经过 Fireboom 代理后，暴露给前端。但，如果你想直接暴露该服务也是可行的，但 nginx 要额外配置。

> [!NOTE]  
> 该服务的数据库即可以和业务数据库放在一起，也可以分开。对中后台项目应尽量降低复杂性，推荐放在一起，方便数据互通。

仓库地址：[https://github.com/fireboomio/yudai-oidc](https://github.com/fireboomio/yudai-oidc)

# 开发

## 数据库初始化

### 表结构介绍

数据库表结构：[./scripts/db.prisma](./scripts/db.prisma)

其中含义如下：

_管理后台表_

- admin_log：日志表
- admin_menu：菜单表
- admin_menu_role：菜单-角色关联表
- admin_role：角色表
- admin_role_user：角色-用户关联表

_示例数据表_

- demo_area
- demo_area_role
- demo_post
- demo_post_category

_OIDC表(详情见下文)_

- provider：短信配置表，当前仅支持阿里云短信，若想正常发短信，需要去修改里面的 appid和appscret
- token：颁发的令牌表
- user：用户主表
- usersocial：社交登录表
- ~userwx：微信登录表，后续要优化~
- verificationrecord：验证码记录

### 初始化 mysql容器

执行下述脚本：

```sh
cd scripts
# 1. 启动 mysql 容器
# 2. 在容器中执行 ./scripts/init2.0.sql
sh start-mysql.sh
```

当看到如下输出时，说明 `oidc` 库创建成功了

```
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                                  NAMES
7f2b48baea21   mysql     "docker-entrypoint.s…"   6 seconds ago   Up 5 seconds   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql2
Successfully copied 37.9kB to mysql2:/init.sql
...
# 中间会有一个等待容器启动的过程，直到容器启动成功，才会初始化数据
...
localhost       root    caching_sha2_password   $A$005$15+L:m(QzSs>IYG"rBdkFInN5uP3gQkSEWDqAvzlEdf/sRyIAoae6dDZ3U.y9.
...
oidc
...
```

数据库连接：`mysql://root:123456@127.0.0.1:3306/oidc`

### 启动项目

#### 一键启动

1. 启动后端

```sh
pnpm fb --update
```

2. 启动前端

新开一个窗口执行

```sh
# 1. 安装前端依赖
pnpm i
# 2. 开发模式启动
pnpm dev
```

然后访问： [http://localhost:8080](http://localhost:8080)

超级管理员账户密码：admin/password

可在文件：`backend/.env`，中指定超级管理员的角色码

```env
SUPER_ROLE_CODE="admin"
```

指定后，所有拥有角色 `SUPER_ROLE_CODE` 的用户均为超级管理员。

#### 手工启动

**1. 启动 Firebooom**

```sh
cd backend
./fireboom dev
```

**2. 启动钩子服务**

```sh
cd custom-go
go mod tidy
go run main.go
```

**3. 启动 yudai OIDC 服务**

```sh
cd oidc
./oidc
```

**4. 启动前端**

```sh
# 1. 安装前端依赖
pnpm i
# 2. 开发模式启动
pnpm dev
```

### 服务介绍

通过上面的命令启动后总共会启动**4**个服务，分别是

- Fireboom 服务，目录在`backend`
- Golang 钩子服务，目录在`backend/custom-go`
- YuDai oidc 服务，目录在`oidc`
- 基于 Ant Pro 的管理后台前端页面，根目录 `/`

## Docker 打包部署

原有的 All in one 镜像打包模式不再推荐，推荐使用 Kubernetes 部署模式，该模式将 Fireboom、钩子服务打包成不同的镜像但部署在同一个POD中，通过共享 Volume 实现数据共享，通过共享网络实现服务访问。

### 构建

- 前端镜像

```sh
docker build --platform linux/amd64 -t fireboomapi/amis-admin_front:latest -f Dockerfile .
```

- Fireboom 数据镜像

```sh
docker build --platform linux/amd64 -t fireboomapi/amis-admin_fb-data:latest -f backend/fb-data.Dockerfile ./backend
```

- Fireboom golang 钩子镜像，第一次需要打包，后续更新依赖时才需要重新打包

```sh
docker build --platform linux/amd64 -t fireboomapi/amis-admin_fb-hook:latest -f backend/fb-hook.Dockerfile ./backend
```

### 推送

```sh
docker push fireboomapi/amis-admin_front:latest
docker push fireboomapi/amis-admin_fb-data:latest
docker push fireboomapi/amis-admin_fb-hook:latest
```

<strike>
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

1. 复制文件 `docker-compose.yml` 到部署目录

2. 执行下述脚本：

```sh
mkdir -p {backend_store,oidc}
```

3. 接着，创建 `oidc` 服务的配置

```sh
# oidc/config.yaml
mysql:
  host: "localhost"
  port: 3306
  user: "root"
  password: "123456"
  dbname: "oidc"
  max_open_conns: 200
  max_idle_conns: 50
```

4. 接下来创建 `fireboom` 环境变量配置文件

```sh
# backend_store/.env
# 从代码的 backend/.env 文件里复制，只需要改 DB_ADMIN 变量
...
DB_ADMIN=DB_ADMIN="mysql://root:123456@172.17.0.1:3306/oidc"
```

5. 然后启动服务

```sh
docker compose up -d
```

~~目前遇到问题是挂载后`html`里的文件权限是`root`，可以使用命令`chown -R nginx:nginx **amis-admin**/html/`修改为`nginx`可读~~
</strike>

## 小技巧

本项目，Fireboom 启动后会分别生成 Golang 钩子依赖的文件：`backend/custom-go/generated` 和 前端依赖的文件：`src/api`。

但，如果前后端在不同服务器上，修改接口后文件 `src/api` 会更新，需要将文件下载到前端所在服务器中。

注意：文件 `src/api/client.ts` 中的请求地址，由 fireboom 中 [设置]->[系统]-><API外网地址> 决定，要根据实际情况修改。

```ts
export const defaultClientConfig: ClientConfig = {
  applicationHash: 'd41d8cd9',
  baseURL: 'http://localhost:9991', // 默认值
  sdkVersion: ''
}
```

下述指令可以自动该过程：

```sh
rsync -av --exclude "index.ts" [server]:[source-path] [dist-path]
```

- [server] : 服务器SSH，例如 root@192.168.1.77
- [source-path] :服务器上的目录，例如 `/root/amis-admin/generated-sdk/`
- [dist-path] ： 本机上的目录，例如 `src/api/`

# 参考

- Fireboom 官网：https://www.fireboom.cloud
- AMIS 官网：[https://baidu.github.io/amis](https://baidu.github.io/amis)
