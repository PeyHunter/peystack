---
name: architect
description: Sketch types, signatures, and module shape before code. Use for /architect or work crossing a function boundary.
disable-model-invocation: true
---

# Architect

1. **Ground.** `/how` over the touched systems unless you already have it this session. Skip for true greenfield.
2. **Sketch.** Write the caller's usage first, then the types and signatures with `not implemented` bodies. Produce two structurally different shapes, not two variants of one. At `deep`, run `/arena` with each runner producing one sketch.
3. **Screen.** Reject a sketch with any red flag: a shallow wrapper, a parameter threaded through many layers, a boolean flag that forks behavior, state duplicated in two owners, callers that must know internals, types that need casts or always-set optionals. Assume the next contributor is an agent that copies the nearest example. Prefer the shape where the obvious edit is the right one, and the smaller public surface.
4. **Pick.** Write a short rationale: options, the pick, why, what you rejected. Proceed without a human checkpoint unless the user asked for one.
5. **Implement against the sketch.** A needed deviation is a signal. Ask whether the sketch was wrong before absorbing it.
6. **Scrap** when friction repeats: the same workaround in unrelated places, edge cases all needing special branches, casts to compile, a lock the sketch said was unneeded. Re-ground, redesign smaller, sketch again.
