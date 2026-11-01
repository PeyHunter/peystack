---
name: figure-it-out
description: Design a bespoke auditable playbook when none fits, for large or cross-cutting work. Use for /figure-it-out.
disable-model-invocation: true
---

# Figure it out

The first deliverable is the workflow, not code.

1. **Frame.** A falsifiable done predicate. Scope in units and effort. Rigor level: one-way doors and wide blast radius get more gates. Present it. A multi-hour run gets one checkpoint with the user.
2. **Design.** Split into independently landable units, riskiest unknown first. Build the verification harness and capture the baseline before the work. One-way-door decisions get `/architect`. Fan out only across real seams, each worker in its own worktree. Write the phase list down.
3. **Loop.** Each unit is an experiment: hypothesis, smallest change, measure on the real artifact, keep or revert. Verdicts are VERIFIED, NOT VERIFIED, or INCONCLUSIVE. Inconclusive is not a pass. If a worker games a gate, harden the gate in its own change.
4. **Trail.** `/log` a row per decision. Commit the log when a reviewer needs it.
5. **Hand back.** Check the whole against the predicate on the real product. Encode recurring corrections with `/correct`.

Reply: the designed playbook, rigor and why, log path, what is verified, what is open.
