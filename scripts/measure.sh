#!/usr/bin/env bash
# Estimates token cost (bytes/4) of a skill pack.
# Usage: measure.sh [peystack-dir] [pstack-dir]
set -euo pipefail
pey=${1:-$(cd "$(dirname "$0")/.." && pwd)}
pst=${2:-$(ls -d ~/.claude/plugins/cache/*/pstack/* 2>/dev/null | sort -V | tail -1 || true)}
tok() { cat "$@" 2>/dev/null | wc -c | awk '{printf "%d", $1/4}'; }
listing() { # descriptions of model-invocable skills: paid every session
  for f in "$1"/skills/*/SKILL.md; do
    grep -q '^disable-model-invocation: true' "$f" && continue
    awk '/^description:/{sub(/^description: */,""); print; exit}' "$f"
  done | wc -c | awk '{printf "%d", $1/4}'
}
row() { printf '%-34s %8s %8s\n' "$1" "$2" "$3"; }
row "tokens (approx)" "peystack" "pstack"
if [ -n "$pst" ]; then
  row "always-on skill listing" "$(listing "$pey")" "$(listing "$pst")"
  row "enter mode (core file)" "$(tok "$pey"/skills/pey-mode/SKILL.md)" "$(tok "$pst"/skills/poteto-mode/SKILL.md "$pst"/docs/harness/claude-code.md)"
  row "all principles" "$(tok "$pey"/skills/pey-mode/principles.md)" "$(tok "$pst"/skills/principle-*/SKILL.md)"
  row "all playbooks" "$(tok "$pey"/skills/pey-mode/playbooks/*.md)" "$(tok "$pst"/skills/poteto-mode/playbooks/*.md)"
  row "delegate agent prompt" "$(tok "$pey"/agents/pey-agent.md)" "$(( $(tok "$pst"/agents/poteto-agent.md) + $(tok "$pst"/skills/poteto-mode/SKILL.md) ))"
  row "all SKILL.md files" "$(tok "$pey"/skills/*/SKILL.md)" "$(tok "$pst"/skills/*/SKILL.md)"
else
  row "core file" "$(tok "$pey"/skills/pey-mode/SKILL.md)" "-"
  row "all playbooks" "$(tok "$pey"/skills/pey-mode/playbooks/*.md)" "-"
  row "all SKILL.md files" "$(tok "$pey"/skills/*/SKILL.md)" "-"
fi
