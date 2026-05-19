# UI QA And Visual Comparison Rubric

Use this rubric after implementation.

## Required Evidence

- `reviews/FUNCTIONAL_TEST.md` covers Acceptance Navigator happy paths and recovery paths.
- `reviews/MONKEY_TEST.md` covers Monkey Stability Runner random, repeated, invalid, resize, navigation, and stress interactions.
- `reviews/ACCEPTANCE_QA.html` summarizes automated QA scope, runtime, issues, and decision when Acceptance QA runs.
- `reviews/VISUAL_COMPARISON.md` compares the implemented UI to formal visual assets, HTML/CSS companion packages, cut assets, references, and screen acceptance criteria.
- `VISUAL_COMPARISON.md` includes a per-screen fidelity matrix covering every `SCREEN_ACCEPTANCE.md` screen.
- Every fidelity matrix row includes screen, approved visual asset path, companion path when required, runtime surface, fidelity score, decision, and notes.
- `VISUAL_COMPARISON.md` includes `Overall score: N/100`; the workflow gate expects at least 90/100 for high-fidelity delivery.
- `reviews/acceptance-screenshots/` or `reviews/visual-screenshots/` is used only when an exception occurs or a flow cannot be completed.

## Blocking Issues

- Text overlaps, clips, or spills out of controls.
- Primary actions are missing, unclear, or inaccessible by keyboard/touch.
- A required state is blank or broken.
- Mobile or desktop layout is unusable.
- Visual output ignores provided reference direction.
- Runtime UI materially diverges from formal visual assets or companion packages without a recorded design reason.

## Important Issues

- Spacing or typography lacks hierarchy.
- Card/panel structure is noisy or nested without purpose.
- Color use is generic, low contrast, or inconsistent.
- Icons, labels, and controls do not match common UI conventions.
- Loading, empty, error, and success states feel unfinished.
- Implementation differs from the agreed screen acceptance criteria.

## Suggestions

- Tighten copy to realistic product language.
- Reduce decorative effects.
- Improve component reuse after the visual direction is proven.
- Add motion only where it helps orientation or feedback.

## Evidence Checklist

- Functional tests cover required flows.
- Monkey or exploratory tests cover unstable interactions.
- Visual comparison covers required breakpoints and key states.
- Console/runtime issues were checked where possible.
- Findings cite specific screens or components.
- Residual risks are named.
- Exception screenshots exist only when an exception or blocked flow was recorded.
