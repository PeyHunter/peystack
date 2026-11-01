#!/usr/bin/env bash
# Usage: log.sh <file> <phase> <decision> <why> <evidence> <result>
set -euo pipefail
[ $# -eq 6 ] || { echo "usage: log.sh <file> <phase> <decision> <why> <evidence> <result>" >&2; exit 2; }
file=$1; shift
mkdir -p "$(dirname "$file")"
[ -s "$file" ] || printf 'ts\tphase\tdecision\twhy\tevidence\tresult\n' > "$file"
clean() { local v=${1//$'\t'/ }; v=${v//$'\n'/ }; [[ $v =~ ^[=+@-] ]] && v="'$v"; printf '%s' "$v"; }
row=$(date -u +%Y-%m-%dT%H:%M:%SZ)
for c in "$@"; do row+=$'\t'$(clean "$c"); done
printf '%s\n' "$row" >> "$file"
