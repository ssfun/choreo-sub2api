# Sub2API Dockerfile for Choreo

# Version

v0.2.7

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增火山方舟 Seedance 原生视频任务 API，并为本地插件系统引入通用宿主服务与只读状态通道。

## 新增功能

- Seedance (Ark) 原生视频 API：支持火山方舟异步视频任务协议（创建/查询/删除），按上游 usage 计费，响应保持原生格式
- 插件宿主服务：为本地插件提供按插件命名空间的 KV 存储、账号目录（受插件已声明能力范围限制）等通用能力
- 插件只读状态通道：新增 /admin/plugins/:id/status 与 plugin.status UI 通道，可无需二次验证轮询插件实时状态

## 优化改进

- 手机竖屏顶栏保留模型广场图标入口

## Bug 修复

- 修复 Antigravity Gemini 裸模型名（配合 thinkingConfig）被直发上游导致 404 的问题
- 修复 Antigravity Gemini 原生流对 go-genai / python-genai 客户端发送 SSE 注释心跳导致流中断的问题
- 修复 Kimi 国内 Coding Plan 账号配额耗尽（403）被误判为永久禁用的问题，改为按窗口重置时间限时暂停
- 修复 Codex 内置工具根级联合 schema（oneOf/anyOf/allOf）导致 /v1/responses → /v1/messages 返回 400 的问题
- 修复 DeepSeek 思考模式在 Chat 回退时缺少 reasoning_content 导致 400 的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.2.7

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.2.7
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

