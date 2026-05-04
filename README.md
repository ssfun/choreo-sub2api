# Sub2API Dockerfile for Choreo

# Version

v0.1.122

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

提升 OpenAI 兼容上游接入稳定性，并新增管理后台邀请返利记录查看能力，便于运营侧追踪邀请、返利和余额转入历史。

## 新增功能

- 管理后台邀请返利记录：新增邀请、返利、转入记录页面和筛选查看能力
- OpenAI 兼容上游适配：优化 APIKey 账户对第三方兼容服务的接入流程

## 优化改进

- 返利历史展示：完善返利转入余额历史显示，并支持从返利记录跳转用户
- OpenAI 请求处理：提升图片请求、流式响应和直连转发场景的稳定性
- OpenAI 账户批量编辑：补充 compact 相关批量编辑字段

## Bug 修复

- 修复部分 OpenAI 兼容调用场景下使用记录不一致的问题
- 修复 OpenAI WebSocket passthrough 场景的请求上下文记录问题
- 修复部分 OpenAI 直连转发场景的参数传递和日志展示问题
- 修复管理后台概览中的邀请返利额度统计问题
- 修复邀请返利审计记录来源不准确的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.122

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.122
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
