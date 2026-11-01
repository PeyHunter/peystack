#!/usr/bin/env bash
# Lints a plan written with the pey-mode plan playbook. Prints one line per problem; exit 1 if any.
set -uo pipefail
plan=${1:?usage: check-plan.sh <plan.md>}
fail=0
say() { echo "$plan: $1"; fail=1; }
grep -q '^## How to read this' "$plan" || say "missing '## How to read this'"
grep -qE 'playbooks/(autopilot|orchestrate)\.md' "$plan" || say "no execution playbook named"
prs=$(grep -c '^## PR ' "$plan"); [ "$prs" -gt 0 ] || say "no '## PR' sections"
rules=$(grep -c 'Tests alone are not verification' "$plan")
[ "$rules" -ge "$prs" ] || say "verification rule appears $rules times for $prs PRs"
for box in 'Live:' 'Regression lane' 'Unit:'; do
  n=$(grep -c -- "- \[.\] $box" "$plan"); [ "$n" -ge "$prs" ] || say "'$box' box in $n of $prs PRs"
done
grep -qE '\[ \] [^.]*$' "$plan" && grep -nE '^\s*- \[ \] ' "$plan" | grep -vE 'evidence:|Unit:|Live:|Regression|Perf:' | sed "s|^|$plan: box without evidence: |" && fail=1
grep -n $'—' "$plan" | sed "s|^|$plan: long dash: |" | grep . && fail=1
[ $fail -eq 0 ] && echo "$plan: ok"
exit $fail
