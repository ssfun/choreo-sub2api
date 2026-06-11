# Sub2API Dockerfile for Choreo

# Version

v0.1.136

# Releases

> AI API Gateway Platform - 将 AI 订阅配额分发和管理

- Admin compliance acknowledgement: administrators must read and confirm the compliance statement before using admin features
- Support for the claude-fable-5 model (including Bedrock and Antigravity platform adaptation, and frontend model selection)
- Admin user list now supports filtering by API Key group (dedicated / public / subscription / disabled groups)

- Optimized account group scheduling indexes for better scheduling performance
- Reduced scheduler debug logging loop overhead
- Refactored Bedrock CC compatibility handling: unified request body cleanup and header filtering logic

- Fixed double-write on gateway error passthrough responses that corrupted the response body received by clients (covers Messages / ChatCompletions / Responses and error paths across all platforms)
- Fixed Bedrock 400 errors caused by unsupported top-level request fields, and fixed beta token cleanup logic
- Fixed frontend Bedrock CC compat toggle not persisting after save and page reload
- Fixed incorrect model body replacement during OpenAI failover
- Fixed UTF-8 truncation in idempotency response caching
- Fixed prompt cache key not being propagated for OpenAI Chat Completions



---

## 📥 Installation

**Docker:**
```bash
# Docker Hub
docker pull weishaw/sub2api:0.1.136

# GitHub Container Registry
docker pull ghcr.io/wei-shaw/sub2api:0.1.136
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

