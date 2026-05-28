# Sub2API Dockerfile for Choreo

# Version

v0.1.132

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增分组自定义 `/v1/models` 模型列表和账号池模式可配置同账号重试状态码，并修复长上下文缓存计费、OpenAI WS 限额切换、账号重新授权等问题。

## 新增功能

- 分组模型列表：支持为分组自定义 `/v1/models` 返回的模型列表，并补充管理端配置入口
- 账号池重试状态码：支持为账号池模式配置同账号重试的上游 HTTP 状态码
- 运维指标：新增本地业务限制原因，用于区分平台策略限制和上游异常
- 账号管理：账号列表新增创建时间列

## 优化改进

- OpenAI 使用密钥：更新 OpenAI 使用密钥配置展示
- CI：重新触发因 GitHub Actions codeload 临时故障失败的流程

## Bug 修复

- API Key Responses：修复 API Key 响应在特定场景下回退读取 SSE body 的问题
- 计费：修复长上下文场景下 cache_read 和 cache_creation 价格未应用倍率的问题
- Antigravity：修复流式透传时未记录 message_start 中 input_tokens 的问题
- OpenAI：修复 Chat Responses usage 计费信息未保留的问题
- 调度器：修复模型 404 时错误冷却整个账号的问题，改为仅冷却账号-模型组合
- OpenAI WS：修复遇到限额时未自动切换账号的问题
- 账号重新授权：修复重新授权会清空 Extra 配置并可能继续使用旧 token 的问题
- Ops SLA：修复本地策略限制被计入错误统计的问题
- Bedrock：修复 beta token 被移除时未同步剥离 context_management 字段的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.132

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.132
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

