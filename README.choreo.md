# Sub2API - Choreo 部署版本

这是 Sub2API 的 Choreo 平台适配版本。目标是在 Choreo 的限制下尽量少改上游镜像：

- Sub2API 运行在 `8080`，作为 REST 页面和 API 入口
- Caddy 运行在 `8081`，把 WebSocket 请求反向代理到 Sub2API
- PostgreSQL 使用外部数据库
- Redis 内置在同一个容器内，仅绑定 `127.0.0.1`
- 可选启动内置 Komari agent 做运行状态监控
- 运行时可写数据全部放到 `/tmp`
- Cloudflare Worker 处理 Choreo Public URL 路径前缀和 WebSocket 分流

## 主要特性

- 支持 Choreo 只读文件系统：`DATA_DIR=/tmp/sub2api`
- 支持 Sub2API 自动初始化：`AUTO_SETUP=true`
- 外部 PostgreSQL，容器内不启动 PostgreSQL
- 内置 Redis，无需额外 Redis 服务
- REST 与 WebSocket 拆分到不同端口，符合 Choreo endpoint 限制
- Caddy 使用 `/tmp/caddy-*` 作为可写配置/数据目录
- Pricing 缓存写入 `/tmp/sub2api/pricing`
- Cloudflare Worker 统一自定义域名入口
- 可选 Komari agent：设置 `KOMARI_SERVER` 和 `KOMARI_SECRET` 后自动启动

## 当前架构

```text
浏览器 HTTP
  -> Cloudflare Worker
  -> Choreo REST endpoint :8080
  -> Sub2API :8080

浏览器 WebSocket
  -> Cloudflare Worker
  -> Choreo WS endpoint :8081
  -> Caddy :8081
  -> Sub2API :8080

Sub2API
  -> 外部 PostgreSQL
  -> 内置 Redis 127.0.0.1:6379
```

Choreo endpoint 配置见 `.choreo/component.yaml`：

```yaml
endpoints:
  - name: sub2api
    service:
      port: 8080
    type: REST
    networkVisibilities:
      - Public

  - name: sub2api_ws
    service:
      port: 8081
    type: WS
    networkVisibilities:
      - Public
```

> Choreo 不支持同一个 Public endpoint 同时承载 REST 和 WebSocket。Sub2API 自身虽然在 `8080` 提供 HTTP 和 WebSocket 路由，但在 Choreo 上必须拆分为两个 endpoint。

## 文件结构

```text
sub2api-argo/
├── Dockerfile                    # Choreo 专用 Dockerfile
├── entrypoint.sh                 # 容器启动脚本，启动 Redis/Caddy/Sub2API
├── Caddyfile                     # WebSocket endpoint 反向代理配置
├── worker/
│   └── cloudflare-worker.js      # Cloudflare Worker 代理脚本
├── .choreo/
│   └── component.yaml            # Choreo endpoint 配置
└── README.choreo.md              # 本文档
```

## 部署到 Choreo

### 1. 创建 Service Component

在 Choreo Console 创建 Service Component，并连接本仓库。

构建配置：

```text
Build Preset: Docker
Dockerfile Path: Dockerfile
Component Directory: /
```

### 2. 配置 endpoint

仓库已包含 `.choreo/component.yaml`。需要保留两个 Public endpoint：

| endpoint | 端口 | 类型 | 用途 |
|---|---:|---|---|
| `sub2api` | `8080` | `REST` | Sub2API 页面、REST API、健康检查 |
| `sub2api_ws` | `8081` | `WS` | WebSocket 请求，经 Caddy 转发到 `8080` |

不要把 WebSocket 和 REST 合并到同一个 Choreo endpoint。

### 3. 配置环境变量

最小推荐配置：

```bash
DATABASE_HOST=your-postgres-direct-host
DATABASE_PORT=5432
DATABASE_USER=sub2api
DATABASE_PASSWORD=your-password
DATABASE_DBNAME=sub2api
DATABASE_SSLMODE=require

ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=change-me
JWT_SECRET=change-me-to-a-long-random-secret
TOTP_ENCRYPTION_KEY=change-me-to-a-32-byte-secret
```

推荐补充连接池配置：

```bash
DATABASE_MAX_OPEN_CONNS=5
DATABASE_MAX_IDLE_CONNS=2
DATABASE_CONN_MAX_LIFETIME_MINUTES=10
DATABASE_CONN_MAX_IDLE_TIME_MINUTES=2
```

> 重要：`DATABASE_HOST` 应使用 PostgreSQL direct/session endpoint，不要使用 transaction pooler / PgBouncer transaction mode / pooled endpoint。否则可能出现 `pq: unnamed prepared statement does not exist`、参数错位、随机 500 等错误。

### 4. 部署

