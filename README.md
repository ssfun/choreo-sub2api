# Sub2API Dockerfile for Choreo

# Version

v0.1.133

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

本版本新增 OpenAI embeddings 网关、账号用量阈值自动暂停和前置拦截风控运行态，更新模型定价元数据，并集中修复多项网关兼容性、用量统计和账号调度问题。

## 新增功能

- OpenAI embeddings 网关：新增 embeddings 请求入口和转发支持
- 账号配额保护：支持按 5h/7d 用量阈值自动暂停账号调度，并支持全局默认与单账号禁用
- 风控运行态：完善前置拦截模式的审核记录和运行态展示
- 模型适配：新增 claude-opus-4-8 支持
- Codex 客户端限制：codex_cli_only 支持放行 Claude Code Codex 插件

## 优化改进

- 模型定价：更新模型价格和上下文窗口元数据，新增 Claude Opus 4.7/4.8、GPT 5.4/5.5、Gemini 3.x 等模型条目，并移除部分旧预览或过期模型
- 请求追踪：保留 usage 请求上下文，改善用量记录关联
- OpenAI 账号配置：优化端点能力配置界面的说明和校验
- 测试稳定性：修复内容审计日志异步断言

## Bug 修复

- 修复 Gemini Messages 流式响应中 tool_use 后接 text 时内容块未正确关闭的问题
- 修复 OpenAI 路由未按账号端点能力正确拦截的问题
- 修复 OAuth 401 处理可能用旧快照覆盖 credentials JSONB 的问题
- 修复系统更新已是最新版本时返回 500 的问题，改为返回 already_up_to_date
- 修复并发获取失败的错误分类，避免返回不准确的错误响应
- 修复 count_tokens 请求透传 generation-only 字段导致上游 400 的问题
- 修复 OpenAI WS 兼容性和 usage 统计，补齐终态事件、模型省略和图片 usage 映射
- 修复 WS 首 token 指标把终态事件误判为 token 事件的问题
- 修复 Responses 转 Chat 时 completion_tokens_details 透传不完整的问题
- 修复 Anthropic 转 Responses 时 input_tokens 未按 OpenAI 语义计入缓存 token 的问题
- 修复 body.context_management 与最终 anthropic-beta header 能力不匹配导致上游拒收的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.133

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.133
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

