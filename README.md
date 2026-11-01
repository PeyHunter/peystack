# peystack

Token-light agent workflows for Claude Code. peystack keeps pstack's features (a working mode, playbooks, principles, and multi-agent review skills) and cuts the tokens they cost.

## Install

In Claude Code:

```
/plugin marketplace add PeyHunter/peystack
/plugin install peystack@peystack
```

Then, once:

```
/peystack:setup-peystack
```

## Enter pey-mode

```
/peystack:pey-mode
```

Leave it with "pey-mode off". Change depth mid-task with "tier lite", "tier std", or "tier deep".

## Marathon: use all your plan's time

`/peystack:marathon` writes a work queue to `.peystack/marathon.md` and starts a runner in the background. A Stop hook keeps Claude working while the queue has unchecked boxes. When a usage limit hits, the runner reads the reset time, sleeps until then, and resumes the same session. pey-mode sends every long or unattended task through it.

Three short commands, run from the project folder:

```
bash ~/peystack/scripts/marathon.sh status
bash ~/peystack/scripts/marathon.sh log
bash ~/peystack/scripts/marathon.sh stop
```

The run ends when Claude writes `DONE` (goal met) or `BLOCKED: <reason>` (needs you) in the queue file. The runner uses `--permission-mode auto`. Set `PEY_PERMISSION_MODE` to change it.

## Where the tokens went

Measured with `scripts/measure.sh` (bytes / 4, approximate) against pstack 0.15.36.

| Cost | peystack | pstack |
|---|---|---|
| Always-on skill listing | 0 | 69 |
| Enter the mode | 1.3k | 6.9k |
| All principles | 1.0k | 8.4k |
| All playbooks | 5.3k | 19.1k |
| Each delegate's startup read | 0.2k | 5.8k |
| Every SKILL.md | 7.3k | 56.9k |

The bigger savings are at runtime, not in file size:

- **Budget tiers.** `lite` (default) runs inline and fans out only for truly parallel work. `std` caps fan-out at 3 with one independent verifier. `deep` restores pstack-scale panels (up to 10 lanes, cross-family judges). pstack runs panels by default.
- **Principles inline.** One line each in the core file. pstack requires reading each principle's leaf file before citing it.
- **No adapter.** peystack uses Claude Code names directly. pstack loads a Cursor-to-Claude mapping file each session.
- **Lean delegates.** `pey-agent` carries its rules in a 200-token prompt. pstack's delegate rereads the full 22 KB mode file on every spawn.
- **Capped reports.** Subagents return at most 200 words as `PASS`, `ISSUES`, or `BLOCKED` with pointers.
- **Read once.** Files load only when a rule points at them, once per session, by range when possible.

## Playbooks

pey-mode matches the task to one playbook and loads only that file.

| Task | Playbook |
|---|---|
| Read-only question | `investigation` |
| Defect | `bug-fix` |
| New behavior | `feature` |
| Same behavior, new structure | `refactoring` |
| One-off slowness | `perf` |
| Push one metric over many iterations | `hillclimb` |
| Live symptom or captured profile | `forensics` |
| Throwaway to decide a design | `prototype` |
| Pixel-exact UI match | `visual-parity` |
| Test a skill change on agents | `eval` |
| Write a SKILL.md | `skill-authoring` |
| Run until a predicate holds | `autonomous-run` |
| Multi-phase or multi-PR plan | `plan` |
| PR queue, verified, merge optional | `autopilot` |
| Multi-day program | `orchestrate` |
| Get PRs green | `babysit` |
| Land a verified stack | `shipping` |
| Pause or resume | `handoff` |
| Free disk, prune worktrees | `cleanup` |
| Open a PR (end of every code playbook) | `pr` |

## Skills

Type each as `/peystack:<name>`.

| Skill | Does |
|---|---|
| `pey-mode` | Enter the mode |
| `how`, `why`, `teach` | Explain code, its history, or teach it |
| `architect`, `arena` | Sketch shapes first, or race candidates and graft |
| `swarm` | Parallel coverage, races, verification lanes |
| `interrogate`, `blast-radius` | Adversarial review, breakage beyond the diff |
| `figure-it-out` | Design a bespoke playbook |
| `write`, `decomment` | Prose rules, comment stripping |
| `bench`, `tdd`, `ts` | Perf vetting, red-green, TypeScript rules |
| `log` | Decision trail TSV |
| `marathon` | Use all available time, resume after limits |
| `ketchup`, `recall`, `plain`, `sharpen` | Catch up, rebuild context, plain restate, deepen a prompt |
| `reflect`, `correct`, `automate-me` | Learn from sessions, make mistakes impossible, capture your style |
| `verify-kit` | Create or maintain verification and formal-verification skills |
| `setup-peystack`, `pey-help` | Configure, get help |

## Mapping from pstack

| pstack | peystack |
|---|---|
| `poteto-mode` + 24 `principle-*` skills | `pey-mode` + `principles.md` |
| `poteto-agent` | `pey-agent` |
| `unslop` + `technical-writing` | `write` |
| `bro` + `in-your-own-words` | `plain` |
| `show-me-your-work` | `log` |
| `benchmark-checklist` | `bench` |
| `no-comments` | `decomment` (same `comment-sicko` agent) |
| `typescript-best-practices` | `ts` |
| `create-/maintain-verification-skill`, `create-/maintain-formal-verification-skill`, `statechart` | `verify-kit` |
| `runtime-` + `trace-forensics` | `forensics` |
| `autopilot-full` + `autopilot-stack` | `autopilot` (`stack` default, `merge` on request) |
| `session-pickup` + `pause-safely` | `handoff` |
| `setup-pstack` | `setup-peystack` |
| `poteto-help` | `pey-help` |

Left out on purpose. `make-bot-ui` (tied to Grok bots). `ketchup-video` (`ketchup` covers the catch-up). The `watch-pr` TypeScript watcher (babysit uses `gh pr checks --watch`). The `statechart` TLA+ toolchain and its 5 MB test corpus (`verify-kit formal` uses TLC and Mermaid directly).

## Scripts

- `scripts/measure.sh` prints the token table above.
- `scripts/log.sh` appends a row to a decision log.
- `scripts/check-plan.sh` lints a plan from the `plan` playbook.
- `scripts/marathon.sh` runs a marathon queue and waits out usage limits.
- `scripts/marathon-stop-hook.sh` is the Stop hook that keeps a marathon going.

## Credit

Derived from [pstack](https://github.com/cursor/plugins/tree/main/pstack) by Lauren Tan, MIT.
