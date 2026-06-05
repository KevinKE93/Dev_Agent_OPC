---
description: Resolve reference-backed UX direction and build-ready design handoff
---

Invoke the `design-flow` skill.

Before UI build:

1. Read the idea brief, PRD, approved spec, references, existing UI, and project context.
2. State assumptions, plausible interpretations, tradeoffs, and any blocker that needs user input.
3. Ask whether the user has references. If references exist, use them. If none exist and the user delegates direction, create `REFERENCE_BOARD.md`; otherwise raise a design blocker.
4. Produce `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md`; every screen section must include `Requirement source:`.
5. Product-designer output, brief confirmation, and written style direction are direction only. If high-fidelity UI is required, route them into Image Gen/GPT Image or Figma and select a formal visual target before build.
6. Do not use sketches, prototypes, local HTML, uploads, external exports, design-system exports, or runtime screenshots as build inputs. Satisfy `dev-agent/references/design-artifacts.md` when formal visual assets, HTML/CSS companion packages, asset manifests, or raster comparison notes are needed.
7. When Figma is used, satisfy `dev-agent/references/figma-handoff.md` and run `bin/dev-flow figma-check <project-name>`.
8. Run `bin/dev-flow design-check <project-name>` and fix failures before build.
