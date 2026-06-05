---
description: Build or polish user-facing UI with visual quality gates
---

Invoke the `frontend-ui-engineering` skill.

Use this when implementing screens, components, interactions, responsive layouts, or visual polish:

1. Run or confirm `bin/dev-flow design-check <project-name>` before UI code; return to design if screen acceptance, formal visual sources, or companion packages are missing.
2. Read design docs, `tasks/IMPLEMENTATION_TRACE.md`, and required inputs from `dev-agent/references/design-artifacts.md`.
3. State assumptions, tradeoffs, and any design/platform conflict before editing.
4. For high-fidelity UI, calibrate the approved visual target before coding: source raster path, natural size, viewport, device pixel ratio/export scale, crop/frame, route/state/theme, and ignored regions.
5. Catalog visible runtime assets in `design/cut-assets/ASSET_MANIFEST.md` before replacing placeholders.
6. Implement the complete current UI batch before visual scoring; keep per-screen checks cheap while building.
7. Verify required states and interactions, then record functional and monkey evidence.
8. Write `reviews/VISUAL_COMPARISON.md` with calibrated compared inputs, image-diff evidence, per-screen scores, and `Overall score: N/100`; high-fidelity delivery requires at least 90/100.
9. Capture screenshots only for exceptions, blocked flows, visual diff evidence, or explicit user request.
10. Run `bin/dev-flow qa-check <project-name>` when `AUTOMATED_QA` or `VISUAL_QA` is required.

If no design contract exists, or required formal visual source / companion contracts are missing, return to the design phase first.
