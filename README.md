# Sub2API Dockerfile for Choreo

# Version

v0.1.137

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增 OpenAI 账号重置次数查询/触发重置、cyber_policy 硬阻断全链路透传。

## 新增功能

- OpenAI 账号重置次数：admin 端查询剩余重置次数、触发 rate-limit credit 消费
- OpenAI cyber_policy：硬阻断响应全链路原样透传，异步审计/计费/会话拦截
- Claude OAuth：可配置 system prompt blocks 注入
- 国产 LLM 兜底定价：GLM 13 款、Kimi K 系列 4 款、MiniMax M 系列 6 款、DeepSeek V4 Pro/Flash
- doubao-embedding-vision：按文本/图片 token 差别计费
- 国产模型 thinking-enabled 时自动填充 reasoning_effort 默认值
- 渠道监控：检测间隔支持 ± 随机抖动配置
- 账号列表显示账号 ID 字段

## 优化改进

- 协议感知的 thinking-block 过滤（DeepSeek/Kimi/GLM 等保留 passback，Claude 保持 strict 语义）
- MiniMax M 系列自动将 thinking.type=enabled 改写为 adaptive
- DeepSeek reasoning_effort 'max' 归一化为 'xhigh'
- OpenAI /responses 能力探测增加工具调用校验，避免误判
- token refresh 重试退避优化，降低放大效应
- 用户等待队列计费移出热路径
- scheduler outbox 去重一致性：payload-aware dedup_key，已消费行清理，dedup 索引修复
- ACL 拒绝消息包含客户端 IP
- 账号列表查询参数限制修复

## Bug 修复

- 网关：SSE event:error body 保留，ops 日志反映真实上游错误
- 网关：非 JSON 2xx 响应触发 failover
- 网关：解压 zstd 上游响应体
- 网关：streaming 请求也拦截 max_tokens=1 haiku 探测
- 网关：responses 会话哈希锚定到 input 字段
- OpenAI：图片接口服务器错误触发 failover；失败时复用 error body
- Anthropic：保留 window 冷却窗口
- API 兼容：默认 tool.strict 为 false
- Antigravity：合并 system role 消息
- Token 刷新：invalid_refresh_token / app_session_terminated 判定为不可重试
- 数据库：account expiry autopause 索引、refresh candidates SQL 健康账号被排除
- Docker：构建上下文包含 docs/legal（admin-compliance 门）
- 前端依赖：form-data 升级至 ≥4.0.6（GHSA-hmw2-7cc7-3qxx）
- OAuth 注册自动应用 promo codes



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.137

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.137
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

