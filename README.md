# Sub2API Dockerfile for Choreo

这是面向 Choreo 平台的 [Wei-Shaw/sub2api](https://github.com/Wei-Shaw/sub2api) 适配仓库。

## Version

v0.0.0

## 适配内容

- 基于 `weishaw/sub2api:latest` 运行 Sub2API
- 使用外部 PostgreSQL
- 容器内置 Redis，并绑定 `127.0.0.1`
- REST endpoint 使用 `8080`
- WebSocket endpoint 使用 `8081`，由 Caddy 反向代理到 Sub2API `8080`
- Choreo 只读文件系统下，运行时写入目录统一放到 `/tmp`
- 可选内置 Komari agent，通过 `KOMARI_SERVER` 和 `KOMARI_SECRET` 启用
- 提供 Cloudflare Worker，用于处理 Choreo Public URL 路径前缀和 REST/WS 分流

## 快速开始

Choreo 部署说明见：

```text
README.choreo.md
```

核心文件：

```text
Dockerfile
entrypoint.sh
Caddyfile
.choreo/component.yaml
worker/cloudflare-worker.js
```

Choreo 构建配置：

```text
Build Preset: Docker
Dockerfile Path: Dockerfile
Component Directory: /
```

## 最小环境变量

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

推荐使用 PostgreSQL direct/session endpoint，不要使用 transaction pooler / PgBouncer transaction mode。

## Cloudflare Worker

部署后修改 `worker/cloudflare-worker.js` 顶部配置：

```js
const CHOREO_HOST = "xxxx-dev.e1-us-east-azure.choreoapis.dev";
const REST_PATH_PREFIX = "/default/sub2api/v1.0";
const WS_PATH_PREFIX = "/default/sub2api/sub2api_ws/v1.0";
```

然后将 Worker 绑定到自定义域名。

## Komari agent

可选启用：

```bash
KOMARI_SERVER=https://komari.example.com
KOMARI_SECRET=your-komari-secret
```

两个变量都非空时，容器启动脚本会自动启动 `/app/komari-agent`。

## Releases

当前占位版本为 `v0.0.0`。`.github/workflows/update-version.yml` 会定时检查 `Wei-Shaw/sub2api` 的 latest release，并更新本节。
