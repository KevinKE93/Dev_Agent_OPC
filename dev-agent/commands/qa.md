---
description: Run optional acceptance, monkey, and visual QA after build
---

Use this only when the project marks `AUTOMATED_QA` or `VISUAL_QA` as required,
or when the user asks for extra validation.

1. Read `dev-agent/reviews/VERIFICATION.md`, current source, and the design handoff when UI applies.
2. For `AUTOMATED_QA`, use `dev-agent/references/acceptance-qa.md`: run an Acceptance Navigator pass and a Monkey Stability Runner pass.
3. Record `dev-agent/reviews/FUNCTIONAL_TEST.md`, `MONKEY_TEST.md`, and `ACCEPTANCE_QA.html`; use `reviews/acceptance-screenshots/` only for blockers, exceptions, visible broken UI, or explicit user request.
4. If host subagents are available, split the two QA lanes in parallel and merge evidence in the main host.
5. For `VISUAL_QA`, compare implemented UI with required design contract inputs and record `dev-agent/reviews/VISUAL_COMPARISON.md` with calibrated source raster baselines, matching runtime screenshots, image-diff evidence, and `Overall score: N/100`.
6. Review code quality risks: correctness, state coverage, simplicity, boundaries, accessibility, security/privacy, and performance.
7. Use `technical-steward` when QA evidence looks too smooth, thin, or unable to prove final technical readiness.
8. If QA exposes unclear requirements, weak design inputs, or blocked tooling, route the issue back to spec/design/build/debug before continuing.
9. Run `bin/dev-flow qa-check <project-name>` when QA is required.
