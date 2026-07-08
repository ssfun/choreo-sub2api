# Sub2API Dockerfile for Choreo

# Version

v0.1.146

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- API Key 并发统计：密钥列表实时展示并发使用情况
- 账号请求头覆写：API Key 类型账号支持自定义 Anthropic/OpenAI 请求头（含敏感头禁止覆写防护）
- 账号数据导入：支持拖拽上传和批量导入账号数据
- 适配 OpenAI 新模型 gpt-5.6-sol/terra/luna，开放 Grok 图像生成计价配置
- 订阅套餐编辑器支持预览人民币扣费金额
- 管理端账号测试弹窗新增 compact 探测模式

- 优化 Redis SCAN 清理架构，采用索引驱动清理并加固边界场景
- Codex 版本门拒绝请求时返回带版本号的差异化提示文案

- 修复 OAuth 账号测试缺失 Codex CLI 请求头、未使用自定义 User-Agent 的问题
- 修复 responses compact 入站端点归一化问题，用量统计口径更准确
- 修复 base_url 非 /v1 前缀时同步 OpenAI 模型列表失败的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.146

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.146
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

