# Eval

Test how a skill, prompt, or structure change affects agent behavior.

Blinding rules: no eval words (eval, test, judge, rubric, score, compare, benchmark, candidate, arena) in anything a candidate sees. The prompt reads like a real user request. Do not ask candidates to list the skills they used. Candidates do not know others exist. The judge sees sanitized labels only.

1. Frame the variant and success. Write a 3-6 item rubric for the judge only.
2. Set up one sanitized working dir per candidate with the variant in place.
3. Write one organic prompt.
4. Spawn N candidates (2 at `std`, up to 4 at `deep`) across model families, same prompt.
5. One blind judge from another family scores all outputs on one scale in one pass.
6. Grade chain-following from transcripts and code shape (`~/.claude/projects/<cwd-slug>/`), never from self-report.
7. Read every output yourself and reconcile with the judge.

**Reply:** variant, rubric, per-candidate notes, judge verdict, your synthesis, promote or not.
