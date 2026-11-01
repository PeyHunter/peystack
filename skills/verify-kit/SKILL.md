---
name: verify-kit
description: Create or maintain a project verification skill (drive the app like a user) or formal verification (model-check states and invariants). Use for /verify-kit.
disable-model-invocation: true
---

# Verify kit

Pick the mode from the request.

## create

1. Find the surfaces (CLI, web UI, API, mobile) and how to launch each locally.
2. Write `.claude/skills/verify/SKILL.md` in the project: launch command, readiness check, how to drive it (CLI: run and read stdout; web: Playwright; API: curl), how to save evidence (screenshot, log), teardown.
3. Write a feature map `.claude/skills/verify/features.md`: one row per user-visible feature, the steps to drive it, the pass predicate.
4. Prove it by driving three features end to end.

## maintain

1. Find commits since the map was last touched.
2. For each changed feature, reread the source, then drive it live once.
3. Fix stale rows in one PR with proof. Add rows for new features.

## formal

For concurrency, retries, state machines, or protocols where tests reach poorly.

1. Pick the costliest bug zone. Pick the tool: TLA+/TLC for protocols and states, property tests for pure logic, a model checker native to the language when one exists.
2. Model only the states and actions that matter. Write invariants as plain sentences, then as properties.
3. Run it. Each violation is a trace. Render the state graph as a Mermaid `stateDiagram` with the failing path highlighted.
4. Classify each failure: model drift or real bug. Real bugs go to the Bug fix playbook.
5. To maintain later, rerun after commits touching modeled code and update the model to match the code.
