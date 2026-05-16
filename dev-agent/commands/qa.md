---
description: Run optional functional, monkey, and visual QA after build
---

Use this only when the project marks `AUTOMATED_QA` or `VISUAL_QA` as required,
or when the user asks for extra validation.

1. Read `.dev-agent/reviews/VERIFICATION.md`, current source, and the design handoff when UI applies.
2. For `AUTOMATED_QA`, run functional and exploratory/monkey checks and record `.dev-agent/reviews/FUNCTIONAL_TEST.md` and `MONKEY_TEST.md`.
3. For `VISUAL_QA`, compare implemented UI with required design contract inputs and record `.dev-agent/reviews/VISUAL_COMPARISON.md` with `Overall score: N/100`.
4. Review code quality risks: correctness, state coverage, simplicity, boundaries, accessibility, security/privacy, and performance.
5. Use `technical-steward` when QA evidence looks too smooth, thin, or unable to prove final technical readiness.
6. Capture runtime screenshots only for exceptions, blocked flows, or explicit user request.
7. If QA exposes unclear requirements, weak design inputs, or blocked tooling, route the issue back to spec/design/build/debug before continuing.
8. Run `bin/dev-flow qa-check <project-name>` when QA is required.
