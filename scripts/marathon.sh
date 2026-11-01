#!/usr/bin/env bash
# Runs .peystack/marathon.md headless and resumes after usage limits reset.
# Usage (from the project root): marathon.sh start | status | log | stop | run
set -uo pipefail
dir=.peystack; q=$dir/marathon.md; log=$dir/marathon.log; pidf=$dir/marathon.pid; sidf=$dir/marathon.session; statef=$dir/marathon.state
mode=${PEY_PERMISSION_MODE:-auto}
self=$(cd "$(dirname "$0")" && pwd)/$(basename "$0")

running() { [ -f "$pidf" ] && kill -0 "$(cat "$pidf")" 2>/dev/null; }
open_work() { [ -f "$q" ] && ! grep -qE '^(DONE|BLOCKED:)' "$q" && grep -qE '^\s*- \[ \] ' "$q"; }
say() { echo "$(date '+%F %T') $*" | tee -a "$log" >/dev/null; echo "$*" > "$statef"; }

wait_seconds() { # $1 = claude output; prints seconds to sleep until the limit resets
  python3 - "$1" <<'PY'
import re,sys,time,datetime,subprocess
t=sys.argv[1]; now=time.time()
m=re.search(r'\|(\d{10})\b',t)
if m: print(max(60,int(m.group(1))-int(now)+60)); sys.exit()
m=re.search(r'resets?\s+(?:at\s+)?([0-9]{1,2}(?::[0-9]{2})?\s*(?:[ap]m)?)',t,re.I)
if m:
  r=subprocess.run(['date','-d',m.group(1),'+%s'],capture_output=True,text=True)
  if r.returncode==0 and r.stdout.strip():
    s=int(r.stdout)
    if s<=now: s+=86400
    print(int(s-now)+60); sys.exit()
print(1800)
PY
}

run() {
  mkdir -p "$dir"
  local first="Run /peystack:pey-mode, then /peystack:marathon. Work the queue in .peystack/marathon.md until it holds DONE or BLOCKED."
  local again="Continue the marathon in .peystack/marathon.md from the first unchecked box. Read .peystack/resume.md if it exists."
  while open_work; do
    say "working"
    if [ -s "$sidf" ]; then out=$(claude -p --resume "$(cat "$sidf")" --permission-mode "$mode" --output-format json "$again" 2>&1)
    else out=$(claude -p --permission-mode "$mode" --output-format json "$first" 2>&1); fi
    echo "$out" | tail -c 2000 >> "$log"
    sid=$(printf '%s' "$out" | python3 -c 'import sys,json
try: print(json.loads(sys.stdin.read()).get("session_id",""))
except Exception: pass' 2>/dev/null)
    [ -n "$sid" ] && echo "$sid" > "$sidf"
    if printf '%s' "$out" | grep -qiE 'usage limit|limit reached|rate.?limit|resets? (at )?[0-9]|429|overloaded'; then
      secs=$(wait_seconds "$out")
      say "waiting for usage limit reset until $(date -d "+$secs sec" '+%F %T')"
      sleep "$secs"
    else
      sleep 5
    fi
  done
  say "finished: $(grep -m1 -E '^(DONE|BLOCKED:)' "$q" 2>/dev/null || echo 'no open boxes')"
}

case "${1:-}" in
  start)
    [ -f "$q" ] || { echo "No $q here. Run /peystack:marathon first, from the project root."; exit 1; }
    running && { echo "Already running (pid $(cat "$pidf"))."; exit 0; }
    mkdir -p "$dir"; nohup bash "$self" run >/dev/null 2>&1 & echo $! > "$pidf"
    echo "Marathon started. Check it with: bash $self status" ;;
  status)
    running && echo "Running (pid $(cat "$pidf"))." || echo "Not running."
    [ -f "$statef" ] && echo "State: $(cat "$statef")"
    [ -f "$q" ] && echo "Boxes: $(grep -cE '^\s*- \[x\]' "$q") done, $(grep -cE '^\s*- \[ \]' "$q") open." ;;
  log) tail -n 40 "$log" 2>/dev/null || echo "No log yet." ;;
  stop)
    if running; then pkill -P "$(cat "$pidf")" 2>/dev/null; kill "$(cat "$pidf")"; echo "Stopped."; else echo "Not running."; fi
    rm -f "$pidf" ;;
  run) run ;;
  *) echo "Usage: marathon.sh start | status | log | stop" ;;
esac
