# PR

Runs at the end of every code playbook.

**Branch.** Work on a branch or worktree off main, never main itself. Parallel agents each get their own worktree.

**Commits.** Commit often, then rebase into small ordered commits that each could land alone. Conventional titles: `type(scope): subject`, imperative, no period. Bodies do not repeat the subject.

**Before opening.** Run `/decomment` on the diff. Write the title and body with `/write`.

**Body.** A one-minute briefing for a reviewer who has the diff. Under about 40 lines. `##` sections in this order, empty ones dropped:
- `## Why` 1-3 sentences, opening with the user's goal.
- `## What changed` 1-3 bullets.
- `## Scope` what it covers and leaves out. Always present.
- `## Tradeoffs` only rejected alternatives a reviewer would ask about.
- `## Blast radius` who it touches and why that is safe.
- `## Verification` 1-3 bullets, each a real command and its outcome. Perf gets one number `before → after`.

Long evidence goes in a linked file, not the body.

**Forge.** `gh` by default. Open PRs ready, not draft. Check `gh pr view` before you report status.

**Stacks.** Prefer narrow PRs. A child PR targets its parent's branch (`gh pr create --base <parent>`). Independent work branches from trunk.

**After.** Post the URL and keep building. Babysit only when asked, after the stack exists.
