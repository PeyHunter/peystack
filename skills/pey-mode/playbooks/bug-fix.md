# Bug fix

Every shipped line traces to runtime evidence. A "might help" change is a hypothesis and does not ship.

1. Reproduce it yourself on the real surface (CLI, browser, API). Ask the user only when you cannot reach the target, and say why.
2. Binary-search the cause. List hypotheses (seed with `/how`, and `/why` for regressions). Take the split that cuts the most space, get evidence, eliminate. Instrument instead of guessing. Confirm the mechanism before fixing.
3. Plan the fix. Crossing a function boundary means `/architect` first. At `std`/`deep`, delegate the fix per the Manager section in pey-mode; at `lite`, do it inline.
4. Verify on the same surface. The original repro now passes. Wrong-surface or inconclusive is not a pass.
5. Commit the failing repro or test before the fix (`/tdd` when a cheap test exists).
6. Run `pr`.

**Reply:** what broke, the root cause, the fix, failing-then-passing output verbatim.
