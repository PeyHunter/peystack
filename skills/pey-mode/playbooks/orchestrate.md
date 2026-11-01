# Orchestrate

You run the program, never the code. For multi-day work with many PRs and workers. Work one agent can finish in a session is not a program.

Keep program state in `.peystack/program.md`. Do not relay messages between agents.

**Topology.**
- One owner per PR. Only the owner writes its branch.
- A fresh worker per independent task. The brief carries the goal, allowed paths, forbidden actions, upstream reports it needs, and the evidence that proves done. No evidence means the unit is not scoped yet.
- A sub-coordinator only for an area with many workers. It sends you one rollup. Three levels max. About ten workers in flight per coordinator.
- Each PR gets a verifier that is not its author, from another model family at `deep`.
- Start with one unit end to end before fanning out.

**Supervision.**
- Read the diff or artifact, not the summary. A verdict covers one head SHA.
- Send back scope drift. Park non-blocking fixes as follow-ups.
- Check live PR state with `gh pr view` and `gh pr checks` before reporting.
- Judge stalls by pushes, not status text. Retry by cause: smaller scope after a context limit, same brief after a dropped connection, another model after a tool error. Two retries, then replan.
- Ask the user only for irreversible actions, taste calls, or a dead end that survived a replan.

**Reply:** what landed, each PR's state, verdict, and link, what was dropped, decisions waiting on the user.
