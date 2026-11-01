---
name: ts
description: TypeScript rules. Use when editing .ts or .tsx files under pey-mode.
disable-model-invocation: true
---

# TypeScript

- `strict` on. No `any`. `unknown` at boundaries, parsed with a schema (zod or similar) into a typed value.
- Discriminated unions over optional-field bags. `switch` with an exhaustive `never` check.
- Brand semantic primitives (`type UserId = string & { __brand: 'UserId' }`).
- Derive types from the source of truth (`z.infer`, `typeof`, generated API types). Never hand-sync.
- `readonly` and `as const` by default. Narrow, do not cast. `as` only at a proven boundary.
- Return errors as values for expected failures. Throw only for bugs.
- No barrel files in app code. Named exports.
- `satisfies` to check a literal without widening.
