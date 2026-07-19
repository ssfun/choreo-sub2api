# Sub2API Dockerfile for Choreo

# Version

v0.1.161

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

安全防护全面开关化：敏感操作 step-up 2FA 与会话 IP/UA 绑定均改为默认关闭、按需开启，避免升级后误锁定；同时修复 Grok 受保护视频内容访问及一系列媒体链路问题。

## 新增功能

- 敏感操作 step-up 2FA 总开关（默认关闭）：开启后，账号/代理导出、备份创建/下载/恢复、S3 配置修改、提升管理员等操作需在 15 分钟内完成过 TOTP 验证

## 优化改进

- 会话 IP/UA 绑定默认改为关闭（功能保留，可在设置页开启），避免 IP 变动导致登录掉线
- 安全开关保存字段改为可空：旧客户端全量保存设置不再静默重置安全开关
- 入口拒绝日志降噪，并强化网关鉴权边界
- 完善上游 Sub2API 计费倍率探测与账号展示
- Docker 镜像改为交叉编译构建，Apple Silicon 构建 amd64 镜像不再依赖 QEMU 模拟

## Bug 修复

**Grok 相关**
- 修复受保护视频内容无法访问：签名视频内容与状态查询改经上游账号代理，仅限请求所有者访问且代理链接保持同源
- 修复媒体请求未应用账号模型映射的问题
- Grok OAuth 媒体生成按付费资格门控，Free 账号探针与健康检查口径对齐
- 加密推理内容失效时自动重试恢复一次；CLI 聊天权限拒绝自动重试
- 纯客户端函数工具不再错误注入原生搜索工具

**调度与路由**
- 临时冷却按模型隔离，不再封锁同账号的其他模型
- 池模式下临时不可调度规则正确生效
- 瞬时账号耗尽改为返回 503，不再误报 404 模型不存在

**OpenAI/Codex 相关**
- Responses 流式补发 content_part 事件与完整输出，修复 OpenAI SDK 流式累积报错和 get_final_response 为空的问题
- OpenAI WS 透传模式强化回合生命周期管理
- 归一化 Claude Code 1m 模型后缀

**其他**
- 修复过期的管理员分配套餐无法续期的问题
- Antigravity 保留付费 tier 的 PlanType，异常状态仅通过 IneligibleTiers 标记
- 修复监控无法提取 Anthropic 响应文本块的问题
- 修复自定义品牌在初始加载时闪烁的问题
- 套餐有效期表头与表单标签使用动态单位，不再写死"天"
- 聊天流传输失败正确上报错误
- 修复 docker-compose 中 Redis 持久化参数未生效的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.161

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.161
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

