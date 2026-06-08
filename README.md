# Sub2API Dockerfile for Choreo

# Version

v0.1.135

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- 代理有效期与失败回退：支持为代理配置有效期、到期提醒天数与失败回退目标；到期后台扫描自动改投账号，账号侧支持手动回切原代理，列表展示到期徽章，导入导出携带相关字段
- 用量统计拆分缓存创建与命中 token：聚合统计区分缓存创建 / 命中 token，并新增缓存命中率展示
- 新增 account_temp_unscheduled_count 告警指标：统计当前处于临时不可调度窗口的账号数，覆盖代理 / 凭据故障触发的自动摘除告警

- OpenAI /responses 传输层错误（代理 / 网络故障）改为 failover 到健康账号，持久故障临时摘除故障账号，避免坏账号被反复调度

- 修复网关强制流式时非流式响应仍返回 text/event-stream 响应头，导致下游（如 new-api）误判为 SSE 的问题
- 修复 OpenAI 跨组切换后沿用旧 previous_response_id 导致的会话鉴权失败问题
- 修复 API Key 独占分组未强制校验、可越权使用其他分组的问题
- 修复 OpenAI 粘性会话分组校验，忽略不属于当前请求分组的过期粘性会话
- 修复被动采样模式下 5h 窗口重置时间错误显示为「现在」的问题
- 修复账号管理状态筛选下拉菜单选项过多时被截断显示不全的问题



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.135

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.135
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

