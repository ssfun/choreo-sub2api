# Sub2API Dockerfile for Choreo

# Version

v0.1.120

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- OpenAI Fast/Flex Policy：支持 HTTP、WebSocket 和管理后台配置
- Vertex Service Account：支持通过服务账号方式接入 Google Vertex AI
- 账号批量编辑：支持按筛选条件批量更新账号设置（含 compact 配置）
- 运维清理支持 retention_days=0：允许每次调度清理时清空表数据
- 请求体压缩解码：支持 zstd/gzip/deflate 压缩请求体自动解码
- Vertex 用量窗口展示当日统计

- API Key 速率限制重置时同步清除用量缓存
- 解压缩增加 bomb guard 防护，防止恶意超大解压
- 调度器 SetSnapshot 竞态条件修复，移除前端用量节流逻辑

- 修复 OpenAI 图片请求未正确使用版本化 base URL 的问题
- 修复 OpenAI 图片请求产生隐式粘性会话的问题
- 修复 OpenAI /v1/responses 输入中残留 reasoning items 的问题
- 修复 OpenAI passthrough 字段未正确清理的问题
- 修复 OpenAI Codex compact payload 字段被意外丢弃的问题
- 修复 OpenAI WebSocket 在显式工具重放时错误推断 continuation 的问题
- 修复 Responses function tool_choice 格式不兼容的问题
- 修复 Anthropic responses-to-anthropic 转换中空 Read.pages 未清理的问题
- 修复网关流式错误泄露基础设施拓扑信息的安全问题
- 修复 Anthropic 流式 EOF 未正确封装为 failover 错误的问题
- 修复 Anthropic SSE 错误事件格式不符合标准的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.120

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.120
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
