# Sub2API Dockerfile for Choreo

# Version

v0.1.121

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- Anthropic 缓存 TTL 注入：新增管理端开关，支持控制网关请求中的缓存 TTL 注入行为。


- 粘性会话调度：改进调度缓存和请求处理逻辑，降低会话路由异常风险。
- OpenAI 转发：修复 item references 场景下 previous response 推断问题。
- 表格分页：恢复分页大小的 localStorage 持久化，切换分页大小后可保留用户偏好。



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.121

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.121
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
