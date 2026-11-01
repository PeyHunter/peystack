# Handoff

## Pause

Only on an explicit pause, going offline, or imminent compaction. "Keep going" is not a pause.

1. Finish or back out of the current atomic step. Start nothing. Stop nested agents.
2. No new push or PR to pause.
3. Commit edits as one `wip:` commit. Note a broken tree in the body.
4. Write a resume note to `.peystack/resume.md` (gitignored): intent, progress, what is verified, state, next steps, key files, gotchas. Point at an existing `/log` trail instead of copying it.

**Reply:** where you are, what is on disk, commits, first action on resume.

## Pickup

The prior trail is authoritative. Do not redo it.

1. Find the trail: `.peystack/resume.md`, a decision log, a pushed branch, or a transcript in `~/.claude/projects/<cwd-slug>/` (this project only). Parse long transcripts in a subagent.
2. Rebuild state: branch, `git log`, diff against base, open todos, decisions.
3. Diff done vs pending and name the resume point.
4. Route the rest to the matching playbook.
5. Verify inherited claims on the real artifact once, at the end.

**Reply:** where the prior agent stopped, what you inherited, the resume point, the outcome.
