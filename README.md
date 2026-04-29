# Sub2API Dockerfile for Choreo

# Version

v0.1.119

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- 邀请返利系统完善：新增返利冻结期机制、返利有效期、单人返利上限
- 邀请返利功能开关：支持管理员全局开关邀请返利功能
- 专属邀请设置：支持管理员为指定用户设置专属邀请码和返利比例
- 补全 OAuth 注册路径（LinuxDo/OIDC/WeChat/Pending Flow）的邀请码绑定

- 修复 Zpay 退款接口调用问题
- 修正缓存 token 的 Anthropic 用量语义，修复 OpenAI 兼容层缓存统计不准确
- 修复真实 Claude Code 客户端被误应用 body mimicry 导致 prompt caching 失效的问题
- 修复 Stripe 支付页面被前端路由守卫拦截的问题
- 修复 OpenAI responses 流式请求在 pre-output failover 期间下游连接超时断开的问题
- 收紧 OpenAI responses 流式账号测试逻辑



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.119

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.119
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

