# ==========================================
# 阶段 1: 构建阶段 (Builder)
# ==========================================
FROM golang:alpine AS builder

WORKDIR /src

# 安装 git
RUN apk add --no-cache git

# 1. 拉取源码
RUN git clone https://github.com/komari-monitor/komari-agent.git .

# 2. 检出最新的 Tag
RUN git fetch --tags && \
    LATEST_TAG=$(git describe --tags --abbrev=0) && \
    git checkout $LATEST_TAG

# 3. 编译并注入版本号
RUN VERSION=$(git describe --tags --always) && \
    echo "--------------------------------------" && \
    echo "正在构建版本: $VERSION" && \
    echo "--------------------------------------" && \
    go mod download && \
    CGO_ENABLED=0 go build \
    -trimpath \
    -ldflags="-s -w -X github.com/komari-monitor/komari-agent/update.CurrentVersion=${VERSION}" \
    -o komari-agent .

# ==========================================
# 第二阶段：运行环境 (Final Image)
# 基于 weishaw/sub2api:latest
# ==========================================
FROM weishaw/sub2api:latest

USER root

RUN apk add --no-cache \
    redis \
    caddy \
    ca-certificates \
    tzdata \
    && rm -rf /var/cache/apk/*

RUN addgroup -g 10014 choreo && \
    adduser -u 10014 -G choreo -s /bin/sh -D choreo && \
    mkdir -p /tmp/sub2api /tmp/sub2api/pricing /tmp/redis /tmp/caddy-config /tmp/caddy-data && \
    chown -R 10014:10014 /tmp/sub2api /tmp/redis /tmp/caddy-config /tmp/caddy-data
    
# ------------------------------------------------------------
# 从第一阶段 (builder) 复制我们编译好的 komari-agent 二进制文件
# ------------------------------------------------------------
COPY --from=builder /src/komari-agent /app/komari-agent

WORKDIR /app

COPY --chmod=755 entrypoint.sh /app/entrypoint.sh
COPY Caddyfile /app/Caddyfile

ENV AUTO_SETUP=true \
    SERVER_HOST=0.0.0.0 \
    SERVER_PORT=8080 \
    SERVER_MODE=release \
    HOME=/tmp \
    XDG_CONFIG_HOME=/tmp/caddy-config \
    XDG_DATA_HOME=/tmp/caddy-data \
    DATA_DIR=/tmp/sub2api \
    PRICING_DATA_DIR=/tmp/sub2api/pricing \
    LOG_OUTPUT_TO_STDOUT=true \
    LOG_OUTPUT_TO_FILE=false \
    REDIS_HOST=127.0.0.1 \
    REDIS_PORT=6379 \
    REDIS_ENABLE_TLS=false

EXPOSE 8080 8081

HEALTHCHECK --interval=30s --timeout=5s --retries=3 --start-period=30s \
  CMD wget -q -T 5 -O /dev/null "http://localhost:${SERVER_PORT:-8080}/health" || exit 1

USER 10014

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/app/sub2api"]
