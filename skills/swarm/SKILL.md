---
name: swarm
description: Fan out parallel workers for coverage, races, or verification lanes, and return one report. Use for /swarm.
disable-model-invocation: true
---

# Swarm

1. **Frame.** The done predicate and the report shape. Choose: partition (slices), race (identical briefs), or both. For a race, declare `first pass`, `rank all`, or `best-of` up front. Worker count capped by tier: 3 / 3 / 10 (`lite` only when truly parallel).
2. **Model.** The `swarm workers` line in `~/.claude/rules/peystack.md`, else the parent model.
3. **Fan out** in one message. Writing workers get `isolation: "worktree"`. Each brief stands alone: goal, slice, exact SHAs to test, method (sample count, order) for measurements, how to verify, and "report `PASS`, `ISSUES` (every provable issue), or `BLOCKED`, at most 200 words, with evidence".
4. **Aggregate.** Drop a result missing its SHAs or method and respawn once. A second miss is a gap, and a gap is not a pass.
5. **Report.** One table (worker, slice, result, evidence), issue one-liners, gaps.
