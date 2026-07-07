# Sub2API Dockerfile for Choreo

# Version

v0.1.145

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增 EasyPay 自定义支付方式与 OpenAI 高级调度器控制；订阅 CNY 换算改为独立汇率的显式 opt-in 配置。

## 新增功能

- EasyPay 自定义支付方式：支持在内置方式之外配置自定义可见支付方式
- OpenAI 高级调度器控制：新增粘性加权、TopK/权重覆盖等高级调度配置项
- 订阅 CNY 换算：新增 SUBSCRIPTION_USD_TO_CNY_RATE 独立汇率配置（默认关闭），使促销倍率与订阅定价解耦
- 点击侧边栏 Logo/站点名可返回首页

## 优化改进

- 用量页费用明细提示措辞由"成本"统一为面向用户的"费用"
- 订阅撤销提示文案更新，明确说明可恢复选项
- 统一 Docker 部署 URL 安全默认值为开发友好模式（生产环境需显式收紧）

## Bug 修复

- Anthropic /v1/models 返回分组配置的自定义模型列表
- Antigravity 401 服务端失效 token 触发主动刷新，修复仅看 expires_at 的刷新死循环
- 支付响应清理 NUL 字节，避免异常
- 用量 CSV 导出补 UTF-8 BOM，修复 Excel 打开中文列乱码
- 修复 OpenAI 高级调度器审计发现的正确性与性能问题（跨分组账号泄漏、全表扫描/Redis N+1、订阅池回退等）



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.145

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.145
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

