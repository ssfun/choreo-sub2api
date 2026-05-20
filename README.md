# Sub2API Dockerfile for Choreo

# Version

v0.1.127

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增钉钉 OAuth 登录、用户用量按平台拆分、兑换码有效期等功能，并修复多项支付、网关与账号相关问题。

## 新增功能

- 钉钉 OAuth 登录接入，支持 internal_only 用户属性同步
- 用户用量按平台拆分展示，UsersView 列设置可配置并支持用量列排序
- 兑换码支持设置使用有效期
- 新增上游模型同步功能（服务、管理 API 及前端控制）
- OpenAI 支持后台配置 Responses API 路由
- 渠道未填价时按 LiteLLM 默认价展示
- 新建账号弹窗补全 Responses API 路由选项
- 新增订阅配额时间判断工具

## 优化改进

- OpenAI OAuth 账号显示邮箱并新增用量手动刷新按钮
- 公告查询添加分页上限，优化分组按账户数排序的数据加载
- 安装脚本检查 Bash 版本并提示升级
- 部署移除数据库与 Redis 宿主机端口映射
- TOTP 输入框增加 autocomplete 支持验证码自动填充
- 管理后台设置 tab 暗色模式下可读性优化
- 更新 sponsors 信息

## Bug 修复

- 修复 DeepSeek reasoning_content 在 chat compatibility 路径下丢失
- 修复 OpenAI Responses SSE 终止事件识别错误
- 修复 OpenAI 转换 chat-completions 到 responses 时出现 null content
- 修复 OpenAI compat usage 解析问题
- 修复 OpenAI OAuth 用量配额手动刷新无效
- 修复缺少 refresh_token 的 OpenAI OAuth 账号持续命中 502 问题（永久禁用）
- 识别 OpenAI 上游静默拒绝（空流 + finish_reason=stop）并触发 failover
- 修复 OpenAI 版本化兼容 base URL 处理
- 修复 OpenAI service_tier 默认透传
- 修复 codex 工具调用 ID 重写时下划线被吞
- 修复 codex 自动审查模型定价缺失
- 修复支付宝官方扫码二维码生成错误
- 修复微信支付 pending 订单对账问题
- 修复支付订单产品名前后缀应用到订阅
- 修复管理端日卡额度提示，将日卡改为一次性每日配额并修正用户端提示文案
- 修复管理后台分组页可用账号数显示错误
- 隐藏非 antigravity 计划的模型范围
- 修复 Gemini chat completions 路由到上游和 chat compat 编译失败
- 修复 Gemini 分组返回 Gemini 模型
- 修复 Google One Gemini 429 使用 tier 冷却
- 修复 Anthropic passthrough 流增加 keepalive
- 修复 passthrough 首 token 时间计算
- 修复 Anthropic 流式空 thinking 块被丢弃
- 修复 Antigravity 模型列表请求加固
- 修复账号组合模型限制保留
- 修复编辑账号弹窗回退旧 credentials 结构以兼容旧后端
- 修复 Ops SLA 排除 IP 拒绝访问、本地调度容量错误及深链初始化错误
- 修复模型容量瞬时错误重试逻辑
- 修复按次/图片计费模式跳过 token 区间重叠校验
- 修复图片生成上游 context 分离
- 修复图片计费 size 归一化
- 修复初始化完成后访问 setup 页面
- 修复批量复制兑换码兼容性
- 修复 OIDC 兼容邮箱在 pending 流中的显示
- 修复管理端账号接口返回敏感凭证字段（安全修复）
- 修复 Docker frontend builder pnpm 版本锁定为 v9



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.127

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.127
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

