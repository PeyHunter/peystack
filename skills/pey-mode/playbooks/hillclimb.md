# Hillclimb

One change, one measurement, keep or revert. Never stack untested changes.

1. Ground with `/how`. Pick a case that reproduces the complaint. Fix one metric, its direction, and a stop predicate that pairs a target with a minimum attempt count.
2. Build the harness, prove it separates easy and hard cases, vet it with `/bench`, then freeze it. One command prints the metric (median of N), an error count, and a work count. Record baseline and a green regression gate.
3. Start `decisions.tsv` with `/log`: id, hypothesis, change, before, after, delta, tests, verdict, note. Gitignore it.
4. Each hypothesis names a mechanism. Order perf hypotheses by the mantras in `perf`.
5. Loop. Make the change (a `pey-agent` at `std`, parallel worktrees at `deep`). Measure and run the gate. Keep only a move past noise with the gate green. Otherwise revert fully. One commit per kept win, staging named files only. Log every attempt.
6. On a stall, pivot category, combine near-misses, or try something radical. Correctness and simplicity outrank the number.
7. Stop at the predicate or when only marginal ideas remain. Never relax the predicate.
8. Run `pr` with kept commits in order.

**Reply:** metric and target, baseline to final with percent, kept vs reverted counts, one line per kept fix, log path, the next idea.
