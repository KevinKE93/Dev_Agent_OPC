# UI QA And Visual Comparison Rubric

Use this after implementing customer-facing UI and before delivery.

## Evidence

- Run critical functional flows from `SCREEN_ACCEPTANCE.md` and save results in `<project-name>/.dev-agent/reviews/FUNCTIONAL_TEST.md`.
- Run monkey or exploratory stress checks and save results in `<project-name>/.dev-agent/reviews/MONKEY_TEST.md`.
- Summarize the automated QA lanes in `<project-name>/.dev-agent/reviews/ACCEPTANCE_QA.html` when Acceptance QA runs.
- Compare the implemented UI against formal visual assets, HTML/CSS companion packages, cut assets, references, and design requirements.
- Save findings, a per-screen fidelity matrix covering every `SCREEN_ACCEPTANCE.md` screen, and `Overall score: N/100` in `<project-name>/.dev-agent/reviews/VISUAL_COMPARISON.md`.
- Every matrix row must include screen, approved visual asset path, companion path when required, runtime surface, fidelity score, decision, and notes.
- Capture screenshots under `<project-name>/.dev-agent/reviews/acceptance-screenshots/` or `visual-screenshots/` only when an exception occurs or a flow cannot be completed.

## Review Axes

- Fidelity: implementation follows reference direction and `VISUAL_SYSTEM.md`.
- Layout: no overlap, clipping, unintended scroll traps, unstable sizing, or broken responsive behavior.
- Content: realistic copy and data fit without hiding important actions.
- Interaction: primary actions, disabled states, focus states, and error recovery are visible and usable.
- Accessibility: contrast, labels, keyboard/focus, touch targets, reduced motion, and screen reader structure are acceptable.
- Runtime: no console errors, missing assets, blank canvases, or broken network-dependent UI.
- Design fidelity: runtime UI materially follows the formal visual asset and companion package layout, density, state coverage, and visual system unless a design reason is recorded.

## Score Guide

- 90-100: polished, coherent, complete states, no blocking UX or visual issues.
- 80-89: usable, but below the high-fidelity gate unless the user explicitly lowers the bar.
- 60-79: usable but not ready; notable mismatches, state gaps, or rough responsiveness.
- Below 60: visually or functionally incomplete.

## Severity

- Blocker: prevents task completion, hides primary action, breaks mobile/desktop, overlaps text, or violates critical accessibility.
- Important: visible mismatch from design contract, missing required state, weak hierarchy, or poor density.
- Suggestion: polish that improves quality without blocking delivery.