1. 在 Choreo 点击 **Build Latest**
2. 构建成功后部署到 Development 或 Production 环境
3. 记录 Choreo 生成的 REST Public URL，例如：

```text
https://xxxx-dev.e1-us-east-azure.choreoapis.dev/default/sub2api/v1.0
```

4. 记录 WebSocket endpoint 的 Public URL，例如：

```text
https://xxxx-dev.e1-us-east-azure.choreoapis.dev/default/sub2api/sub2api_ws/v1.0
```

### 5. 部署 Cloudflare Worker

Choreo Public URL 会强制带路径前缀，例如 `/default/sub2api/v1.0`。Sub2API 前端期望从 `/` 提供页面和 API，因此建议用 Cloudflare Worker 绑定自定义域名。

使用仓库里的 `worker/cloudflare-worker.js`，修改顶部配置：

```js
const CHOREO_HOST = "xxxx-dev.e1-us-east-azure.choreoapis.dev";
const REST_PATH_PREFIX = "/default/sub2api/v1.0";
const WS_PATH_PREFIX = "/default/sub2api/sub2api_ws/v1.0";
```

然后在 Cloudflare Worker 绑定自定义域名，例如：

```text
https://sub2api.example.com
```

浏览器访问和 API 调用都建议使用这个自定义域名。

## 环境变量说明

### Sub2API 基础变量

| 变量 | 默认值 | 说明 |
|---|---|---|
| `AUTO_SETUP` | `true` | 自动初始化 Sub2API |
| `SERVER_HOST` | `0.0.0.0` | Sub2API 监听地址 |
| `SERVER_PORT` | `8080` | Sub2API 监听端口 |
| `SERVER_MODE` | `release` | Gin 运行模式 |
| `DATA_DIR` | `/tmp/sub2api` | 配置、安装锁等运行时数据目录 |
| `PRICING_DATA_DIR` | `/tmp/sub2api/pricing` | 模型价格缓存目录 |
| `LOG_OUTPUT_TO_STDOUT` | `true` | 日志输出到 stdout |
| `LOG_OUTPUT_TO_FILE` | `false` | 禁止写日志文件，适配只读文件系统 |

### PostgreSQL 变量

| 变量 | 默认值 | 说明 |
|---|---|---|
| `DATABASE_HOST` | 无 | 必填，PostgreSQL direct/session host |
| `DATABASE_PORT` | `5432` | PostgreSQL 端口 |
| `DATABASE_USER` | 无 | 必填，数据库用户 |
| `DATABASE_PASSWORD` | 无 | 必填，数据库密码 |
| `DATABASE_DBNAME` | 无 | 必填，数据库名 |
| `DATABASE_SSLMODE` | `require` | Choreo 外部数据库通常建议 `require` |
| `DATABASE_MAX_OPEN_CONNS` | 上游默认值 | 建议在外部云数据库上设小一些 |
| `DATABASE_MAX_IDLE_CONNS` | 上游默认值 | 建议在外部云数据库上设小一些 |
| `DATABASE_CONN_MAX_LIFETIME_MINUTES` | 上游默认值 | 连接最大存活时间 |
| `DATABASE_CONN_MAX_IDLE_TIME_MINUTES` | 上游默认值 | 空闲连接最大存活时间 |

### 内置 Redis 变量

| 变量 | 默认值 | 说明 |
|---|---|---|
| `REDIS_PORT` | `6379` | 内置 Redis 监听端口，仅绑定 `127.0.0.1` |
| `REDIS_PASSWORD` | 空 | 可选，内置 Redis 密码 |
| `REDIS_DB` | `0` | Redis DB |
| `REDIS_ENABLE_TLS` | `false` | 固定为 false，容器内本地连接 |

`entrypoint.sh` 会在 Redis 就绪后强制导出：

```bash
REDIS_HOST=127.0.0.1
REDIS_PORT=$LOCAL_REDIS_PORT
```

这样可以避免 Choreo 环境变量误把 Sub2API 指向外部 Redis。

### Caddy 可写目录变量

| 变量 | 默认值 | 说明 |
|---|---|---|
| `HOME` | `/tmp` | 避免 Caddy 写 `/home/choreo` |
| `XDG_CONFIG_HOME` | `/tmp/caddy-config` | Caddy 配置目录 |
| `XDG_DATA_HOME` | `/tmp/caddy-data` | Caddy 数据目录 |

### Komari agent 变量

| 变量 | 默认值 | 说明 |
|---|---|---|
| `KOMARI_SERVER` | 空 | Komari server 地址，留空则不启动 agent |
| `KOMARI_SECRET` | 空 | Komari agent secret，留空则不启动 agent |

只有两个变量都非空时，`entrypoint.sh` 才会启动 `/app/komari-agent`。

## Cloudflare Worker 行为

`worker/cloudflare-worker.js` 做三件事：

