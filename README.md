# Sub2API Dockerfile for Choreo

# Version

v0.1.138

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增订阅推广返利与"优先最快重置账号"调度策略；适配新版 Claude Code CLI，并修复多家上游（Vertex / Gemini / OpenAI / GLM / 图像生成）的兼容性问题。

## 新增功能

- 订阅支付应用推广返利（affiliate rebate）
- 账号调度支持「优先最快重置」可选策略
- 更新 CC Switch 的 OpenAI 默认模型

## 优化改进

- 用量页显示缓存 Token 明细
- chat-only API Key 账号在日志中记录 /v1/chat/completions 上游端点

## Bug 修复

- 适配新版 Claude Code CLI：移除 cch 签名
- Vertex Anthropic 路径过滤 anthropic-beta 头
- Gemini 工具 schema 清理不支持的字段
- 图像生成识别 response.incomplete 并记录软失败上游响应
- auto 模式通过任意 cc_entrypoint 识别 Claude Code IDE 客户端
- GLM reasoning effort 规范化
- 邮箱绑定强制后缀白名单校验
- 促销码编辑时允许清空有效期
- 自定义页面切换时刷新文档标题
- 部署：bind mount 增加 :Z SELinux 标签



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.138

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.138
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

