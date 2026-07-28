# Sub2API Dockerfile for Choreo

# Version

v0.1.166

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增面板 API 限流保护，防止高频请求冲击数据库；修复 WebSocket 多轮会话计费、模型映射统计口径等多项计费与统计准确性问题。

## 新增功能

- 面板 API 限流：管理后台可配置面板接口限流策略，认证接口按用户、公开接口按真实 IP 限流，保护数据库免受高频请求冲击

## 优化改进

- Antigravity OpenAI 兼容转发全面加固，并拒绝仅含 usage 的非流式空响应
- Codex Responses 与 Anthropic 协议互转兼容性完善（工具调用配对等场景）
- 伪装的 Claude Code CLI 版本号升级到 2.1.220
- Caddy 部署配置禁用 SSE 压缩缓冲，修复流式响应卡顿
- 可用渠道列表适配移动端显示
- 升级图像处理与遥测相关依赖，修复安全漏洞

## Bug 修复

- 修复 WebSocket 多轮会话统一按单一模型计费的问题，现按每轮实际使用的模型计费
- 修复账号故障切换时残留其他账号 reasoning 内容导致上游报错的问题
- 修复经第三方代理转发的 Claude Code 请求未被识别、导致上游 prompt 缓存失效的问题
- 修复模型映射后用量统计口径错误的问题，现保留最终上游模型
- 修复 Antigravity Gemini 3.6 Flash 缺少定价导致计费异常的问题
- 修复系统设置部分更新时未提交字段被清空的问题
- 修复组合分组前缀路由未配置上游模型时请求模型丢失的问题
- 修复 CONFIG_FILE 显式指定配置文件路径不生效的问题
- 修复 Grok 账号手动测试遇支付失败（402）时未暂停账号的问题
- 修复 Gemini 号池模式下可重试错误未触发自动重试的问题
- 修复计费探针纳秒时间戳解析失败导致探测不执行的问题
- 修复支付看板多币种统计混算的问题，现按币种分组展示
- 修复管理端用量日志无法按请求 ID 筛选的问题
- 修复管理端用量筛选中路由用户不显示的问题
- 修复注册页可选推广码输入框不显示的问题
- 修复安全审计提示词配置不可用时仍被加载的问题
- 修复 Gemini 兼容层丢失 Hermes 网页搜索函数声明的问题
- 修复分组描述换行及下拉框视口边界溢出的显示问题
- 修复渠道监控时间线在窄卡片下溢出的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.166

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.166
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

