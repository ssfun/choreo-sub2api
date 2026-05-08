# Sub2API Dockerfile for Choreo

# Version

v0.1.125

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- 登录注册条款确认：登录和注册流程支持展示并确认服务条款与隐私协议
- 法律文档页面：新增公开法律文档页面，并支持后台配置相关内容

- 账号模型白名单：更新内容审核和前端模型白名单配置
- 风险控制界面：优化 Moderation Key 相关交互和中英文文案
- CI 稳定性：修复 API 契约测试和设置服务相关 lint/test 问题

- 修复 Moderation Key 处理逻辑和密钥界面问题
- 修复网关默认注入 redact-thinking beta 参数的问题

无需额外操作。



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.125

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.125
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

