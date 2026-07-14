# Sub2API Dockerfile for Choreo

# Version

v0.1.153

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- Grok 视频编辑与延长：网关新增视频 edit/extension 端点支持
- Apple 容器部署：新增 apple-container.sh 部署脚本及配套文档
- 账号编辑弹窗支持手动覆盖 OpenAI 订阅档位 plan_type（仅 OAuth 账号）

- API Key 列表最近使用 IP 查询性能优化，并新增数据库索引
- 内嵌静态资源设置长效 Cache-Control，直接部署时浏览器不再重复下载控制台资源

- 修复池模式同账号重试次数配置对 Anthropic/Gemini/通用转发路径不生效的问题
- 修复调度缓存出现异常时间时阻塞账号调度的问题
- OpenAI WebSocket 入站会话增加生命周期上限，防止长连接无限期占用
- Grok 账号支持第三方 API base URL，不再强制 api.x.ai
- Grok API Key 账号支持上游模型同步
- 修复 /alpha/search（Grok Live Search）被内嵌前端拦截的问题
- 修复 Codex chat 补全桥接丢失 additional tools（自定义工具）的问题
- 修复流式 Anthropic 兼容层 max_tokens/content_filter 停止原因映射不正确的问题
- 修复 Read 工具参数未实时流式发送、依赖 .done 事件的问题
- 修复用量统计跨时区日期偏移，API 与面板时间范围保持一致
- 删除泄露内部 AI 渠道配置的废弃支付接口
- 补齐中文语言包 overview 和 misc 缺失的翻译
- 修复账号列表滚动抖动（小数据量关闭虚拟化并按行主键缓存行高）



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.153

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.153
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

