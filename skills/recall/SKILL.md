---
name: recall
description: Rebuild recent working context from history and live state into a short brief. Use for "recall", "where did I leave off".
disable-model-invocation: true
---

# Recall

A specific prior session to resume is the `handoff` playbook instead.

1. Lock scope: window (default 7 days), topic, this project only.
2. Read sources cheaply: `.peystack/` notes and logs, `git log --since`, `gh pr list --author @me --state all`, open branches, then transcripts in `~/.claude/projects/<cwd-slug>/` sorted by `ls -t`. Mine transcripts in a subagent at `std`/`deep`.
3. Check live state of each PR and branch with `git` and `gh`.

Brief: **Capsule** (at most 5 bullets). **Threads** one line each tagged `[merged #N]`, `[open PR #N]`, `[in flight <branch>]`, `[uncommitted]`, `[reverted #N]`, or `[planned]`. **Problems** (at most 5 recurring). **Next move** (one concrete action).
