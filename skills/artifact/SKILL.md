---
name: artifact
description: Make a simple visual one-page explanation of a topic. Use for /artifact <topic>.
disable-model-invocation: true
---

# Artifact

Turn a topic into one page a beginner understands in two minutes. Pictures first, few words.

## Content

1. Gather facts only as far as needed: the conversation, the code (`/how` for code topics), or a quick search. Do not pad.
2. Plan the page before writing it:
   - **Title** (2-4 words) and a one-sentence answer to "what is it?".
   - **One main diagram** that shows the mechanism: boxes and arrows, at most 7 boxes, at most 6 words per label.
   - **3-5 short sections**, each a heading and at most 3 sentences or a small table. Good defaults: what it is, how it works, an everyday example, when to use it, common mistakes.
   - **A comparison table** when the topic is "X vs Y".
3. Plain words. Follow `/write`. No jargon without a one-line definition.

## Page

- One self-contained HTML file. Inline CSS and inline SVG. No JavaScript unless something must be interactive.
- Colors as CSS variables on `:root`, with a `prefers-color-scheme: dark` version. Body gets an explicit background.
- Readable on a phone: max width about 760px, 16px side padding, no horizontal scroll.
- SVG text uses `currentColor` or the theme variables so it shows in both themes.

## Publish

- If the `Artifact` tool exists: call it with `action: "quickstart"` and `intent: "other"`, follow what it says, write the file to the scratchpad, then publish it and give the user the link.
- Otherwise: write `~/explainers/<slug>.html` and give the user the full path to open in a browser.

Reply with the link or path and one sentence on what the page shows.
