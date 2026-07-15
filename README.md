# Sub2API Dockerfile for Choreo

# Version

v0.1.155

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- Grok 渠道健康监控：监控中心支持 Grok 平台健康检查，新导入的 OAuth 账号自动探活，账号列表显示 Free 计划徽标
- Grok Web SSO 批量导入：批量粘贴 SSO key 自动转换为 Build OAuth 账号，失败自动跳过并汇总结果（原账号类型页的 SSO 卡片入口已移除）
- 系统日志支持按主机名过滤
- 管理后台新增可选开启的服务端耗时指标采集（server timing）

- Grok 免费账号配额改用滚动 24 小时估算，并改进免费配额探测与用量展示
- OpenAI 上游启用 HTTP/2 keep-alive PING，自动剔除失效的 Codex 连接
- OpenAI 重置额度（reset credits）检测更准确
- 网关不再重复扫描请求体，降低大请求处理开销
- Codex 模型列表支持经 API Key 上游代理获取，manifest 刷新更稳定并支持账号故障转移

- 修复调度器全量重建风暴：账号到期暂停、代理到期改投不再触发全量重建，并发重建自动合并，并修复事件延迟计算错误
- 修复 OpenAI 长上下文重复计费问题：长上下文计费改为账号级开关，默认关闭
- 修复原生 Responses 转发丢失工具 namespace 的问题（工具名原样透传，含 WSv2 链路）
- 修复 Grok reasoning 项 content 为 null 导致上游 422 报错的问题
- 修复 Responses Lite 丢失客户端图像工具导致图片无法显示的问题
- 修复图像生成问题：非流式请求保持连接不再超时断开，流式生成结果补齐最终状态
- 修复 /v1/messages 精确模型映射未按配置生效的问题
- 修复 Codex 图像生成工具重复注入导致与托管工具冲突的问题
- 修复 Codex 计划门控模型 400 后反复重试的问题（按账号冷却）
- 修复 Grok 免费账号提示词缓存路由标识不稳定的问题
- Grok OAuth 媒体请求改走官方 API 路由



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.155

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.155
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

