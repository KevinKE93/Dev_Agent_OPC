# Figma Handoff

Use Figma after visual exploration when a screen needs structured design assets,
reusable components, or a more reliable visual QA baseline.

## Recommended Flow

1. Explore visual direction with references, imagegen, GPT Image, or designer
   input. Draft uploads and design-system notes can inform the direction, but
   they do not satisfy the build-ready source gate.
2. Formalize selected screens in Figma when layout, component reuse, or future
   iteration matters.
3. Export final Figma frames or component boards as PNG or PDF into
   `<project-name>/dev-agent/design/approved/`.
4. Record Figma-backed rows in `DESIGN_ARTIFACTS.md` with Source type `figma` or
   `figma-mcp`.
5. Record the Figma file/node and export mapping in `design/FIGMA_HANDOFF.md`.
6. Run `bin/dev-flow figma-check <project-name>` before build when
   any approved design asset is Figma-backed.

## Screen vs Library

- Use `figma-design` for screen frames, state boards, landing pages, dashboards,
  and mobile app screens.
- Use `figma-library` only when reusable tokens, component variants, or a
  durable design system are needed. It is intentionally heavier and should not
  block a simple one-screen build.

## Contract

Every Figma-backed approved asset must have:

- A Figma source reference such as `figma://file/node` or a Figma URL.
- A real exported PNG or PDF under `design/approved/screens/` or
  `design/approved/components/`.
- A matching `DESIGN_ARTIFACTS.md` row with resolution/export detail and
  approved/final status.
- A matching `FIGMA_HANDOFF.md` row linking the source and approved export.

Do not use runtime screenshots, browser captures, simulator captures, local
HTML/CSS screenshots, SVG/XML drafts, or prototype screenshots as Figma-approved
assets.
