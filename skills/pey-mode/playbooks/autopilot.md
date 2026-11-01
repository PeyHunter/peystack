# Autopilot

A queue of PRs run with full autonomy. Default mode is `stack` (verified, operator lands). Mode `merge` only when the operator says "merge" or "full autopilot".

1. The operator's named gates come first. Their items and anything outside the queue stop at merge-ready. "State the plan" is not a go.
2. One owner per PR (a `pey-agent` with `isolation: "worktree"`). The owner builds, opens the PR per `pr`, proves it on the real artifact, and babysits it to green. It pushes each finished unit and keeps a `/log` trail. It force-pushes only its own branch with `--force-with-lease`.
3. Owners run in parallel off trunk. In `stack` mode a PR stacks on another only when it builds on it.
4. Verify once at the code-ready head with `/swarm` (lanes by tier: 1 / 3 / 10, never by the author). Lanes rerun the checks, drive the real surface, and audit the diff. A rebase or small fix gets one verifier. Wording-only gets none. Block only on a problem you can show at the head.
5. `merge` mode: the owner merges only the verified patch, after fetching trunk. Rebase and rerun CI if trunk touched the same files or the patch's dependencies. `stack` mode: stop at verified and green, hand PRs to the operator, nobody pushes after handoff without a go. A verdict survives a restack when `git patch-id` is unchanged.
6. Anything that loosens a gate (raised budget, disabled check, allowlist) needs a verifier's proof and your countersign. Never bypass a forge-enforced approval.
7. Long runs: `/loop 1h` audit. Probe each owner by its pushes and log rows, not its status text. Replace stuck agents. Catch the operator up with `/ketchup` only when something changed.
8. On "stop", every owner stops writing and reports.

**Reply:** `/ketchup` style: each PR with state, verdict, and link; what merged; countersigns; open operator gates; follow-ups.
