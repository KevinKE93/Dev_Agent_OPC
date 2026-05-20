---
description: Build or update a Figma component library for a project before UI implementation
---

Use this only when the project needs reusable tokens, component variants, or a
durable design system. For one-off screens, prefer `figma-design`.

1. Read `<project-name>/dev-agent/design/VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`,
   `DESIGN_ARTIFACTS.md`, `FIGMA_HANDOFF.md`, existing code components, styling
   tokens, and required design contract inputs.
2. If Figma tools are available, invoke the Figma plugin skills
   `figma-use` and `figma-generate-library`. Follow the plugin workflow:
   discovery first, tokens before components, small sequential Figma operations,
   and validation after each component.
3. Define the library scope before creating components: token collections,
   text/effect styles, component list, variants, and what code component or
   runtime asset each Figma component maps to.
4. Export component boards and update `DESIGN_ARTIFACTS.md`,
   `FIGMA_HANDOFF.md`, and runtime asset records according to
   `dev-agent/references/design-artifacts.md` and
   `dev-agent/references/figma-handoff.md`.
5. Run `bin/dev-flow figma-check <project-name>` and
   `bin/dev-flow design-check <project-name>`.

Do not create a component library solely to satisfy the design gate; the gate is
already satisfied by valid approved screen assets.
