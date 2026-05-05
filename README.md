# Sub2API Dockerfile for Choreo

# Version

v0.1.123

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

修复 OpenAI 兼容接口中未知模型被默认模型静默兜底的问题，请求会保留原始模型并透传上游错误。

## Bug 修复

- OpenAI 模型转发：移除未知 GPT 模型自动回退到分组默认模型的逻辑，避免无效模型被错误转发为默认模型
- 计费记录：保持渠道未映射请求按实际上游计费模型记录，避免计费模型被原始请求模型覆盖

## 优化改进

- 模型支持：补充 gpt-5.4-nano 本地兜底计费价格
- 测试覆盖：增加未知模型不兜底、OAuth 透传和模型归一化相关用例



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.123

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.123
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
