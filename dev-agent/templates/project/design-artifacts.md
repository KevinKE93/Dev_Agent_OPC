# Design Artifacts: {{PROJECT}}

Satisfy `dev-agent/references/design-artifacts.md` and run
`bin/dev-flow design-check {{PROJECT}}` before build.

## Required Coverage
- Derive the canonical screen list from the idea, PRD, user stories, acceptance criteria, spec, design, and interaction model.
- Record every required screen or global surface as a `##` section in `SCREEN_ACCEPTANCE.md` with a `Requirement source:` line.
- Produce or collect formal layout/state raster/PDF assets when UI/UX design applies.
- Add Screen Coverage rows for exact `SCREEN_ACCEPTANCE.md` headings before UI build.
- Put build-ready HTML/CSS companion packages under `design/approved/html/`; use one HTML file per screen/state when visual differences matter.
- Do not use product-designer prose, local HTML, Playwright/browser screenshots, or self-rendered SVG/canvas output as the formal source.

## Screen Coverage
| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |
|---|---|---|---|---|---|---|---|
