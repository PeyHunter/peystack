---
name: interrogate
description: Adversarial review where only findings proven by a run survive. Use for "interrogate", "stress test", "tear this apart".
disable-model-invocation: true
---

# Interrogate

1. **Scope.** What the user names, else `git diff $(git merge-base HEAD main)` plus the working tree. Write the intent in one sentence from the request, commits, and PR.
2. **Adversaries.** Count by tier: 1 / 2 / 4, from the `interrogate reviewers` line, else the parent model. Each gets a worktree with the uncommitted changes copied in. Brief: "Break this change. Prove each finding with a run against real code: a failing test, a repro script, or output showing wrong behavior. Report each with title, command, output, and how it breaks the intent. At most 300 words."
3. **Verify.** Rerun each finding's command yourself. Keep it only if the failure shows and it breaks the intent. Merge findings with one root cause.
4. Report, do not fix.

Output: **Intent**. **Findings** (command, output, why it matters, who found it), or "no verified findings". **Dropped** (count per adversary and why).
