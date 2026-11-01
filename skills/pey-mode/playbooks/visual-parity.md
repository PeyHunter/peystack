# Visual parity

Pixel-exact equivalence, verified by image diff, never by eye.

1. Build the baseline harness first: screenshots of each component state. No baseline, no parity claim.
2. Never edit the harness or baseline, and never restructure a component to pass. If the baseline looks wrong, ask.
3. Migrate shared primitives first, then one component at a time (one worktree per owner at `deep`).
4. Diff each component against its baseline. Nonzero is a fail. Loop until zero.
5. Run `pr` per component or safe batch.

**Reply:** components done, diff result each, harness path, what is left.
