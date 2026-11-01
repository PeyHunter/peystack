---
name: bench
description: Vet a performance number before reporting or acting on it. Use for /bench or any measured speedup or regression.
disable-model-invocation: true
---

# Bench

Write the claim first, as you would ship it ("export is 30% faster at p50 on 60k rows"). Check `uptime` and `nproc`. Read what the script times.

1. **Limiter.** Name what bounds it (CPU, IO, lock, network) from a profiled run you do not report.
2. **Tuned.** Both sides run as production does: release build, real flags, warm or cold as production.
3. **Limits.** Do the arithmetic against disk, network, and core capacity. Impossible numbers mean a broken measurement.
4. **Errors.** Count failures and check outputs are correct. Fast rejections fake speedups.
5. **Repeats.** At least 5 runs per side, alternating A B A B. Report median and range. A gap inside the noise is no difference.
6. **Matters.** Report the micro result as a share of the end-to-end path a user waits on.
7. **Happened.** Confirm the work ran inside the timed region (lazy code, dead results, cache hits).

A quick ballpark the user asked for may be one run, but still check 4 and 7 and say it was one run.

Report: verdict (faster, slower, no difference, inconclusive), the number with unit, runs, range, limiter. Inconclusive when you cannot name the limiter or skipped 4 or 7.
