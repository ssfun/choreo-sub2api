# Sub2API Dockerfile for Choreo

# Version

v0.1.165

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增 ChatGPT Live（Frameless 实时会话）网关支持，并完整适配 Anthropic 新模型 claude-opus-5。

## 新增功能

- ChatGPT Live 网关：新增 `/v1/live` 与 Codex `/backend-api/codex/realtime/calls` 实时会话转发，支持组级 Live 开关、并发租约控制与用量记录，用量筛选/导出新增 Live 请求类型
- 适配 Anthropic claude-opus-5：模型清单、Bedrock 默认映射、定价（$5/$25 per MTok、1M 上下文、128K 输出）、前端预设映射与限流 scope 全部登记
- Ollama Cloud 用量改为请求驱动刷新：空闲账号不再轮询，新增「请求安静等待」参数（默认 1 分钟），原刷新周期改为持续请求下的最长等待时间
- 用量记录持久化客户端会话标识 session_id，可用于跨请求关联同一会话
- 后台公告新增预览功能：发布前可直接查看公告弹窗的实际展示效果

## 优化改进

- 统一公告富文本样式，修复首页公告弹窗样式错乱
- 推广页复制按钮适配移动端窄屏布局
- 图像请求日志补充记录请求的 quality 与 size，便于定位失败原因

## Bug 修复

- 注册查重归一化邮箱别名（点号、+后缀、googlemail），防止单个收件箱批量注册；同时修复域名尾随点绕过、`+xxx@` 合法用户被永久误拒与并发注册竞态
- 修复 Ollama 用量刷新在 PostgreSQL 14/15/16 上到期判定失效导致部分账号永不刷新，并恢复 15 分钟抓取下限
- 修复 Live 会话租约续租失败后空转：现在直接终止会话并补写用量记录，避免占着上游连接却不计入并发限制
- 修复 Gemini chat completions 丢失图像输出
- 修复 Grok Responses 请求中只有 tool_choice 没有 tools 时被上游拒绝
- 修复 Grok 池模式账号遇上游 5xx 被临时停止调度
- 修复 OpenAI 池模式下已显式配置同账号重试的状态码仍被记为账号级冷却，导致重试预算提前耗尽
- 修复 API Key 账号的 Responses 请求缺少 item ID 净化
- 修复 HTTP 转发前 input 项残留 namespace 前缀
- 修复未配置远程定价 URL 时仍启动远程定价刷新调度器



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.165

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.165
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

