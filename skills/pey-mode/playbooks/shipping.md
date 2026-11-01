# Shipping

Land only what an independent verifier passed, bottom-up.

1. One verifier per PR, never its author. It runs the change as a user would, parent vs head, and posts `PASS`, `PASS+NOTES`, or `FAIL` on the PR. Green CI and bot approvals are not verdicts.
2. The run is the contiguous `PASS` chain from the lowest unmerged PR. The first unverified PR is the ceiling.
3. Before trusting an old verdict, compare `git patch-id` at the verdict SHA with the head. Changed patches need fresh checks.
4. Merge the lowest PR (`gh pr merge <n> --squash`). Read it back (`gh pr view <n> --json state,mergedAt,baseRefName`), since queued is not merged. Retarget the next PR to trunk, rebase it onto the merge, push with `--force-with-lease`, wait for green, merge if its verdict survives.
5. Touch no other branch while landing. If a merge stalls, find out why before changing anything.
6. Stop at the ceiling. More needs new verdicts.

**Reply:** the run and ceiling, each verdict and who gave it, what landed and how you confirmed it, what the next gap needs.
