# Sub2API Dockerfile for Choreo

# Version

v0.1.160

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

新增独立的提示词安全审计引擎：通过 OpenAI 兼容审计节点对用户提示词进行风险扫描，配套完整的管理端审计控制台；修复 Grok 媒体生成的多个可用性问题。

## 新增功能

- 提示词安全审计引擎（默认关闭）：支持配置多个 OpenAI 兼容审计节点（优先级排序、连通性探测、API Key 加密存储），对用户最新提示词异步扫描并记录审计事件；与现有内容审核引擎完全独立，互不影响
- 审计控制台：管理端新增运行态总览、审计节点池管理、策略配置与事件复查界面，支持保留完整提示词快照、事件筛选与一键删除筛选器

## Bug 修复

- 修复 Grok 媒体生成多个问题：参考图 payload 归一化处理；无媒体权限的账号自动隔离并在调度时跳过；修复调度器缓存丢失媒体资格标记导致隔离失效的问题
- 修复被动携带 image_gen namespace 的请求误触发 403 的问题：仅显式图像生成意图才要求 Responses capability，权限检查与并发槽位判定同步修正
- 修复保存 S3 备份配置未经过敏感操作二次验证（step-up TOTP）门控的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.160

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.160
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

