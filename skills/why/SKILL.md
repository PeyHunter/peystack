---
name: why
description: Find why code is shaped the way it is, from git history, PRs, issues, and connected tools. Use for "why does X", regressions, design rationale.
disable-model-invocation: true
---

# Why

Separate what you know from what you infer.

1. Anchor. Get `file:line` ranges, key symbols, `git log -L` or `git blame` on the range, PR numbers from merge subjects `(#123)`, linked issue IDs.
2. Source control first, inline: `gh pr view <n> --comments`, commit bodies, tests that pin the behavior. Often this answers it. Stop if it does.
3. If not, spawn one investigator per extra evidence source that exists here (issue tracker, docs, chat, observability, error tracking, analytics via MCP). Count by tier: `lite` 1, `std` up to 3, `deep` all. Brief: the anchor, the question, the one source it owns, "return at most 200 words with links".
4. Defensive code (retries, timeouts, null guards, flags) gets an extra look for an incident or error that caused it.
5. Synthesize yourself.

Output: **Answer** (1-3 sentences with a confidence: confirmed, likely, guess). **Evidence** (each link and what it shows). **Sources checked** including the empty ones and the ones unavailable. **Open questions**.
