---
name: marathon
description: Use all the time the plan allows. Keep working through a queue, and resume by itself after usage limits or a closed terminal. On by default. Use for /marathon.
disable-model-invocation: true
---

# Marathon

On by default for every session (SessionStart hook). Turn off with `marathon: off` in `~/.claude/rules/peystack.md`.

Three layers keep work going:
1. **Stop hook.** While `.peystack/marathon.md` has an unchecked box, a session cannot end.
2. **Claude Code itself.** An open terminal already waits out a usage limit and continues at the reset time.
3. **Watcher** (`scripts/marathon.sh watch`). It checks every 5 minutes. If the terminal closed, or it stayed stuck 15 minutes past a reset, it resumes the same session headless and keeps going until the queue is done, waiting out further limits.

## Any task over three steps

1. Write `.peystack/marathon.md` and add `.peystack/` to `.gitignore`:

```markdown
# Marathon: <goal in one line>

Done when: <checkable predicate>

- [ ] <unit 1> . evidence: <command or file>
- [ ] <unit 2> . evidence: <command or file>
```

2. Run `bash <peystack>/scripts/marathon.sh watch` once. It returns at once and runs in the background.
3. Do the work in this session with the matching pey-mode playbook. Check a box only when its evidence exists. Commit after each box.
4. When the boxes run out but the goal has more value to give (tests, parked follow-ups, cleanup), add boxes and keep going.
5. Write `DONE` on its own line when the predicate holds, or `BLOCKED: <reason>` when only the user can unblock it. Irreversible actions still pause per pey-mode Autonomy.

## Fully unattended

When the user is leaving, run `bash <peystack>/scripts/marathon.sh start` instead and end your turn, so only the headless runner writes.

Commands for the user, from the project folder:
- `bash ~/peystack/scripts/marathon.sh status`
- `bash ~/peystack/scripts/marathon.sh log`
- `bash ~/peystack/scripts/marathon.sh stop`
