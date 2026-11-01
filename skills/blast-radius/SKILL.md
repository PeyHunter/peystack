---
name: blast-radius
description: Find what a change could break beyond its diff, and prove the one fact it is safe because of. Use for "what could this break".
disable-model-invocation: true
---

# Blast radius

Listing callers is not the job. Find the breakage grep misses, and prove it by running code.

1. Read the change, including what it now does that the diff does not spell out.
2. Find the one fact it is safe because of ("this only drops already-dead cache entries").
3. Look where grep stops: the library source at its pinned version, timing (microtasks, teardown), what a symbol is reached through (strings, config, reflection).
4. Rate each risk by likelihood and cost. Separate confirmed risks from cleared ones.
5. Prove the key fact with a script or test that calls the real code. Proof levels: said so < pointed at the line < walked the failure < ran it < reproduced in the app. Say which level you reached.
6. At `deep` on a wide change, add a second model's answer with `/arena`.

Output: **What it does**. **The safe fact** with proof level and output, or "unproven". **Risks** (`file:line`, likelihood, cost, check). **Cleared**. **Before merge**: the cheapest test that catches the real bug.
