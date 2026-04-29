#!/bin/sh

# ==============================
# 环境变量配置与默认值
# ==============================
# Komari agent 配置
KOMARI_SERVER="${KOMARI_SERVER:-}"
KOMARI_SECRET="${KOMARI_SECRET:-}"

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
export DATABASE_PORT="${DATABASE_PORT:-5432}"
export DATABASE_SSLMODE="${DATABASE_SSLMODE:-require}"
LOCAL_REDIS_HOST="127.0.0.1"
LOCAL_REDIS_PORT="${REDIS_PORT:-6379}"
export REDIS_PASSWORD="${REDIS_PASSWORD:-}"
export REDIS_DB="${REDIS_DB:-0}"
export REDIS_ENABLE_TLS="false"

require_env DATABASE_HOST
require_env DATABASE_USER
require_env DATABASE_PASSWORD
require_env DATABASE_DBNAME

# ==============================
# 1. 启动 komari-agent
# ==============================
if [ -n "$KOMARI_SERVER" ] && [ -n "$KOMARI_SECRET" ]; then
    log  "Kmoari" "[Komari] 启动监控..."
    /app/komari-agent -e "$KOMARI_SERVER" -t "$KOMARI_SECRET" --disable-auto-update >/dev/null 2>&1 &
else
    log "Kmoari" "[Komari] 未配置，跳过。"
fi

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

log "WebSocket" "Starting WebSocket proxy on 0.0.0.0:8081 -> 127.0.0.1:${SERVER_PORT}"
caddy validate --config /app/Caddyfile --adapter caddyfile >/dev/null
caddy run --config /app/Caddyfile --adapter caddyfile &

if [ "${1#-}" != "$1" ]; then
    set -- /app/sub2api "$@"
fi

log "Sub2API" "Starting Sub2API on ${SERVER_HOST}:${SERVER_PORT}"
exec "$@"
