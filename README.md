# Sub2API Dockerfile for Choreo

# Version

v0.1.163

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

分组新增 OpenAI 推理策略控制，可按分组约束推理力度；修复优雅关停超时导致缓冲用量/计费记录丢失的问题，并集中修复多处移动端布局适配。

## 新增功能

- 分组级 OpenAI 推理策略：支持设置推理力度上限与精确映射，HTTP 与 WebSocket 转发统一强制执行
- Grok 兼容 /responses/compact 端点：compact 请求可调度 Grok 账号，并支持链式中继的受保护视频下载
- Redis 连接支持 ACL 用户名配置

## 优化改进

- 调度器快照发布减少临时分配，降低发布路径开销
- 高级调度器无可用账号时补充排除原因统计，便于定位调度问题
- 修正示例 docker-compose 中错误的镜像地址

## Bug 修复

**Grok**
- 同步 OAuth 模型列表，策略类 403 隔离到模型级，不再影响整个账号调度
- Codex 客户端工具在 Responses 协议上完整往返保留
- 保留 OpenCode / CodeBuddy 的缓存会话

**OpenAI / Codex**
- Codex 级联中继保留客户端指纹
- preserve 路径 call_id 超长时压缩至 64 字符上限

**网关 / 转发**
- CC 桥接与 Anthropic /responses 桥接支持上游 SSE 紧凑格式
- SSE 字段解析兼容性增强
- 代理探测支持双栈回退

**计费 / 用量**
- 优雅关停超时不再跳过清理流程，避免缓冲的用量/计费记录丢失
- hosted image_generation 工具的图片 token 合并计入 /responses 计费
- 故障转移后同步缓存计费口径对齐
- 统一后台使用记录的模型筛选口径
- 成本明细提示框倍率保留有效小数

**调度 / 监控**
- 调度器配额元数据不再丢失
- LastUsedAt 缓存写入隔离，避免污染调度键
- 渠道监控 API Key 解密失败后停止调度该账号

**界面 / 移动端**
- 修复运维监控、账号管理等多处移动端布局溢出问题
- iOS 输入框聚焦不再触发页面自动缩放
- 用户侧套餐有效期单位不再把「月/周」显示成「天」
- 优惠码编辑弹窗过期时间改用本地时间预填
- 系统日志清理被拒绝时显示后端具体原因
- 用量页用户搜索结果与最新查询对齐，修复竞态



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.163

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.163
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

