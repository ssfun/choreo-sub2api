# Sub2API Dockerfile for Choreo

# Version

v0.1.130

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- 内容审计支持按模型生效，可针对不同模型配置审计策略
- 注册邮箱白名单支持后缀通配符匹配
- 账号测试连接支持 Chat Completions 路径
- 新增订阅到期邮件提醒开关
- OIDC 登录在上游邮箱已验证时跳过选择页，直接登录/注册
- AWS Bedrock 账号增加 Claude Code 兼容性转换
- 兑换码支持批量更新
- API Key ACL 新增反代真实 IP 开关

- Cache Hit Rate 统计口径修正为包含全部 prompt tokens
- OpenAI 账号冷却调度逻辑优化
- 渠道监控兼容 Responses reasoning 输出
- 异常账号自动从调度中移除
- 删除账号时同步清理调度器缓存
- 升级 x/net 修复安全漏洞
- 升级 js-cookie 修复安全审计

- 修复反代部署下拒绝日志客户端 IP 不准确的问题
- 修复 Agent 工具循环中同一用户消息被重复审计的问题
- 修复 API 兼容层 developer 角色未映射为 system 的问题
- 修复 OIDC verified-email 快速路径的安全加固
- 修复用户 Provider 默认授权未包含 github/google/dingtalk 的问题
- 修复本地客户端限制错误被错误计入 SLA 的问题
- 修复 upstream "thinking block must contain thinking" 错误未自动重试的问题
- 修复复用的 refresh token 被错误重试的问题
- 修复 OpenAI 图片审核错误未正确透传的问题
- 修复邮箱白名单占位符中 @ 符号未转义的 i18n 问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.130

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.130
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

