---
name: reflect
description: Mine this conversation for durable lessons and route each to a skill edit. Use for /reflect.
disable-model-invocation: true
---

# Reflect

Skip trivial or off-topic sessions. One-offs are not lessons.

1. Review the session yourself through three lenses: **judgment** (where a call was wrong or slow), **tooling** (commands that failed, missing scripts), **divergent** (what a different approach would have saved). At `deep`, spawn one reviewer per lens with the transcript path (`~/.claude/projects/<cwd-slug>/<session>.jsonl`), each returning at most 200 words.
2. For each lesson: evidence from the session, the target skill file, the exact edit. Classify **Accepted**, **Rejected** (with reason), or **Backlog**.
3. A lesson a lint, script, or check would enforce better moves to Backlog as a `/correct` candidate.
4. Show the list and wait for approval. Never edit the installed plugin cache. Edit the user's peystack checkout or `~/.claude/skills/`.
5. Apply approved edits. Run `scripts/measure.sh` to confirm the token cost did not balloon.

Reply: edits applied (path and one line), backlog, dropped.
