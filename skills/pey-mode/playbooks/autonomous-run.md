# Autonomous run

You own the exit condition.

1. Write the exit predicate before iteration one (tests green, repro fixed, N PRs merged, diff zero).
2. Pick a wake mechanism. An event (CI, merge) gets a watcher plus a long heartbeat. No event gets a fixed heartbeat via `/loop`.
3. Each iteration: smallest evidence-backed change, check the predicate, commit if it advanced, revert if not.
4. Fix side problems that block the goal (broken tooling, flaky checks) yourself, in their own PR. Surface only irreversible actions, taste calls, or a real dead end.
5. Log each iteration with `/log`.
6. A plateau is not a stop. Pivot. Never relax the predicate.

**Reply:** the predicate, iterations, what landed, what was discarded, final state.
