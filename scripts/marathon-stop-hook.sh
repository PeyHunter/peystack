#!/usr/bin/env bash
# Stop hook: block the session from ending while .peystack/marathon.md has unchecked work.
input=$(cat)
cwd=$(printf '%s' "$input" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("cwd",""))' 2>/dev/null)
q="${cwd:-$PWD}/.peystack/marathon.md"
[ -f "$q" ] || exit 0
grep -qE '^(DONE|BLOCKED:)' "$q" && exit 0
next=$(grep -m1 -E '^\s*- \[ \] ' "$q" | sed -E 's/^\s*- \[ \] //')
[ -n "$next" ] || exit 0
reason="Marathon is still running. Next unchecked box in .peystack/marathon.md: $next. Keep working. Write DONE or BLOCKED: <reason> on its own line in that file to end."
python3 -c 'import json,sys; print(json.dumps({"decision":"block","reason":sys.argv[1]}))' "$reason"
