#!/bin/sh
set -e

CONFIG_DIR="${TRANSMISSION_HOME:-/config}"
SETTINGS_FILE="${CONFIG_DIR}/settings.json"
TEMPLATE_FILE="/defaults/settings.json.template"

if [ ! -f "$SETTINGS_FILE" ]; then
  echo "[INFO] Generating settings.json"
  mkdir -p "$CONFIG_DIR"
  envsubst < "$TEMPLATE_FILE" > "$SETTINGS_FILE"
fi

echo "[INFO] Starting transmission-daemon..."
exec transmission-daemon \
  --foreground \
  --config-dir "$CONFIG_DIR"