1. 普通 HTTP 请求转发到 REST endpoint：

```text
/anything -> /default/sub2api/v1.0/anything
```

2. WebSocket Upgrade 请求转发到 WS endpoint：

```text
/responses -> /default/sub2api/sub2api_ws/v1.0/responses
```

3. HTML 请求删除缓存校验头：

```js
headers.delete("If-None-Match");
headers.delete("If-Modified-Since");
```

这是为了避免 Sub2API 的 CSP nonce 与浏览器缓存 HTML 不一致，导致前端出现 `Refused to execute a script because its hash, its nonce...`。

## 运行时数据路径

```text
/tmp/sub2api/
├── config.yaml
├── install.lock
└── pricing/
    ├── model_pricing.json
    └── model_pricing.sha256

/tmp/redis/
/tmp/caddy-config/
/tmp/caddy-data/
```

Choreo 容器重启或重新部署时 `/tmp` 可能丢失。Sub2API 的核心业务数据应保存在外部 PostgreSQL 中；`/tmp/sub2api` 主要用于配置文件、安装锁和价格缓存。

## 版本一致性说明

当前 Dockerfile 基于：

```dockerfile
FROM weishaw/sub2api:latest
```

如果前端访问某个新接口返回 404，而本地源码中已经有该路由，通常说明 `weishaw/sub2api:latest` 与本地源码版本不一致。

典型例子：

```text
/api/v1/admin/settings/web-search-emulation -> 404
```

如果需要完全消除版本错配，应改为从同一份 Sub2API 源码构建前端和后端，而不是直接使用远端 `latest` 镜像。

## 故障排查

### PostgreSQL 大量随机 500

如果日志中出现：

```text
pq: unnamed prepared statement does not exist
pq: bind message supplies X parameters, but prepared statement "" requires Y
invalid input syntax for type timestamp with time zone
```

优先检查 `DATABASE_HOST` 是否用了 transaction pooler / PgBouncer pooled endpoint。

处理：

- 改用 PostgreSQL direct endpoint 或 session pooler endpoint
- 不要使用 transaction pooler endpoint
- 适当降低连接池参数

推荐：

```bash
DATABASE_MAX_OPEN_CONNS=5
DATABASE_MAX_IDLE_CONNS=2
DATABASE_CONN_MAX_LIFETIME_MINUTES=10
DATABASE_CONN_MAX_IDLE_TIME_MINUTES=2
```

### 页面 404

通常是 Cloudflare Worker 的 Choreo 路径前缀不正确。确认：

```js
const REST_PATH_PREFIX = "/default/sub2api/v1.0";
```

与 Choreo REST Public URL 的路径一致。

### WebSocket 连接失败

确认：

```js
const WS_PATH_PREFIX = "/default/sub2api/sub2api_ws/v1.0";
```

并确认 `.choreo/component.yaml` 中 `sub2api_ws` endpoint 是：

```yaml
type: WS
port: 8081
```

### CSP nonce 报错

如果浏览器控制台出现：

```text
Refused to execute a script because its hash, its nonce, or 'unsafe-inline'...
```

处理：

1. 重新部署最新 Worker
2. Cloudflare Purge Cache
3. 使用无痕窗口重新访问
4. 确认 Worker 中 HTML 请求会删除 `If-None-Match` 和 `If-Modified-Since`

如果只剩 `m-outer-*.html`、`m-inner*.html`，通常是浏览器扩展或翻译插件注入页面，不一定是 Sub2API 自身错误。

### Caddy 只读文件系统告警

如果日志中出现：

```text
mkdir /home/choreo/.local: read-only file system
mkdir /home/choreo/.config/caddy: read-only file system
```

确认镜像包含：

```bash
HOME=/tmp
XDG_CONFIG_HOME=/tmp/caddy-config
XDG_DATA_HOME=/tmp/caddy-data
```

### Pricing 文件写入失败

如果日志中出现：

```text
open data/model_pricing.json: read-only file system
```

确认镜像包含：

```bash
PRICING_DATA_DIR=/tmp/sub2api/pricing
```

并确认启动日志没有覆盖该环境变量。

## 本地静态检查

本地没有 Docker 时，可以至少做语法检查：

```bash
sh -n entrypoint.sh
node --check worker/cloudflare-worker.js
```

## 安全注意事项

- 不要把 PostgreSQL 密码、JWT secret、TOTP encryption key 写入仓库
- `ADMIN_PASSWORD`、`JWT_SECRET`、`TOTP_ENCRYPTION_KEY` 应在 Choreo 环境变量中配置
- Worker 中不要提交真实 Choreo host 到公开仓库，除非该仓库本身就是部署配置仓库
- PostgreSQL 必须开启 TLS 时，设置 `DATABASE_SSLMODE=require`
