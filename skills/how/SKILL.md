---
name: how
description: Explain how code works, or where something should live. Use for "how does X work" and placement questions.
disable-model-invocation: true
---

# How

1. Scope it. Simple (one module, one function) or complex (spans files or services). When unsure, simple.
2. Simple: explore and explain yourself. Read entry points first, then follow calls. Read ranges, not whole files.
3. Complex: split into 2-4 angles (`lite`: 2, `deep`: 4). Spawn one `Explore` agent per angle in one message. Brief: the question, the angle, "return at most 200 words of findings with `file:line` pointers". Then write the explanation yourself from their findings.
4. Output these sections, dropping empty ones: **Overview** (3 sentences), **Key concepts**, **How it works** (the runtime flow, step by step), **Where things live** (`file:line`), **Gotchas**.

Senior-engineer onboarding level. A mental model, not annotated source. Motivation questions go to `/why`.
