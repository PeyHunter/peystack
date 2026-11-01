# Plan

The plan is the deliverable. Do not implement.

1. One or two files with an obvious approach need no plan. Say so and stop.
2. Settle open empirical questions with `prototype` first. Ask the user only taste calls, with options.
3. Explore with subagents that return file pointers, conventions, test commands, entry points. No dumps.
4. Write the plan to `docs/plans/<slug>.md` using the skeleton below. One section per PR. Name the execution playbook: `autopilot` (with or without merge) or `orchestrate`.
5. Write it with `/write`.
6. Run `scripts/check-plan.sh <plan>` from peystack and fix what it prints.
7. Post the path and stop. Execution waits for an explicit go.

Verification rule (every PR repeats it): tests alone are not verification. A PR is verified when its unit, live, and perf boxes are all checked. Live lanes drive the real surface (count by tier: 1 / 3 / 10), and one lane runs the same scenario on trunk and head. Perf names a metric, the trunk baseline, and the failing threshold. A PR that changes an interaction is review-gated with screenshots.

```markdown
# <Program> plan

<Under ten lines: what changes, for whom, PR ids in order.>

## How to read this

One box is one unit. Check a box only when its evidence exists. Runs `playbooks/<autopilot|orchestrate>.md`. <Who merges.>

## PR <id>: <title>

**Goal.** <one sentence>
**Depends on.** <PR ids or none>
**Files.** <paths it may write>

- [ ] <step> . evidence: <command / file / SHA>

**Verification.** Tests alone are not verification. A PR is verified when its unit, live, and perf boxes are all checked.
- [ ] Unit: `<command>` passes
- [ ] Live: <scenario> . saves <screenshot path> . passes when <predicate>
- [ ] Regression lane: same scenario on trunk and head
- [ ] Perf: <metric> trunk <n> head <= <threshold>
**Review gate.** <None, or what the operator reviews>

## Appendix A: Prototypes
## Appendix B: Decisions
## Appendix C: Risks
```
