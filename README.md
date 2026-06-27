# Sub2API Dockerfile for Choreo

# Version

v0.1.139

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增 Grok 订阅、Codex 个人访问令牌（PAT）认证、GPT-5.5 Codex 指令支持，并加固 codex_cli_only 引擎指纹检测；同时修复多项支付、计费与网关稳定性问题。

## 新增功能

- Grok 订阅支持：完整的 OAuth、调度、配额探测与公开路由能力
- Codex 个人访问令牌（PAT）上游认证
- codex_cli_only 检测加固：统一引擎指纹信号列表，支持账号级 app-server
- GPT-5.5 Codex 指令支持，作为最新版本回退
- sub2api-admin CLI 支持 SUB2API_JWT 认证回退
- Admin 账号管理：重置 OpenAI 周限额前增加确认

## 优化改进

- Admin 用量统计：补充缓存创建/读取的 token 拆分

## Bug 修复

- 网关：无可用账号支持模型时返回 404 model_not_found 而非 503
- 网关：在 /v1/chat/completions 强制 codex_cli_only 限制
- OpenAI：检测 overloaded 错误码并在 chat 传输错误时执行 failover
- OpenAI：去重透传中重复的 function call 参数，避免 tool_call 参数翻倍
- OpenAI：净化冗长的 response failed 事件
- OpenAI 镜像：剥离 codex spark 的 image_generation 工具，修复 502
- API 兼容：规范化 custom 工具 schema
- API 兼容：避免 chat bridge 默认下发 codex 指令
- Antigravity：standard 级别下增加 project 回退
- Token 刷新：refresh_token_invalidated 视为不可重试
- 计费：防止余额计费持续透支
- 支付：订阅订单应用充值汇率换算
- 支付：支持复数形式的订阅有效期单位
- 支付：后端返回空 supported_types 时支付提供商卡片不再消失
- 订单：金额币种符号正确读取 currency 字段
- 图片：内容审核拒绝直接透传为 400，不再重试
- 认证：邮箱身份创建错误不再因 err 被遮蔽而静默
- 密钥：Claude Code 终端模板增加 CLAUDE_CODE_ATTRIBUTION_HEADER=0
- Ops：监控趋势卡片不再无限增高



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.139

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.139
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

