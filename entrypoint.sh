#!/bin/bash

echo "[INFO] Starting Transmission as user: $(whoami)"

transmission-daemon \
  --foreground \
  --config-dir="${TRANSMISSION_HOME:-/config}" \
  --download-dir="${TRANSMISSION_DOWNLOAD_DIR:-/downloads/complete}" \
  --incomplete-dir-enabled="${TRANSMISSION_INCOMPLETE_DIR_ENABLED:-true}" \
  --incomplete-dir="${TRANSMISSION_INCOMPLETE_DIR:-/downloads/incomplete}" \
  --watch-dir-enabled="${TRANSMISSION_WATCH_DIR_ENABLED:-false}" \
  --watch-dir="${TRANSMISSION_WATCH_DIR:-/watch}" \
  --rpc-password="${TRANSMISSION_RPC_PASSWORD:-transmission}" \
  --web-ui="${TRANSMISSION_WEB_HOME:-/config/flood-for-transmission}"
