---
name: tdd
description: Red-green-refactor. Use when the user asks for TDD or a regression test, or the bug has a cheap local test.
disable-model-invocation: true
---

# TDD

Skip when the test path is expensive, integration-heavy, or unclear.

1. Write one test for one observable behavior. Run it. Watch it fail for the right reason.
2. Write the smallest code that passes. Run it.
3. Refactor with the test green.
4. Commit the failing test before the fix so history shows red, then green.

Assert what callers observe, not internals. No mocks of code you own unless it crosses a process boundary.
