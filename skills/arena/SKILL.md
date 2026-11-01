---
name: arena
description: Run N candidates on the same task, pick a base, graft the best of the rest. Use for /arena.
disable-model-invocation: true
---

# Arena

1. **Frame.** State the artifact. Write a 3-6 item rubric only you and the judge see. Runners: the `arena runners` line in `~/.claude/rules/peystack.md`, else 2 on the parent model (`deep`: up to 3 across families). Each gets its own worktree (`isolation: "worktree"`).
2. **Fan out.** Spawn all in one message with the same prompt, the grounding paths, its output path, and "end with a 5-line rationale naming the alternatives you rejected". A dropout means proceed with N-1.
3. **Judge** (`std`/`deep` only). One `Explore` judge from a different family than the runners, with the rubric and outputs by label (A, B, C), never model names.
4. **Pick.** Read every candidate. Score each rubric line. Disagreement with the judge means reread both. Pick the base easiest to extend safely. Ties go to the smaller API.
5. **Graft** 1-2 strong ideas from each loser by hand. Convergence means ship the consensus. Wild divergence means the frame was weak, so reframe and rerun.
6. **Verify** the result on the real artifact.

Output: the artifact plus a note with the base and why, the judge verdict, each graft and its source, rejections, verification.
