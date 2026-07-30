# Sub2API Dockerfile for Choreo

# Version

v0.1.168

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增 Passkey（通行密钥）免密登录与模型广场页面；修复升级后安全审计配置丢失死锁、Claude OAuth 缓存断点丢失等多项问题。

## 新增功能

- Passkey 认证：个人资料页可注册/管理通行密钥并用于免密登录，管理员可在系统设置中控制登录开关，注册与撤销需验证账号密码
- 模型广场：新增公开模型广场页面，按分组展示各平台模型定价，管理员可配置展示范围
- Kimi K3 模型支持：新增计费与思考协议适配，并正确识别 1M 上下文后缀
- 账号模型白名单选择器支持一键复制模型 ID
- 部署支持 SKIP_SETUP 环境变量显式跳过初始化引导

## 优化改进

- 用户与 API Key 更新改为按声明列写入，避免并发更新时字段互相覆盖

## Bug 修复

- 修复升级后安全审计配置因解密失败而整体消失且无法重新保存的死锁问题
- 修复 Claude OAuth 模拟请求丢失 system 缓存断点、导致上游 prompt 缓存失效的问题
- 修复模拟响应使用 Bedrock 格式消息 ID（msg_bdrk_）的问题，改为 Anthropic 原生 msg_01 格式
- 修复 API Key 方式接入的 Codex 客户端丢失网页搜索工具声明的问题
- 修复 messages 桥接下 GPT-5.6 max 推理力度未保留的问题
- 修复透传账号仍受模型映射影响、误判模型支持范围的问题
- 修复 OpenAI Live 会话在存储故障时会话结算与观察者中断的问题
- 修复 Claude Sonnet 5 账号状态别名缺失导致状态显示异常的问题
- 修复未启用 Passkey 功能时个人资料页误弹加载失败提示的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.168

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.168
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

