#!/bin/sh
echo "=== Starting OpenClaw Gateway ==="

# Start gateway in background (no exec, so we can run other commands)
node openclaw.mjs gateway --allow-unconfigured --bind lan --port 18789 &
GATEWAY_PID=$!
echo "Gateway PID: $GATEWAY_PID"

# Auto-approve device pairing requests loop
# Runs every 15s so any browser connecting gets approved quickly
(
    sleep 12
    echo "=== Auto-approve loop started ==="
    while kill -0 $GATEWAY_PID 2>/dev/null; do
        node openclaw.mjs devices approve --latest 2>/dev/null && echo "[auto-approve] Device approved!" || true
        sleep 15
    done
) &

# Wait for gateway to exit (keeps container alive)
wait $GATEWAY_PID
