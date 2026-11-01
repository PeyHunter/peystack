---
name: setup-peystack
description: Set peystack's budget tier and per-role models. Use for /setup-peystack.
disable-model-invocation: true
---

# Setup peystack

1. Ask two questions with `AskUserQuestion`: the default tier (`std` recommended, `lite`, `deep`), and whether roles should all inherit the parent model (recommended) or use a mix.
2. Write `~/.claude/rules/peystack.md`. This file loads every session, so keep it under 10 lines:

```
# peystack config
tier: std
marathon: on
arena runners: inherit-parent
swarm workers: inherit-parent
interrogate reviewers: inherit-parent
judgment: opus
```

`marathon: off` disables the always-on marathon. Model values are `inherit-parent`, `opus`, `sonnet`, `haiku`, or `fable`. Fewer lines are fine; a missing role uses the parent model.
3. Show the file and say how to change the tier mid-session ("tier deep").
