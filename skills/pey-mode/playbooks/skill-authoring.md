# Skill authoring

1. Frontmatter: `name`, and a one-line `description` with the trigger words. Every description is loaded each session, so every word costs tokens.
2. Body: steps the agent runs. Keep only prose that changes a decision. State the rule, skip the reason unless the rule confuses without it. Point at other skills by path instead of restating them.
3. Put long reference material in a sibling file read on demand.
4. Validate: frontmatter present, referenced paths exist. Run `scripts/measure.sh` in peystack to see the token cost.
5. Test with the `eval` playbook if the change is structural.
6. Run `pr`.

**Reply:** what the skill does, design choices, validation output.
