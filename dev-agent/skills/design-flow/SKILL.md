---
name: design-flow
description: Use when a spec needs customer-facing UX, visual direction, screen acceptance, design references, formal assets, Figma handoff, or design gates before build.
---

# Design Flow

Turn an approved spec into a build-ready design package. Use after
`spec-driven-development` and before build when the spec says the work touches
UI, visual direction, brand/KV, interaction states, motion, or any
customer-facing workflow where visual quality affects delivery. Skip design only
when the spec or project applicability clearly marks UI/design as not needed.

## Operating Rules

- Think before committing: state assumptions, unclear points, alternatives, and
  trade-offs before choosing a direction.
- Keep it simple: produce only the artifacts needed for the current product
  scope, but do not skip required design gates.
- Modify precisely: keep process artifacts under `<project-name>/.dev-agent/`
  and source output under the project root.
- Work toward a verifiable target: every key screen must have acceptance
  criteria before build. Delegate formal visual-source rules to the design
  artifact reference and executable gates.
- Drafts, sketches, low-fidelity prototypes, and runtime screenshots are input
  evidence only. They cannot be the build target.
- Product-designer output is design judgment only. It can define UX, IA,
  screen/state, visual-system, and blocker requirements for Image Gen/GPT
  Image, Figma, or human design, but it is not a development resource by itself.
- Require a formal high-fidelity visual source before high-fidelity build:
  Image Gen/GPT Image raster boards, Figma frames, human-designer exports,
  external design-tool exports, or design-system board exports.
- Use high-fidelity HTML/CSS companion packages as implementation-readable
  handoff for those formal visual sources. Use JS or Lottie assets when motion must be
  reproduced.
- Generate new logo, app-icon, brand/KV, and high-quality bitmap assets only
  through the `imagegen` skill or an explicit Codex CLI image-generation path.
  Do not author SVG/HTML/canvas locally and render PNG for final identity assets.

## Outputs

Save design artifacts under `<project-name>/.dev-agent/design/`:

- `DESIGN.md`
- `VISUAL_SYSTEM.md`
- `SCREEN_ACCEPTANCE.md`
- `DESIGN_ARTIFACTS.md`
- `DESIGN_IMAGE_DESCRIPTIONS.md` when required by the design artifact contract
- `FIGMA_HANDOFF.md` when required by the Figma handoff contract
- `REFERENCE_BOARD.md` when visual direction is delegated
- HTML/CSS companion packages under `design/approved/html/`
- formal visual assets, brand/KV assets, logos/icons, and runtime element
  assets when required
- references, drafts, and mocks under their matching non-approved folders

Use `dev-agent/templates/project/` for file templates. Use
`dev-agent/references/design-artifacts.md` and
`dev-agent/references/figma-handoff.md` for the detailed source contract.

## Workflow

1. **Read context**
   - Load the idea brief, product artifacts (`PRD.md`, `USER_STORIES.md`,
     `ACCEPTANCE.md`, `METRICS.md`) when present, agent notes when present, the
     spec, project type, applicability flags, prior design
     artifacts, reference intake, and existing app screens when code exists.
   - Keep commands and paths inside `<project-name>/`.

2. **Run reference intake**
   - For customer-facing UI, run
     `bin/dev-flow reference-check <project-name> --required`.
   - If references exist, extract concrete layout, navigation, component,
     typography, spacing, color, motion, density, and state patterns.
   - If no reference exists and the user has not delegated visual direction,
    ask for examples before build.
   - If the user delegates visual direction, create `REFERENCE_BOARD.md` and
     run `bin/dev-flow reference-check <project-name> --delegated`.

3. **Define the UX problem**
   - Name the target user, primary job, success criteria, constraints, and what
     currently feels unclear, slow, risky, or unfinished.

4. **Compare interaction approaches**
   - Present 2-4 plausible directions with trade-offs.
   - Recommend one direction and explain why it reduces cognitive load,
     improves trust, or speeds up a real workflow.

5. **Specify product structure**
   - Define information architecture, screen hierarchy, navigation, primary and
     secondary actions, permissions, confirmations, undo, and state model.
   - For assistant products, separate deterministic decision logic from
     conversational expression unless the user approves the LLM as decision
     owner.

