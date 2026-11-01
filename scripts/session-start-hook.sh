#!/usr/bin/env bash
# SessionStart hook: marathon is on unless ~/.claude/rules/peystack.md says "marathon: off".
input=$(cat)
grep -qiE '^marathon:\s*off' "$HOME/.claude/rules/peystack.md" 2>/dev/null && exit 0
root=$(cd "$(dirname "$0")/.." && pwd)
cwd=$(printf '%s' "$input" | python3 -c 'import sys,json; print(json.load(sys.stdin).get("cwd",""))' 2>/dev/null)
cd "${cwd:-$PWD}" 2>/dev/null || exit 0
if [ -f .peystack/marathon.md ] && ! grep -qE '^(DONE|BLOCKED:)' .peystack/marathon.md && grep -qE '^\s*- \[ \] ' .peystack/marathon.md; then
  bash "$root/scripts/marathon.sh" watch >/dev/null 2>&1
  extra=" An unfinished marathon exists here. Resume it from the first unchecked box in .peystack/marathon.md."
fi
msg="peystack marathon is on. For any task with more than three steps, write the steps as a checklist in .peystack/marathon.md (see $root/skills/marathon/SKILL.md), run \`bash $root/scripts/marathon.sh watch\` once, then do the work in this session, checking boxes as you go. Write DONE on its own line when finished, or BLOCKED: <reason> when you need the user.${extra:-}"
python3 -c 'import json,sys; print(json.dumps({"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":sys.argv[1]}}))' "$msg"
