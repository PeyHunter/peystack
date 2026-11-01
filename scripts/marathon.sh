#!/usr/bin/env bash
# Runs .peystack/marathon.md headless and resumes after usage limits reset.
# Usage (from the project root): marathon.sh start | watch | status | log | stop
#   start  run the queue headless now
#   watch  guard an interactive session; take over only if it closes or stays stuck after a usage limit
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

transcript() { # newest transcript for this project
  local slug; slug=$(pwd | sed 's#[/.]#-#g')
  ls -t "$HOME/.claude/projects/$slug"/*.jsonl 2>/dev/null | head -1
}
interactive_alive() { # a claude process (not ours) with this cwd
  local p me; me=$(pwd -P)
  for p in $(pgrep -x claude 2>/dev/null); do
    [ "$(readlink /proc/$p/cwd 2>/dev/null)" = "$me" ] || continue
    tr '\0' ' ' < /proc/$p/cmdline | grep -q -- ' -p ' && continue
    return 0
  done; return 1
}
stuck_after_limit() { # last note is a usage limit, and its reset passed 15+ min ago with no activity
  python3 - "$1" <<'PY'
import json,re,sys,time,datetime,subprocess
lines=open(sys.argv[1],errors='ignore').read().splitlines()[-60:]
note=None
for l in lines:
    if re.search(r'usage limit has reset',l,re.I): note=None
    elif re.search(r'limit reached',l,re.I) and '"subtype"' in l: note=l
if not note: sys.exit(1)
try: d=json.loads(note); t0=datetime.datetime.fromisoformat(d["timestamp"].replace("Z","+00:00")).timestamp(); txt=d.get("content","")
except Exception: sys.exit(1)
m=re.search(r'\|(\d{10})',txt)
if m: reset=int(m.group(1))
else:
    m=re.search(r'at\s+([0-9]{1,2}(?::[0-9]{2})?\s*[ap]m)',txt,re.I)
    if not m: sys.exit(1)
    day=time.strftime('%Y-%m-%d',time.localtime(t0))
    r=subprocess.run(['date','-d',f'{day} {m.group(1)}','+%s'],capture_output=True,text=True)
    if r.returncode: sys.exit(1)
    reset=int(r.stdout)
    if reset<=t0: reset+=86400
sys.exit(0 if time.time()>reset+900 else 1)
PY
}

watch() {
  mkdir -p "$dir"
  while open_work; do
    tf=$(transcript)
    if [ -n "$tf" ] && { ! interactive_alive || stuck_after_limit "$tf"; }; then
      basename "$tf" .jsonl > "$sidf"
      say "interactive session gone or stuck; taking over $(cat "$sidf")"
      run; return
    fi
    say "watching"
    sleep 300
  done
  say "finished: $(grep -m1 -E '^(DONE|BLOCKED:)' "$q" 2>/dev/null || echo 'no open boxes')"
}

case "${1:-}" in
  start|watch)
    [ -f "$q" ] || { echo "No $q here. Run /peystack:marathon first, from the project root."; exit 1; }
    running && { echo "Already running (pid $(cat "$pidf"))."; exit 0; }
    mkdir -p "$dir"; nohup bash "$self" "$([ "$1" = start ] && echo run || echo _watch)" >/dev/null 2>&1 & echo $! > "$pidf"
    echo "Marathon $1 started. Check it with: bash $self status" ;;
  status)
    running && echo "Running (pid $(cat "$pidf"))." || echo "Not running."
    [ -f "$statef" ] && echo "State: $(cat "$statef")"
    [ -f "$q" ] && echo "Boxes: $(grep -cE '^\s*- \[x\]' "$q") done, $(grep -cE '^\s*- \[ \]' "$q") open." ;;
  log) tail -n 40 "$log" 2>/dev/null || echo "No log yet." ;;
  stop)
    if running; then pkill -P "$(cat "$pidf")" 2>/dev/null; kill "$(cat "$pidf")"; echo "Stopped."; else echo "Not running."; fi
    rm -f "$pidf" ;;
  run) run ;;
  _watch) watch ;;
  *) echo "Usage: marathon.sh start | watch | status | log | stop" ;;
esac
