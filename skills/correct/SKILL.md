---
name: correct
description: Make repeated agent mistakes impossible with architecture, types, lints, or tests. Use for /correct.
disable-model-invocation: true
---

# Correct

1. Find mistake classes in recent commits, reverts, review comments, and agent instruction files. A class needs two occurrences.
2. Fix each at the highest level that works: architecture (one owner, one way, delete the old way) > types (bad state cannot compile) > lint or CI check whose error names the fix > behavior test > docs last.
3. One commit per class. Prove each new check fails on a real past mistake. Same command locally and in CI. Exceptions go on the line with a reason and an expiry.
4. Keep a rule table in `CLAUDE.md`: rule, what enforces it.

Reply: each class with evidence, the level chosen, why a higher level would not work.
