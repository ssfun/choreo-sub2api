# Sub2API Dockerfile for Choreo

# Version

v0.1.151

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- OpenAI Fast/Flex 策略支持用户级规则：规则可指定生效用户，用户专属规则优先于全局规则，便于为特定用户配置例外

- 修复 Codex 上游 originator 与 User-Agent 错配导致请求 404 的问题，覆盖普通转发、透传、WebSocket、用量探针与账号测试等路径
- 修复 GPT-5.6 计费与用量统计问题：补齐价格识别与模型别名匹配，完善用量统计口径
- 修复 Grok Responses 接口丢失 reasoning effort 参数的问题，兼容的参数将被保留
- 修复 Codex 图像生成时 image_gen 命名空间声明未正确剥离的问题
- 修复 setup-token 账号未纳入后台自动刷新、令牌到期后请求返回 401 的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.151

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.151
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

