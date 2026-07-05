# Sub2API Dockerfile for Choreo

# Version

v0.1.144

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

修复高并发下用量日志静默丢失导致的对账缺口问题；新增 Anthropic Fable 专属 7d_oi 窗口的模型级限流支持，触发限流不再误伤整个账号。

## 新增功能

- Anthropic 账号支持 Fable 专属 7d_oi 限流窗口：仅该窗口触发 429 时按模型级限流处理（其他模型正常调度），账号列表新增 "7d F" 用量进度条
- 错误请求列表全面对齐用量明细：支持排序、筛选、列设置，新增分类过滤（管理端与用户端）
- Codex 图像工具策略：账号级四态控制（跟随渠道/强制注入/不注入/全部拦截），支持剥离图像生成工具
- 数据库迁移超时时间支持配置

## 优化改进

- 优化并发槽位清理逻辑
- 优化 Ops 实时账户统计查询性能
- 分组容量统计改为批量查询，降低热点路径数据库压力

## Bug 修复

- 修复高并发下用量日志被队列溢出静默丢弃的问题，改为背压等待与同步兜底，确保计费记录不丢失
- 修复 Codex 会话导入时同团队成员账号互相覆盖的问题，改为按 chatgpt_user_id 优先匹配
- 修复 OpenAI Responses 计费未使用映射后模型的问题
- 修复 Antigravity Gemini 3.1 Pro 路由不规范的问题
- 修复 Antigravity OAuth 401 后无法自动恢复的问题
- 修复 token_expired 刷新错误被无效重试的问题
- 修复 Grok OAuth 模型映射无法编辑、已配置并发数被覆盖的问题
- 修复邀请码普通兑换报错的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.144

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.144
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

