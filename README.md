# Sub2API Dockerfile for Choreo

# Version

v0.1.156

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- OpenAI 账号支持 Codex Agent Identity 认证，前端标明认证模式
- 账号管理新增安全的一键复制功能
- /keys 与 /admin/groups 列表新增可选 ID 列
- Server-Timing 指标扩展至已认证用户 Web API
- OpenAI WebSocket 首消息超时支持配置

- force-chat 账号直接桥接 Anthropic↔ChatCompletions，跳过 Responses 中间层
- 优化内容审核关键词匹配热路径性能
- 完善调度器缓存桶生命周期管理，复用重建批次内的账号查询
- 优化 Responses 流式事件边界刷新与图片生成意图判定
- 优化 Ops 队列深度账号查询与内容会话种子字段扫描
- 失败切换与 WebSocket 失败日志中记录代理主机，便于排查
- 统一 Grok 使用模板中的名称风格

- 修复客户端断开后 failover 静默终止、误报 502 账号耗尽的问题
- 修复 OpenAI API-key 透传遇 5xx 不触发 failover 的问题，并对透传上游错误脱敏
- 修复 OpenAI 原生 Responses 首输出无限等待的问题
- 修复并行 tool_use 产生幽灵 content_block_delta（index 错误）的问题
- 修复拼接 Responses 流事件解析、不完整流终结丢失、Read 工具参数流清洗等协议兼容问题
- 修复 Grok OAuth 凭证错误安全 failover、OAuth 池主动刷新与通用管理刷新路由问题
- 修复 Grok 视觉模型 image_url 内容桥接，并拦截图片模型误发 Responses 端点
- 修复 Grok Free Messages function tools 缓存失效问题
- 修复 GPT-5.6 长上下文账号成本统计错误
- 修复图片生成 JSON 完成边界与 OAuth 输出图片尺寸上报问题
- 修复 Responses Lite 工具声明兼容性，保留 Codex 图片 function tools
- 修复 Codex 根路径 models 兼容别名缺失问题
- 修复前端 DataTable 行缓存过期与 legacy Codex 配置模式丢失问题
- 修复 antigravity 手动输入的 refresh token 被覆盖的问题
- 修复调度器 degraded outbox 重复重建问题
- 修复 xAI 不安全 base URL 组件校验
- 修复 Web 静态资源 immutable 缓存误用于非指纹资源的问题
- 修复 OpenAI 主动重置次数在异常详情下丢失的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.156

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.156
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

