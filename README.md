# Sub2API Dockerfile for Choreo

# Version

v0.1.158

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

Grok 上游端点管理全面升级：支持官方 API / 区域端点手动切换与快捷填充，并修复多项 OAuth 路由回归；管理端新增用户限额批量修改与分组一键复制。

## 新增功能

- 用户限额批量修改：管理端用户列表支持批量设置并发数与 RPM 限制，可按勾选用户或全部用户生效
- 分组一键复制：服务端复制分组的计价、模型路由与账号绑定（含优先级），副本默认停用待人工确认后启用
- Grok 快捷端点：账号新增/编辑/批量编辑提供 Grok Build CLI、官方 API 及 us-east-1 / us-west-2 / eu-west-1 区域端点一键填充，输入框仍可自由填写第三方地址

## 优化改进

- Grok OAuth 账号上游地址改为"填什么用什么"：官方 API、区域端点、第三方转发地址均按填写值转发与探测；*.api.x.ai 区域端点纳入可信 host
- Grok OAuth 生图/视频等媒体请求改走官方 API，避开 CLI 网关较小的请求体大小限制（自定义转发地址不受影响）
- Codex 图片桥接配置文案澄清：区分 hosted 桥接与客户端本地 image_gen，API Key 模式提示需完全重启 Codex 后新建任务

## Bug 修复

- 修复 Grok OAuth 账号填写官方 API 地址保存后不生效、重新编辑被静默清空的问题
- 修复 Grok SSO 批量建号时自定义转发地址被官方地址覆盖的问题
- Grok CLI 网关返回 403 Access denied 时自动改用官方 API 重试可重放请求，避免试用订阅误判不可用
- 修复 Grok /v1/models 模型清单回归：恢复返回含 reasoning effort 元数据的 Grok 专属格式，无可用模型时回落默认清单
- Grok key 建号配置模板启用 Codex Responses WebSocket v2
- 修复 WebSocket 下行生图结果停留在"进行中"状态的问题
- 自定义 API Key 上游返回无效模型清单时不再破坏 Codex 能力发现：结构异常归类为可重试，换号且不污染缓存
- 修正代理兜底设置文案为"过期兜底"



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.158

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.158
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

