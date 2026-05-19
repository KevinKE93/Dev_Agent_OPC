---
description: Build or polish user-facing UI with visual quality gates
---

Invoke the `frontend-ui-engineering` skill.

Use this when implementing screens, components, interactions, responsive layouts, or visual polish:

1. Run or confirm `bin/dev-flow design-check <project-name>` before UI code; return to design if screen acceptance, formal visual sources, or companion packages are missing.
2. Read design docs, `tasks/IMPLEMENTATION_TRACE.md`, and required inputs from `dev-agent/references/design-artifacts.md`.
3. State assumptions, tradeoffs, and any design/platform conflict before editing.
4. Implement the complete current UI batch before visual scoring; keep per-screen checks cheap while building.
5. Verify required states and interactions, then record functional and monkey evidence.
6. Write `reviews/VISUAL_COMPARISON.md` with per-screen scores and `Overall score: N/100`; high-fidelity delivery requires at least 90/100.
7. Capture screenshots only for exceptions, blocked flows, or explicit user request.
8. Run `bin/dev-flow qa-check <project-name>` when `AUTOMATED_QA` or `VISUAL_QA` is required.

If no design contract exists, or required formal visual source / companion contracts are missing, return to the design phase first.
