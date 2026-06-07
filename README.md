# Sub2API Dockerfile for Choreo

# Version

v0.1.134

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- Codex/Claude Code 模拟增强：对齐 Claude Code 指纹至 CLI 2.1.161，新增模型感知的 Codex prompt / client_metadata / anthropic SSE 补全
- 失败请求追踪：用户端与管理端均可记录并查看失败请求，错误日志补充 key 归因与早退字段
- 管理端用量增强：/admin/usage 支持查看已删除用户的历史用量，账号用量窗口（5h/7d）新增说明 tooltip
- 添加账号时支持同步上游模型列表
- 新增 codex-auto-review 默认模型
- 图像 token 计费支持，渠道定价可完全覆盖图像输出 token 价格
- 用户×平台配额：DB 写聚合 flusher 与 sentinel 回填，消除无配额用户每请求回源 DB

- 重新设计 Codex Responses ↔ Chat Completions 桥接，提升兼容性与稳定性
- 网关请求体处理优化：延迟解码、引用化请求体、减少内存拷贝，降低 OpenAI 大请求内存占用
- /admin/usage 打开速度与刷新响应优化
- 多实例部署：周期性后台任务通过 leader lock 仅在主节点执行
- 运维监控 TTFT（首 token 延迟）按流式样本数加权统计
- OpenAI 图像限流按能力维度冷却并故障转移
- 兼容 Redis 3.2–4.x（使用 TIME 的 Lua 脚本）
- 数据库连接池强制连接生命周期下限

- 修复 Linux DO 登录误进入邮箱验证流程
- 修复删除用户时未一并删除其 API Key、未复用调用方事务的问题
- 修复 PostgreSQL 初始化连接使用维护库、DSN dbname 解析问题
- 修复流式异常：缺失终止事件、reasoning-only 回复、tool_use/tool_result 配对、终止输出规范化
- 修复 DeepSeek reasoning-only 回复无法透传
- 修复图像上游错误被吞为通用 502，改为透传真实错误
- 修复 OpenAI failover 复用过期缓存请求体、WebSocket 用量去重冲突、超大 WS 请求桥接
- 修复 Codex 5h 用量百分比快照自愈与重置窗口对齐
- 修复账号编辑时固定配额窗口未归一化
- 修复 OpenAI OAuth token 刷新信息补全
- 修复 EasyPay 订单查询改用 trade_status
- 修复调度器粘性会话健康逃逸、账号状态变更后快照同步
- 修复管理员清空分组描述未持久化
- 修复内容审核自动封禁误伤管理员账号
- 安全修复：未授权 Key 访问返回 404 而非 403 防 ID 探测（CWE-204）、API Key 名称转义防存储型 XSS（CWE-79）
- 修复 antigravity gemini 限流与账号调度
- 修复计费 balance 字段指针类型、前端用量页 image_output_tokens 明细展示、可空字段渲染崩溃致整表空白



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.134

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.134
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

