# Principles

Each entry is the trigger, then the rule, then the test you can apply.

## Core

- **Lazy.** Sizing a diff or tempted to add a layer. Ship the smallest change that solves the problem. Test: can you delete a line and still pass?
- **Foundations first.** Before logic. Pick core types, data structures, and what concurrent actors share. Scaffold before features. Test: does the downstream code look obvious?
- **Redesign as if day-one.** A new requirement meets an old design. Reshape the design as if the requirement were always there, not as a bolt-on. Test: would a newcomer guess the bolt-on was original?
- **Attack the premise.** Two fixes that share one premise failed the same gate. Write the premise down and test it directly before a third fix.
- **Subtract before adding.** Before an addition or rewrite. Delete dead code, stubs, and redundant validators first, in their own commit.
- **Minimize reader load.** Code is hard to trace. Count layers from question to answer and hidden mutable state. Collapse one-caller wrappers. Shrink mutable scope.
- **Converge on the target.** Planned migration with phases. Skip throwaway compatibility states. Scoped breakage during a phase is fine.
- **Experience first.** Scope or UX tradeoff. Pick what delights the user over what is easy to build. Fewer polished features beat more rough ones.
- **Try 2-3 shapes.** Novel design with no precedent. Build competing sketches and compare them side by side before committing.
- **Build the lever.** Any non-trivial work. Write the codemod, script, or generator that does or proves the work. The tool is what a reviewer reruns.

## Architecture

- **Model the domain.** Stateful logic, heavy branching, or one shape assumption repeated across files. Encode it in a structure: a state machine, a table or registry, a typed model, a reducer, the right collection.
- **Boundary discipline.** Validation and error handling. Parse and guard at system edges (CLI, config, network, external APIs). Trust internal types. Keep business logic pure.
- **Type discipline.** Typed languages. Make illegal states unrepresentable. Brand semantic primitives. Exhaust variants. Derive types from the authoritative schema.
- **Idempotent operations.** Commands and loops that crash and retry. Converge to the same end state from any partial prior run.
- **Migrate then delete.** New internal API while old callers exist. Move every caller and delete the old API in one wave. No shims.
- **Separate shared state.** Concurrent actors may write the same file, branch, or key. Remove the sharing (own worktree, own key) before you add locks.

## Verification

- **Prove it works.** Before "done". Check the real artifact: run the feature, read the value, inspect the diff. "It compiles" and self-reports are not proof.
- **Fix root causes.** Debugging. Trace to the first place the system went wrong and fix there. A guard is a fix only when the state it handles is legitimate.
- **Small verifiable units.** Multi-step work and commit stacks. Each unit ends in a check. Verify before the next. Order commits so history proves itself (failing test, then fix).
- **Test behavior.** Writing or keeping a test. Assert what users observe. The test fails when behavior breaks and passes when only internals change.
- **Explain the number.** Any measured number. Name what limits it and rule out that it measured something else. See `/bench`.

## Delegation

- **Guard the context window.** Large outputs, long files, fan-out. Route bulk to subagents and keep summaries in the main thread.
- **Never block on the human.** Reversible work. Proceed, show the result, let the human correct course.

## Meta

- **Encode lessons in structure.** You write the same instruction twice. Turn it into a lint, type, test, or script. See `/correct`.
