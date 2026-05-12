# Sub2API Dockerfile for Choreo

# Version

v0.1.126

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增 Airwallex 支付与多币种能力，并优化 OAuth 账号导入流程；同时改进 Antigravity、OpenAI、Gemini 等上游场景的稳定性。

## 新增功能

- Airwallex 支付：新增 Airwallex 支付通道，支持多币种支付配置
- 多币种支持：完善支付金额、手续费、订单快照和退款相关处理
- Antigravity 配置：支持配置 Antigravity User-Agent 版本
- OAuth 导入：优化管理端 OAuth 账号导入流程

## 优化改进

- 系统设置页：优化标签导航体验
- 支付页面：完善不同支付提供商的前端流程与状态展示

## Bug 修复

- OpenAI：修复多工具调用续传时上下文被裁剪导致 call_id 无法解析的问题
- OpenAI：修复用量限制错误后计划类型未同步的问题
- OpenAI：修复未定价模型无法记录零费用用量的问题
- OpenAI：修复 WebSocket 重放场景下工具输出续传丢失的问题
- Gemini：修复 Vertex token 交换未经过账号代理的问题
- Mimic：修复消息中 tool_use 名称与重写后的工具声明不一致导致请求失败的问题
- CCSwitch：修复导入链接缺少 Codex 模型的问题
- 支付：修复支付成功页充值金额显示 NaN 的问题
- 管理端：修复订单详情充值金额显示 NaN 的问题
- 服务账号：优化未知默认传输类型的处理，避免导入提示异常
- 消息网关：默认关闭消息 cache_control 改写，降低非预期请求变更风险

## 升级指南

- 如需启用 Airwallex 支付，请补充对应支付提供商配置；未启用时无需额外操作



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.126

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.126
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

