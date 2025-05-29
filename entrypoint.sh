#!/bin/sh

set -e

CONFIG_DIR="${TRANSMISSION_HOME:-/config}"
SETTINGS_FILE="${CONFIG_DIR}/settings.json"

# Si no existe settings.json, lo creamos
if [ ! -f "$SETTINGS_FILE" ]; then
  echo "[INFO] Generating default settings.json"

  cat > "$SETTINGS_FILE" <<EOF
{
  "download-dir": "${TRANSMISSION_DOWNLOAD_DIR:-/downloads/complete}",
  "incomplete-dir-enabled": $(echo "${TRANSMISSION_INCOMPLETE_DIR_ENABLED:-true}" | tr '[:upper:]' '[:lower:]'),
  "incomplete-dir": "${TRANSMISSION_INCOMPLETE_DIR:-/downloads/incomplete}",
  "watch-dir-enabled": $(echo "${TRANSMISSION_WATCH_DIR_ENABLED:-false}" | tr '[:upper:]' '[:lower:]'),
  "watch-dir": "${TRANSMISSION_WATCH_DIR:-/watch}",
  "rpc-password": "${TRANSMISSION_RPC_PASSWORD:-transmission}",
  "rpc-authentication-required": true,
  "rpc-username": "${TRANSMISSION_RPC_USERNAME:-admin}",
  "rpc-whitelist-enabled": false,
  "rpc-port": 9091,
  "peer-port": 51413,
  "umask": 2,
  "web-ui": "${TRANSMISSION_WEB_HOME:-/config/flood-for-transmission}"
}
EOF
fi

echo "[INFO] Starting transmission-daemon..."

exec transmission-daemon \
  --foreground \
  --config-dir "$CONFIG_DIR"
