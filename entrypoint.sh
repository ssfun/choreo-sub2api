#!/bin/sh
set -eu

log() {
    printf '%s [%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1" "$2"
}

is_valid_port() {
    case "${1:-}" in
        ''|*[!0-9]*) return 1 ;;
    esac
    [ "$1" -ge 1 ] && [ "$1" -le 65535 ]
}

require_env() {
    name="$1"
    eval "value=\${$name:-}"
    if [ -z "$value" ]; then
        log "Config" "$name is required"
        exit 1
    fi
}

# Sub2API 配置：运行时写入目录固定到 /tmp，适配 Choreo 只读根文件系统。
export AUTO_SETUP="${AUTO_SETUP:-true}"
export SERVER_HOST="${SERVER_HOST:-0.0.0.0}"
export SERVER_PORT="${SERVER_PORT:-8080}"
export SERVER_MODE="${SERVER_MODE:-release}"
export HOME="${HOME:-/tmp}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-/tmp/caddy-config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-/tmp/caddy-data}"
export DATA_DIR="${DATA_DIR:-/tmp/sub2api}"
export PRICING_DATA_DIR="${PRICING_DATA_DIR:-$DATA_DIR/pricing}"
export LOG_OUTPUT_TO_STDOUT="${LOG_OUTPUT_TO_STDOUT:-true}"
export LOG_OUTPUT_TO_FILE="${LOG_OUTPUT_TO_FILE:-false}"

# PostgreSQL 使用外部实例；DATABASE_HOST/USER/PASSWORD/DBNAME 必须由 Choreo 环境变量提供。
export DATABASE_PORT="${DATABASE_PORT:-5432}"
export DATABASE_SSLMODE="${DATABASE_SSLMODE:-require}"

# Redis 内置在本容器，仅允许本机访问。启动成功后再覆盖 REDIS_HOST/REDIS_PORT 给 Sub2API 使用。
export REDIS_PASSWORD="${REDIS_PASSWORD:-}"
export REDIS_DB="${REDIS_DB:-0}"
export REDIS_ENABLE_TLS=false
LOCAL_REDIS_HOST="127.0.0.1"
LOCAL_REDIS_PORT="${REDIS_PORT:-6379}"

# Komari agent 是可选监控组件；两个变量都配置时才启动。
export KOMARI_SERVER="${KOMARI_SERVER:-}"
export KOMARI_SECRET="${KOMARI_SECRET:-}"

require_env DATABASE_HOST
require_env DATABASE_USER
require_env DATABASE_PASSWORD
require_env DATABASE_DBNAME

if ! is_valid_port "$SERVER_PORT"; then
    log "Config" "Invalid SERVER_PORT: $SERVER_PORT"
    exit 1
fi

if ! is_valid_port "$DATABASE_PORT"; then
    log "Config" "Invalid DATABASE_PORT: $DATABASE_PORT"
    exit 1
fi

if ! is_valid_port "$LOCAL_REDIS_PORT"; then
    log "Config" "Invalid REDIS_PORT: $LOCAL_REDIS_PORT"
    exit 1
fi

mkdir -p "$DATA_DIR" "$PRICING_DATA_DIR" /tmp/redis "$XDG_CONFIG_HOME" "$XDG_DATA_HOME"

if [ -n "$KOMARI_SERVER" ] && [ -n "$KOMARI_SECRET" ]; then
    log "Komari" "Starting Komari agent"
    /app/komari-agent -e "$KOMARI_SERVER" -t "$KOMARI_SECRET" --disable-auto-update >/dev/null 2>&1 &
else
    log "Komari" "Komari agent is not configured, skipping"
fi

log "Redis" "Starting embedded Redis on ${LOCAL_REDIS_HOST}:${LOCAL_REDIS_PORT}"
if [ -n "$REDIS_PASSWORD" ]; then
    redis-server \
        --bind "$LOCAL_REDIS_HOST" \
        --port "$LOCAL_REDIS_PORT" \
        --dir /tmp/redis \
        --save "" \
        --appendonly no \
        --protected-mode yes \
        --loglevel warning \
        --requirepass "$REDIS_PASSWORD" &
else
    redis-server \
        --bind "$LOCAL_REDIS_HOST" \
        --port "$LOCAL_REDIS_PORT" \
        --dir /tmp/redis \
        --save "" \
        --appendonly no \
        --protected-mode yes \
        --loglevel warning &
fi

redis_ready=0
for _ in 1 2 3 4 5 6 7 8 9 10; do
    if REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h "$LOCAL_REDIS_HOST" -p "$LOCAL_REDIS_PORT" ping >/dev/null 2>&1; then
        redis_ready=1
        break
    fi
    sleep 1
done

if [ "$redis_ready" -ne 1 ]; then
    log "Redis" "Embedded Redis failed to become ready"
    exit 1
fi

export REDIS_HOST="$LOCAL_REDIS_HOST"
export REDIS_PORT="$LOCAL_REDIS_PORT"
log "Redis" "Embedded Redis is ready"

# Choreo 要求 REST 与 WebSocket 使用不同 endpoint；Caddy 在 8081 接收 WS 后转发到 Sub2API 8080。
log "WebSocket" "Starting WebSocket proxy on 0.0.0.0:8081 -> 127.0.0.1:${SERVER_PORT}"
caddy validate --config /app/Caddyfile --adapter caddyfile >/dev/null
caddy run --config /app/Caddyfile --adapter caddyfile &

if [ "${1#-}" != "$1" ]; then
    set -- /app/sub2api "$@"
fi

log "Sub2API" "Starting Sub2API on ${SERVER_HOST}:${SERVER_PORT}"
exec "$@"
