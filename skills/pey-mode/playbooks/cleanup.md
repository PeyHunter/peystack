# Cleanup

This deletes user state with no code review, so the gates are the review.

1. Record `df -h /`. List worktrees with `git worktree list --porcelain`, never hand-typed paths. For each, get size, age, merged state (`git branch --merged origin/HEAD`), uncommitted count, and PR state.
2. The classification is advice. Ask which worktrees and sessions are in use and cross-check.
3. Uncommitted tracked edits pause for a decision with the diff shown. Untracked scratch is safe, but name the files.
4. Prune the confirmed set: `git worktree remove --force <path>`, then `git worktree prune`. Branches survive.
5. Next wins: package caches (npm, pnpm, uv, pip, cargo), docker (`docker system df` first), simulators on macOS. Clear only caches the user has not asked to keep.

**Reply:** `df` before and after, what was pruned, a one-line reason for each kept item.
