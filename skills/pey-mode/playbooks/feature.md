# Feature

You own the design. Plan, review, verify.

1. `/how` over the affected code. Skip when you wrote it this session.
2. Name the data shape and its structure (state machine, table, typed model). Crossing a function boundary means `/architect`.
3. Throughput checkpoint, one line each, `n/a: <reason>` allowed: blocking first steps; independent workstreams; shared mutable state (split it); smallest safe decomposition.
4. Implement. At `lite`, inline. At `std`/`deep`, delegate per the Manager section in pey-mode. When several valid shapes exist and the tier is `deep`, use `/arena`.
5. Verify on the matching surface. Inconclusive is not a pass.
6. Rebase into small ordered commits, each green.
7. Contested design at `std`/`deep` gets `/interrogate`.
8. Run `pr`.

**Reply:** what you built, choices and why, the checkpoint, open decisions.
