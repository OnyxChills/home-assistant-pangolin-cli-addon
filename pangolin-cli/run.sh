#!/usr/bin/env bashio
set -e

echo "🔹 Starting Pangolin CLI inside Home Assistant OS..."

CONFIG_PATH="/data/options.json"

if [[ ! -f "$CONFIG_PATH" ]]; then
    echo "❌ ERROR: Configuration file not found at $CONFIG_PATH!"
    exit 1
fi

PANGOLIN_ENDPOINT=$(jq -r '.PANGOLIN_ENDPOINT' "$CONFIG_PATH")
NEWT_ID=$(jq -r '.NEWT_ID' "$CONFIG_PATH")
NEWT_SECRET=$(jq -r '.NEWT_SECRET' "$CONFIG_PATH")

if [[ -z "$PANGOLIN_ENDPOINT" || -z "$NEWT_ID" || -z "$NEWT_SECRET" || "$PANGOLIN_ENDPOINT" == "null" ]]; then
    echo "❌ ERROR: Missing required configuration values!"
    exit 1
fi

echo "✅ Configuration Loaded:"
echo "  PANGOLIN_ENDPOINT=$PANGOLIN_ENDPOINT"
echo "  NEWT_ID=$NEWT_ID"
#echo "  NEWT_SECRET=$NEWT_SECRET"
echo "  NEWT_SECRET=********"

# 🔁 Auto-reconnect loop
while true; do
    echo "🔹 Starting Pangolin CLI..."
    # Custom variables are already exported above
    export PANGOLIN_ENDPOINT="$PANGOLIN_ENDPOINT"
    export NEWT_ID="$NEWT_ID"
    export NEWT_SECRET="$NEWT_SECRET"
    pangolin up --id "$NEWT_ID" --secret "$NEWT_SECRET" --endpoint "$PANGOLIN_ENDPOINT" --attach

    echo "⚠️ Pangolin CLI stopped! Waiting 5 second before reconnecting..."
    sleep 5
done
