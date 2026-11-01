---
name: decomment
description: Strip needless comments from a diff with the comment-sicko agent. Use for /decomment, before review.
disable-model-invocation: true
---

# Decomment

1. Spawn `subagent_type: "peystack:comment-sicko"` with the scope (given files, else the diff against main).
2. Check its edits. Reject any change to application logic, any deleted comment that fit an exception, any wrong `MUST KILL`.
3. Fix trivial `MUST KILL` items yourself (rename, extract, type). Shape-changing ones get one `/architect` sketch, then stop and report.
4. For "do not remove" style constraints, offer a cheap enforcement (type, test, lint) instead of prose.

Report: deletions, restored comments, fixes, open `MUST KILL` items.
