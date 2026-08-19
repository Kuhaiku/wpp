#!/bin/sh
set -eu

: "${EVOLUTION_API_URL:=}"
: "${EVOLUTION_API_KEY:=}"
: "${EVOLUTION_INSTANCE:=}"
: "${POLLING_MS:=4000}"
: "${CHATS_TAKE:=500}"
: "${MESSAGES_TAKE:=500}"

escape_js() {
  printf '%s' "$1" | sed \
    -e 's/\\/\\\\/g' \
    -e 's/"/\\"/g' \
    -e ':a;N;$!ba;s/\n/\\n/g'
}

cat > /usr/share/nginx/html/config.js <<EOF
window.__APP_CONFIG__ = {
  baseUrl: "$(escape_js "$EVOLUTION_API_URL")",
  apiKey: "$(escape_js "$EVOLUTION_API_KEY")",
  instance: "$(escape_js "$EVOLUTION_INSTANCE")",
  pollingMs: Number("$POLLING_MS") || 4000,
  chatsTake: Number("$CHATS_TAKE") || 500,
  messagesTake: Number("$MESSAGES_TAKE") || 500
};
EOF

exec nginx -g 'daemon off;'
