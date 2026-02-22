#!/bin/sh
echo "=== OPENCLAW GATEWAY TOKEN ==="
python3 -c "
import json, os
config_path = os.path.expanduser('~/.openclaw/openclaw.json')
try:
    with open(config_path) as f:
        d = json.load(f)
    token = d.get('gateway', {}).get('auth', {}).get('token', 'NOT FOUND')
    print('TOKEN:', token)
except Exception as e:
    print('Config not found:', e)
" 2>&1 || echo "python3 not available"
echo "=============================="
exec node openclaw.mjs gateway --allow-unconfigured --bind lan --port 18789
