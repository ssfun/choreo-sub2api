# Sub2API Dockerfile for Choreo

# Version

v0.1.143

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

订阅分组新增高峰时段倍率能力；OpenAI WebSocket 新增 http_bridge ingress 模式。

## 新增功能

- 订阅分组高峰时段倍率：支持为分组配置高峰时段与倍率，倍率信息全链路透传至可用渠道、支付计划与结算信息
- OpenAI WebSocket 新增 http_bridge ingress 模式及账号级 WS 选择器
- 支持恢复已撤销的订阅
- 用量记录新增 IP 地理位置查询与展示
- 管理端分组列表支持自定义列显示设置
- OpenAI 账号显示额度重置到期时间
- Anthropic 渠道支持 API Key Bearer 认证方式

## 优化改进

- 计费术语修正：「文本倍率」调整为「token 倍率」，明确高峰倍率同时作用于 token 计费的图片 token，图片按次计费不受高峰影响
- 高峰时段窗口按服务器时区展示并标注 UTC 偏移，避免误读为浏览器本地时间
- 切换分组类型为标准分组时自动清除高峰倍率配置

## Bug 修复

- 修复 Claude Code 流式响应 keepalive 卡顿问题
- 修复 OpenAI OAuth count_tokens scope 错误处理
- 修复 Codex 图片桥接注入导致 /responses/compact 请求失败的问题
- 修复 Gemini 推理模型（antigravity）无效参数处理
- 修复用户模型统计未按请求模型聚合的问题
- 修复 Claude OAuth token 交换 payload（移除多余的 expires_in）
- 修复 OpenAI 订阅到期时间未持久化的问题
- 修复非活跃工作区覆盖 OpenAI plan type 的问题
- 修复 Grok 媒体生成分组默认启用与图片别名归一化



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.143

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.143
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

