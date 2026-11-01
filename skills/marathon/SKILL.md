---
name: marathon
description: Use all the time the plan allows. Keep working through a queue, and resume by itself after usage limits reset. Use for /marathon.
disable-model-invocation: true
---

# Marathon

The work queue is `.peystack/marathon.md` in the project. While it has an unchecked box, the peystack Stop hook refuses to let a session end. `scripts/marathon.sh` runs the queue headless and, when a usage limit hits, sleeps until the reset time and resumes the same session.

## Start

1. Write `.peystack/marathon.md`:

```markdown
# Marathon: <goal in one line>

Done when: <checkable predicate>

- [ ] <unit 1> . evidence: <command or file>
- [ ] <unit 2> . evidence: <command or file>
```

Order units smallest-verifiable first. Add `.peystack/` to `.gitignore`.

2. Hand off to the runner so limits cannot end the run. Run `bash <peystack>/scripts/marathon.sh start` from the project root, then tell the user the three commands below and stop your own turn. Do not work the queue in this session too, because two writers would collide.

Commands for the user, each one short:
- `bash ~/peystack/scripts/marathon.sh status` shows progress and whether it is waiting on a limit.
- `bash ~/peystack/scripts/marathon.sh log` shows the last lines of output.
- `bash ~/peystack/scripts/marathon.sh stop` ends the run.

## Inside the run

- Work the first unchecked box with the matching pey-mode playbook. Check it only when its evidence exists.
- Commit after each box. Append a `/log` row.
- When the queue empties but time remains, add the next most valuable units toward the goal (tests, cleanup, follow-ups you parked). Stop adding only when the predicate holds and nothing worth doing remains, then write `DONE` on its own line.
- A real blocker that needs the human: write `BLOCKED: <reason>` on its own line. The hook then lets the session end, and the runner exits.
- Irreversible actions (deploys, force-push to shared branches, data deletion) still pause per pey-mode Autonomy.
