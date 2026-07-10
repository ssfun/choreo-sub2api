# Sub2API Dockerfile for Choreo

# Version

v0.1.149

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- 版本回退：版本徽章新增近 3 个历史正式版本的在线一键回退（release 构建），并提供脚本部署/Docker 部署的手动回退指引
- 用户角色管理：管理员创建/编辑用户时可设置角色（user/admin），内置"最后一个管理员不可降级"守卫并记录审计日志
- 用户 Token 排行：用量记录页新增用户 Token 排行，支持点击下钻到该用户的用量明细

- 用量页布局重构：明细区整合为单卡片三个 tab（用量明细/错误请求/用户排行）
- 新增延迟健康列：首字/总耗时合并展示并按阈值分档配色，管理端与用户端用量页共用
- 时长格式优化：超过 1 分钟显示为 Xm Ys、超过 1 小时显示为 Xh Ym

- 修复 Codex compact 流式请求收到 JSON 响应导致无限重连、重复消耗上游配额的问题，现正确合成为 Responses SSE 协议返回
- 修复 OpenAI /responses SSE 流的 response.failed 事件不应用错误透传规则、硬编码返回 502 的问题
- 修复 CC/Messages 协议转换路径按错误码配置的透传规则恒不命中的问题，并按账号平台正确匹配规则
- 修复 Grok 配额探测模型不稳定的问题
- 修复 Grok OAuth 授权、图像生成与用量展示流程中的多个问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.149

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.149
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

