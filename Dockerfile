# 构建可选的 Komari agent；最终镜像只复制二进制，避免把 Go 工具链带入运行层。
FROM golang:alpine AS komari-agent-builder

WORKDIR /src

RUN apk add --no-cache git

RUN git clone https://github.com/komari-monitor/komari-agent.git . \
    && git fetch --tags \
    && git checkout "$(git describe --tags --abbrev=0)" \
    && go mod download \
    && VERSION="$(git describe --tags --always)" \
    && CGO_ENABLED=0 go build \
        -trimpath \
        -ldflags="-s -w -X github.com/komari-monitor/komari-agent/update.CurrentVersion=${VERSION}" \
        -o /out/komari-agent .

# 运行层基于上游 Sub2API 镜像，仅补齐 Choreo 所需的 Redis、Caddy 和入口脚本。
FROM weishaw/sub2api:latest

USER root

RUN apk add --no-cache \
    ca-certificates \
    caddy \
    redis \
    tzdata \
    && rm -rf /var/cache/apk/*

# Choreo 建议使用 10000-20000 范围内的非 root UID；所有运行时写入目录放在 /tmp。
RUN addgroup -g 10014 choreo \
    && adduser -u 10014 -G choreo -s /bin/sh -D choreo \
    && mkdir -p \
        /tmp/sub2api \
        /tmp/sub2api/pricing \
        /tmp/redis \
        /tmp/caddy-config \
        /tmp/caddy-data \
    && chown -R 10014:10014 \
        /tmp/sub2api \
        /tmp/redis \
        /tmp/caddy-config \
        /tmp/caddy-data

WORKDIR /app

COPY --from=komari-agent-builder /out/komari-agent /app/komari-agent
COPY --chmod=755 entrypoint.sh /app/entrypoint.sh
COPY Caddyfile /app/Caddyfile

# 默认值面向 Choreo：外部 PostgreSQL、内置 Redis、只写 /tmp、日志输出到 stdout。
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

# 8080 暴露 REST/API，8081 暴露 Choreo WS endpoint，经 Caddy 转发到 8080。
EXPOSE 8080 8081

HEALTHCHECK --interval=30s --timeout=5s --retries=3 --start-period=30s \
  CMD wget -q -T 5 -O /dev/null "http://localhost:${SERVER_PORT:-8080}/health" || exit 1

USER 10014

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/app/sub2api"]
