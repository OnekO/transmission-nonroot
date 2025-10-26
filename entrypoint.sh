#!/bin/sh
set -e

CONFIG_DIR="${TRANSMISSION_HOME:-/config}"
SETTINGS_FILE="${CONFIG_DIR}/settings.json"
TEMPLATE_FILE="/defaults/settings.json.template"

# Doing this exports here as envsubst in alpine is limited
export TRANSMISSION_DOWNLOAD_DIR=${TRANSMISSION_DOWNLOAD_DIR:-/downloads/complete}
export TRANSMISSION_INCOMPLETE_DIR_ENABLED=${TRANSMISSION_INCOMPLETE_DIR_ENABLED:-true}
export TRANSMISSION_INCOMPLETE_DIR=${TRANSMISSION_INCOMPLETE_DIR:-/downloads/incomplete}
export TRANSMISSION_WATCH_DIR_ENABLED=${TRANSMISSION_WATCH_DIR_ENABLED:-false}
export TRANSMISSION_WATCH_DIR=${TRANSMISSION_WATCH_DIR:-/watch}
export TRANSMISSION_RPC_PASSWORD=${TRANSMISSION_RPC_PASSWORD:-transmission}
export TRANSMISSION_RPC_AUTH=${TRANSMISSION_RPC_AUTH:-true}
export TRANSMISSION_RPC_USERNAME=${TRANSMISSION_RPC_USERNAME:-admin}
export TRANSMISSION_RPC_PORT=${TRANSMISSION_RPC_PORT:-9091}
export TRANSMISSION_PEER_PORT=${TRANSMISSION_PEER_PORT:-51413}
export TRANSMISSION_WEB_HOME=${TRANSMISSION_WEB_HOME:-/config/flood-for-transmission}

if [ ! -f "$SETTINGS_FILE" ]; then
  echo "[INFO] Generating settings.json"
  mkdir -p "$CONFIG_DIR"
  envsubst < "$TEMPLATE_FILE" > "$SETTINGS_FILE"
fi
echo "[INFO] Starting transmission-daemon..."
exec transmission-daemon --foreground --config-dir "$CONFIG_DIR"
