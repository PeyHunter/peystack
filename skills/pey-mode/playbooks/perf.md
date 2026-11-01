# Perf

Tie every fix to a measurement. Do not read source instead of measuring.

1. Capture a baseline on the real surface. Vet it with `/bench`.
2. Ground hypotheses with `/how`. Try the mantras in order and stop at the first that meets the target: don't do it; don't do it twice; do less; do it later; do it when nobody is looking; do it concurrently; do it cheaper.
3. Fix from the trace, one attempt at a time. Crossing a function boundary means `/architect`.
4. Capture a post-fix trace. Compare artifacts with a script (JSON to sqlite, diff).
5. Cite one number in the PR. Run `pr`.

For sustained work against a metric, use `hillclimb`.

**Reply:** baseline, after, delta, artifact path.
