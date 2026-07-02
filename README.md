# Sub2API Dockerfile for Choreo

# Version

v0.1.142

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- OpenAI Spark 影子账号：链接型影子账号（parent_account_id）复用母账号凭据/代理，独立走 spark 配额维度与用量窗口，一母一影强约束、母账号 429 与影子互不连坐
- 适配 Claude Sonnet 5：模型白名单与 dateline 归一化路径打通
- 抹除 Anthropic OAuth 请求中客户端 dateline 隐写指纹：对 /v1/messages 的 OAuth/setup-token 账号请求做 dateline 归一化，抹除撇号 / 日期分隔符隐写位；默认开启，可在系统设置切换
- Grok 媒体（图像）路由：识别官方 grok 媒体模型 ID、路由 grok media 端点，并支持图像编辑上传转换

- 用户使用记录列表默认显示“推理强度”列
- OpenAI 默认模型列表移除 gpt-5.3-codex（保留 gpt-5.3-codex-spark 计费/别名逻辑）
- 前端 Grok 图标、配色与国际化文案打磨
- 国际化：清理残留英文兜底、修复中文文案在清理中丢失、渠道间隔校验强制走本地化路径、多处 UI 字符串补齐 en/zh 翻译

- 修复账号列表分页 total 与实际条目数不一致（Ent query builder 在 Count 与 All 之间复用导致 SoftDeleteMixin 谓词累积）
- 修复订阅撤销后软删除失效：新增撤销接口、同步失效 L1 与 billing 缓存，跨实例广播失效、列表查询感知软删除，DTO 增加 revoked_at
- 修复 Codex OAuth 路径下跨轮次加密推理内容被丢弃（store=false 时应去掉 rs_* id，而非删除整个 reasoning item）
- 修复 GPT-5.5 Pro Codex 模型名被 Codex OAuth 归一化降级为 gpt-5.5，补齐计费回退与长上下文策略
- 允许五平台（含 Grok）配额更新



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.142

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.142
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

