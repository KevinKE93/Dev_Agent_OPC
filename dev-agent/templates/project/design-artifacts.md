# Design Artifacts: {{PROJECT}}

Satisfy `dev-agent/references/design-artifacts.md` and run
`bin/dev-flow design-check {{PROJECT}}` before build.

## Required Coverage
- Derive the canonical screen list from the idea, PRD, user stories, acceptance criteria, spec, design, and interaction model.
- Record every required screen or global surface as a `##` section in `SCREEN_ACCEPTANCE.md` with a `Requirement source:` line.
- Produce formal layout/state raster/PDF assets through Image Gen/GPT Image, or use Figma handoff when Figma is the formal source.
- A confirmed brief, product-designer prose, or written visual-system note is not a build target. Select a formal visual source before high-fidelity implementation.
- Add Screen Coverage rows for exact `SCREEN_ACCEPTANCE.md` headings before UI build.
- For Image Gen/GPT Image rows, put synchronized build-ready HTML/CSS companion packages under `design/approved/html/`; use one HTML file per non-icon screen/state when visual differences matter.
- Figma rows and icon/logo/app-icon rows are exempt from this package requirement.
- Record raster comparison hints in `Implementation notes` when known, such as source dimensions, viewport, export scale, crop/frame, and state.
- Do not use product-designer prose, local HTML, Playwright/browser screenshots, or self-rendered SVG/canvas output as the formal source.

## Screen Coverage
| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |
|---|---|---|---|---|---|---|---|
