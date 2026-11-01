# Forensics

Deliverable is a cited diagnosis, not a fix.

**Live process** (leak, CPU spin, glitch):
1. Capture a real signal: CPU profile, heap snapshot, or trace.
2. Reduce it to the smoking gun: hot function, retainer chain, loop firing without input. Parse big artifacts in a subagent.
3. Prove the mechanism with injected instrumentation or a live hotfix.

**Captured artifact** (cpuprofile, trace, spindump, heap snapshot):
1. Identify the format. Load it into a queryable form (sqlite, one row per sample or node) before reading.
2. Query for the heaviest frames or the retainer path to a GC root.
3. With a paired before/after capture, diff them to confirm. Without one, call it the strongest hypothesis.

Both: map the finding to `file:symbol:line`. A frame with no source mapping is not a diagnosis yet. Then hand off to Bug fix or Perf.

**Reply:** signal or artifact, the reduced finding, how you proved it, source location, artifact paths.
