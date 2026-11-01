---
name: automate-me
description: Capture the user's working style into a personal -mode skill. Use for "automate me".
disable-model-invocation: true
---

# Automate me

1. Gather evidence: the user's corrections and stated preferences in recent transcripts (`~/.claude/projects/`), memory files, and `CLAUDE.md`. Mine transcripts in a subagent.
2. Keep only preferences seen twice or stated outright. Each becomes one imperative line.
3. Write `~/.claude/skills/<name>-mode/SKILL.md` per the `skill-authoring` playbook, under 80 lines. Run it through `/write`.
4. Show it and ask for edits before saving over an existing one.
