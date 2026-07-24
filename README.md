# Sub2API Dockerfile for Choreo

# Version

v0.1.164

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增聚合分组能力，一个分组可按模型路由规则将请求分发到不同平台的子分组；Ollama 账号支持 Cloud 官方用量自动刷新。

## 新增功能

- 聚合分组：新增 composite 平台类型分组，可配置模型路由规则，将不同模型的请求分发到已关联的各平台子分组，支持模型别名与路由预览，计费按实际转发的具体模型结算
- Ollama Cloud 用量同步：Ollama 账号支持自动刷新 Cloud 官方用量
- 支付宝移动端支付：预下单支持深链拉起支付宝客户端完成支付

## 优化改进

- OpenAI 账号测试默认使用具体模型 gpt-5.6-sol，不再优先别名 gpt-5.6
- Codex 身份批量导入的账号索引优化，提升大批量导入性能
- 模型限流恢复时间超过 24 小时按天显示，并在提示中补全具体日期

## Bug 修复

- 修复 OpenAI OAuth 透传路径缺少 input 规范化导致的 "Input must be a list" 报错
- OpenAI 流式响应异常断开后隔离对应代理，避免故障代理反复影响请求
- Grok 账号收到 402 后进入冷却，不再继续参与调度
- 修复简易模式自动选择 Grok 默认模型时图片能力未启用的问题
- 修复渠道定价因模型名未归一化导致匹配失败的问题
- 修复 CC Switch 导入时 Grok 密钥未归入 Grok Build 平台的问题
- 审计日志不再记录 Ollama 会话明文，并收紧凭证清理守卫



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.164

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.164
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

