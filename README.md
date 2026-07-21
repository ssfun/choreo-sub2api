# Sub2API Dockerfile for Choreo

# Version

v0.1.162

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

客户端真实 IP 解析全面可配置：支持显式可信代理与自定义 IP 请求头，反向代理/Docker 部署下正确识别来源 IP；异步生图对象存储改为后台配置，保存即生效。

## 新增功能

- 客户端 IP 解析设置：安全设置新增客户端 IP 模式配置，支持显式可信代理列表与自定义客户端 IP 请求头，兼容反向代理和 Docker 部署，请求头变更记录审计日志
- 异步生图对象存储改为后台配置：备份页新增配置卡片，保存即生效；同时修复环境变量无法配置 image_storage 等凭证的问题
- Grok 客户端工具缓存：新增管理端开关（Free 账号默认开启），覆盖 Claude Desktop、Codex Lite、Trae 客户端工具，缓存路由跨轮次保持
- 更新检查支持配置 GitHub Token，规避未认证 API 限流

## 优化改进

- 订阅到期时间显示精确到分钟，剩余天数改为向上取整
- OpenAI 配额不足时返回标准 insufficient quota 错误格式
- Codex 模型发现兼容标准 OpenAI 模型列表响应格式
- Responses 链路性能优化：SSE 事件类型解析与生图意图判定复用
- 运维定时报表邮件模板优化
- 前端体验：暗色模式配色统一 slate 色板、批量生图指引页接入多语言、零散硬编码文案本地化
- docker-compose 修复：dev/local 环境 Redis 命令参数与 PostgreSQL 调优参数真正生效

## Bug 修复

**安全与计费**
- 部分更新 API Key 时不再静默清空 IP 白名单/黑名单
- 修复提示词安全审计无法关闭：仅在拦截（blocking）意图下 fail-closed
- 备份设置不再使用自动生成的临时加密密钥持久化 S3 SecretAccessKey，避免重启后无法解密
- 同账号重试不再重复计入缓存计费
- 修复自定义货币符号误显示为 USD 的问题

**OpenAI / Codex**
- HTTP 桥接首轮传输/HTTP/SSE 失败正确走账号 failover，并要求真实终态事件才结束响应
- Codex models manifest 返回 401 时标记 OAuth 账号不可调度
- OAuth system prompt 去重，避免重复注入
- Codex call_id 归一化长度限制
- Agent Identity 导入按 Team 隔离

**Grok**
- 支持链式视频内容代理
- 手动连接测试绕过调度门控，限流/冷却中的账号也能测试连通性
- 改进 Claude Messages prompt-cache 往返
- count_tokens 改为本地估算；配额探测瞬时失败自动重试；代理质量检查纳入 Grok

**Anthropic 兼容**
- message_start 事件的 stop_reason 正确输出 null
- 非流式缓冲响应的 Content-Type 修正

**其他**
- 系统原地更新与 HTTP 请求生命周期解耦，慢速网络下更新不再被 30–60 秒超时中断
- 可用渠道页恢复滚动；用户余额弹窗暗色模式文字可读性修复



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.162

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.162
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