6. **Specify platform and visual system**
   - Load `references/platform-ux-principles.md` when platform behavior matters.
   - Define palette, typography, spacing, icon direction, component rules,
     density, motion, accessibility, CSS token strategy, and forbidden visual
     patterns.
   - Avoid generic AI aesthetics: purple-heavy gradients, decorative blobs,
     nested card stacks, and oversized hero layouts in utility products.

7. **Define screen acceptance**
   - Derive canonical `SCREEN_ACCEPTANCE.md` headings from the idea, PRD, user
     stories, acceptance criteria, spec, and interaction model.
   - For each screen or global surface, record `Requirement source:` with the
     upstream artifact, story, acceptance criterion, or spec section that
     justifies it.
   - For each key screen, list content, states, breakpoints, actions, visual
     acceptance, accessibility acceptance, and design asset needs when relevant.
   - Include empty, loading, error, success, disabled, selected, long-content,
     and narrow-screen states when applicable.

8. **Decide whether UI/UX design is needed**
   - Decide whether user-provided resources are build-ready: they need enough
     HTML/CSS, visual-system, state, asset, and motion detail for a model or
     engineer to reproduce the UI without guessing.
   - If the spec/applicability says no UI/UX design is needed, keep
     `UI_FLOW=disabled` and do not invent a design phase. Build may proceed
     after spec/build gates.
   - If UI/UX design applies, formal visual assets are required for build.
     Do not set `UI_DESIGN_ASSETS=disabled` to bypass missing Image Gen/GPT
     Image, Figma, human export, external design, or design-system outputs.
   - If resources are insufficient, list the missing resources and route them
     to generation: visual-system and brand/KV direction, required screen
     images, HTML/CSS companion packages, CSS/JS or Lottie motion files when needed, and
     logo/app-icon sizes when product identity is in scope.
   - For logo, app-icon, brand/KV, and high-quality bitmap asset generation,
     load `imagegen` or use the Codex CLI image-generation path explicitly. Save
     the resulting raster assets and record `imagegen://`, `gpt-image://`, or
     `gpt-image-2://` provenance.
   - Do not create sketches or prototypes just to satisfy process.
   - Satisfy `dev-agent/references/design-artifacts.md` whenever UI/UX design
     is in scope.
   - When Figma is used, satisfy `dev-agent/references/figma-handoff.md` and
     run `bin/dev-flow figma-check <project-name>`.

9. **Produce design packages**
    - For each accepted screen and important state that needs high-fidelity
      design, create or collect a formal visual source first: generated raster
      board, Figma export, human-designer export, external design export, or
      design-system board export.
    - For each formal visual source, create or collect a separate HTML file
      under `.dev-agent/design/approved/html/` with CSS resources that encode
      the visual system and responsive layout. Add JS or Lottie files only when
      motion is part of acceptance.
    - Use generated, uploaded, Figma, external, or design-system visuals as the
      source of truth, and keep the HTML/CSS companion package as the
      implementation-readable companion handoff.
    - When identity assets are required, provide logo or app-icon variants sized
      for the target platform from Image Gen/GPT Image outputs. Local SVG
      renders are drafts only and must not be treated as final PNG assets.

10. **Record artifact coverage**
    - Update `DESIGN_ARTIFACTS.md`, `DESIGN_IMAGE_DESCRIPTIONS.md`,
      `FIGMA_HANDOFF.md`, and `ASSET_MANIFEST.md` only when the referenced
      contracts require them.
    - Keep `.dev-agent/tasks/IMPLEMENTATION_TRACE.md` aligned with the screens and states
      that build will implement.

11. **Gate before build**
    - Update the spec if design changes product scope.
    - Load `references/design-rubric.md` for design self-review when useful.
    - Run `bin/dev-flow design-check <project-name>` before build.

## Verification

- Customer-facing UI has references or explicit delegated visual direction.
- `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md` exist.
- Every `SCREEN_ACCEPTANCE.md` section names its upstream requirement source.
- Formal design artifacts satisfy `dev-agent/references/design-artifacts.md`.
- Required screen/state HTML/CSS packages exist and are mapped before build.
- Figma handoff satisfies `dev-agent/references/figma-handoff.md` when used.
- Interaction alternatives, recommendation, platform rules, accessibility, key
  screens, and states are explicit.
- `bin/dev-flow design-check <project-name>` passes before build.
