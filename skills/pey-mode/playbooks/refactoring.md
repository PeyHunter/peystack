# Refactoring

Structure changes. Behavior does not. A found bug or missing feature splits into its own change.

1. Pin behavior first: a characterization test, snapshot, or old-vs-new harness. Type check and lint are not a pin.
2. Name the missing structure and the target shape. The reshape must delete branches or invalid states, not add indirection. Crossing a function boundary means `/architect`.
3. Subtract first: dead code, one-caller wrappers, redundant validators, orphan references.
4. Move in small steps with the pin green. API reshapes migrate every caller and delete the old API in the same wave. Grep each rename in strings and docs too.
5. Prove equivalence on the real artifact.
6. Keep it only if reader load dropped somewhere. Otherwise revert.
7. Commits: subtraction, reshape, cleanup. Run `pr`.

**Reply:** the structural change, the pin, the equivalence proof, the reader-load delta, what got reverted.
