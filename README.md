# Sub2API Dockerfile for Choreo

# Version

v0.1.129

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- API Key 用量明细：用户用量页支持按日查看 API Key 用量明细

- 分组状态校验：停用或删除分组后，关联 API Key 会被正确阻断
- 分组可用计数：修正分组账号可用数量统计口径
- 邮件提醒：修复提醒去重键，避免重复发送通知



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.129

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.129
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

