---
name: log
description: Keep a TSV decision log for long or unattended work. Use for /log.
disable-model-invocation: true
---

# Log

One TSV, one row per decision. Default path `.peystack/decisions.tsv` (gitignored). Commit it only when a reviewer needs the trail.

Append with `bash <peystack>/scripts/log.sh <file> <phase> <decision> <why> <evidence> <result>`. It stamps the time and writes the header.

Columns: `ts`, `phase`, `decision` (one line), `why` (plain words), `evidence` (SHA, PR, `file:line`, or artifact path, never prose), `result` (`tests green`, `reverted`, `INCONCLUSIVE`, `open`).

Log forks, finished units with their check, reverts and their trigger, blockers, and gate fixes. Not every action. Loops log one row per iteration. A new session starts with a `start` row naming what it resumes.

Append-only. A wrong call gets a new row that supersedes it.
