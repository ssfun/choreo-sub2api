# Sub2API Dockerfile for Choreo

# Version

v0.1.131

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- 用户平台配额：支持为用户在 anthropic/openai/gemini/antigravity 四个平台分别设置日/周/月 USD 配额，未设置=不限制、0=禁用、>0=美元上限
- 配额默认值配置：系统默认 + email/linuxdo/oidc/wechat/github/google/dingtalk 七种鉴权来源各自的默认配额，可在管理端设置页统一编辑
- 用户端配额展示：用户 Dashboard 显示各平台已用/剩余配额
- 内容审计风险阈值：内容审计支持自定义风险阈值配置

- HTTP/2 上游传输：完善 OpenAI 上游 HTTP/2 配置项，新增响应头超时及相关连接参数控制
- 流错误处理：/v1/responses、/responses、/backend-api/codex/responses 等 6 个路由统一识别并按 Responses 协议下发 response.failed 终止事件
- response.failed SSE writer 改用 json.Marshal 输出，避免 strconv.Quote 产生非法 JSON 转义

- 修复 OpenAI HTTP/2 上游响应头超时无法配置、长响应被中断的问题
- 修复 /v1/responses 流式场景下并发等待超时只发 event: error 导致 Codex CLI 报 "stream closed before response.completed" 的问题
- 修复 SSE 已写入心跳后再发生上游错误（http2 超时、stream INTERNAL_ERROR 等）时静默 EOF 的问题
- 修复 handleStreamingAwareError 仅匹配 /v1/responses、漏掉裸 /responses 与 /backend-api/codex/responses 的问题
- 修复 WebSocket 续接时未识别 Codex 工具输出的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.131

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.131
```

**One-line install (Linux):**
```bash
curl -sSL https://raw.githubusercontent.com/Wei-Shaw/sub2api/main/deploy/install.sh | sudo bash
```

**Manual download:**
Download the appropriate archive for your platform from the assets below.

## 📚 Documentation

- [GitHub Repository](https://github.com/Wei-Shaw/sub2api)
- [Installation Guide](https://github.com/Wei-Shaw/sub2api/blob/main/deploy/README.md)

