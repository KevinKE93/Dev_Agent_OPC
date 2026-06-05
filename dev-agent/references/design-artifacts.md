# Design Artifacts

Customer-facing UI must have approved formal visual assets before
high-fidelity UI build. For non-Figma work, the visual source must be generated
through Image Gen/GPT Image and synchronized with a matching HTML/CSS companion
so build does not invent layout. Figma handoff can skip the HTML companion.
A confirmed brief, product direction, visual-system note, or prose design
review is not a visual target. High-fidelity build requires a selected formal
visual source such as an Image Gen/GPT Image raster board or Figma frame.

All relative paths in this contract, such as `design/approved/...`,
`tasks/IMPLEMENTATION_TRACE.md`, and `reviews/visual-screenshots/...`, are
relative to `<project-name>/dev-agent/`. Implementation targets such as
`apps/web/index.html` remain relative to the project root.

## Asset Classes

- References: external screenshots, apps, websites, Figma links, and competitor notes. Save under `dev-agent/design/references/`, `dev-agent/design/screenshots/`, or `dev-agent/design/reference-links.md`.
- Drafts: sketches, SVG/Mermaid/Markdown wireframes, low-fidelity prototypes,
  rough local HTML/CSS mockups, screenshots, and files named
  draft/sketch/prototype. Save under `dev-agent/design/drafts/` or `dev-agent/design/mocks/`.
- Approved visual assets: implementation-ready raster/PDF boards and state
  images from formal visual producers. Save under `dev-agent/design/approved/`.
- HTML/CSS companion packages: high-fidelity HTML files synchronized with the
  approved Image Gen/GPT Image output under
  `design/approved/html/`, with CSS resources under the same folder and optional
  JS/Lottie resources when motion is part of acceptance. These are handoff
  companions, not the formal design source.
- AI image HTML companions: when imagegen or GPT Image generates an approved
  non-icon visual asset, save the matching high-fidelity HTML/CSS companion
  under `design/approved/html/` and record the mapping in
  `design/DESIGN_IMAGE_DESCRIPTIONS.md`. Do not self-author or fabricate an HTML
  companion that is detached from the generated design image.
- Figma handoff: when Figma is used, satisfy `dev-agent/references/figma-handoff.md`.
- Verification assets: browser screenshots, simulator captures, Playwright/Chrome captures, and runtime output. Save under `dev-agent/reviews/visual-screenshots/` only when an exception or blocked flow needs evidence.
- Raster calibration: for high-fidelity visual QA, record how the approved
  visual target should be rasterized and compared to runtime: source path,
  natural dimensions, target viewport, device pixel ratio or export scale,
  crop/frame, theme, route, state, and any intentionally ignored regions.
  This belongs in `reviews/VISUAL_COMPARISON.md`, with source details also
  allowed in `DESIGN_ARTIFACTS.md` implementation notes.
- Delegated reference board: when the user delegates visual direction and no external reference is provided, save the generated reference direction in `dev-agent/design/REFERENCE_BOARD.md`.

Product-designer outputs, drafts, and verification assets are forbidden as
implementation targets. Use them only as inputs or requirements for Image
Gen/GPT Image or Figma.

## Coverage Contract

Derive required screens from the idea brief, PRD, user stories, acceptance
criteria, spec, design, and interaction model. Record each screen or global UI
surface as a `##` heading in `SCREEN_ACCEPTANCE.md` with `Requirement source:`,
then add at least one `DESIGN_ARTIFACTS.md` Screen Coverage row for each exact
heading:

| Screen | State | Source type | Source reference | Approved asset path | Resolution / export | Status | Implementation notes |
|---|---|---|---|---|---|---|---|

Allowed `Source type` values and formal producers:

| Source type | Producer | Required Source reference |
|---|---|---|
| `imagegen` | AI image generation model raster output | `imagegen://...` |
| `gpt-image` / `gpt-image-2` | GPT Image raster output | `gpt-image://...` or `gpt-image-2://...` |
| `figma` / `figma-mcp` | Figma file/frame/component export | `figma://...` or Figma URL |

Do not use `manual-design`, `local-approved`, browser captures, screenshots,
canvas captures, runtime app output, uploaded exports, external-tool exports,
design-system exports, self-rendered SVG exports, or prototype exports as formal
source provenance. Do not use local HTML/CSS packages as formal source
provenance; record them only as companion handoff paths in `Implementation
notes` when required.

Image Gen/GPT Image or Figma must provide high-fidelity design evidence for the
requested scope: visual system, icons/logo when in scope, each required screen
and state, component rules, responsive behavior, and source/export metadata.
Product designer direction may specify these requirements, but it is not a
development resource by itself.

Generated logo, app-icon, brand mark, brand/KV, and high-quality bitmap asset
rows must use `imagegen`, `gpt-image`, or `gpt-image-2` provenance. Do not
create SVG, HTML, or canvas locally and render it to PNG for final identity
assets. If the user supplies existing final brand assets, record them as
user-provided inputs and do not claim they were generated by the workflow.

Each Screen Coverage row must identify a formal visual design asset.
`Approved asset path` must be a raster/PDF board under `design/approved/`.
For Image Gen/GPT Image rows, every non-icon visual asset must also include a
synchronized HTML/CSS companion package. `Implementation notes` must include
`HTML: design/approved/html/<screen-state>.html` and, when not discoverable from
the HTML file, `CSS: design/approved/html/<path>.css`. The HTML package must be
non-empty, include real document structure, and include linked or inline CSS.
Icon/logo/app-icon rows do not require HTML companions. Figma rows do not
require HTML companions. Optional motion resources should be recorded as `JS:`
or `Lottie:` paths under `design/approved/html/` or `design/cut-assets/`.
For high-fidelity screens, `Implementation notes` should also include raster
comparison hints when known, such as `Raster: 1440x1024 @1x, crop full frame,
state default`.

When `Source type` is `imagegen`, `gpt-image`, or `gpt-image-2`,
non-icon rows must map the approved image to the HTML/CSS companion package in
`design/DESIGN_IMAGE_DESCRIPTIONS.md`.

## Figma Handoff

When `Source type` is `figma` or `figma-mcp`, satisfy
`dev-agent/references/figma-handoff.md` and run
`bin/dev-flow figma-check <project-name>` before build.

## Output Rules

- Approved visual assets and companion packages must live under `<project-name>/dev-agent/design/approved/`.
- Approved visual assets must be real non-empty raster image or PDF files.
- Required HTML companion packages must be real non-empty `.html` files under
  `design/approved/html/` with CSS. Use one package per screen/state when visual
  differences matter. Figma and icon assets are exempt.
- Non-icon AI-generated approved images must have synchronized HTML/CSS
  companions that encode layout hierarchy, content, components, states, colors,
  spacing, typography, interactions, motion, responsive behavior, and
  implementation notes.
- High-fidelity visual QA must compare runtime screenshots against a calibrated
  raster baseline from the approved source. Do not compare unmatched states,
  device frames, crops, density scales, or browser chrome without recording the
  mismatch and either correcting it or blocking the comparison.
- SVG, Mermaid, Markdown, and code-native files can be drafts or precise diagrams, but they do not satisfy the approved asset gate by themselves.
- SVG/XML sketches must not be stored under `design/approved/`. SVG files may be stored under `design/cut-assets/` only as manifested element/runtime assets, not as screen layout references.
- Browser, Playwright, Chrome, simulator, running-app screenshots, and local
  HTML/CSS screenshots must not be used as approved visual assets.
- If SVG icons, bitmap icons, illustrations, backgrounds, UI cutouts, icon matrices, spritesheets, or animation frames are needed, save them under `design/cut-assets/` and list each item in `design/cut-assets/ASSET_MANIFEST.md`.
- If brand identity is in scope, include brand/KV rules and logo or app-icon
  sizes required by the target platform, with Image Gen/GPT Image provenance
  for generated identity assets.
- If no cut assets are required, record `CUT_ASSETS_REQUIRED: no` with rationale.
- `tasks/IMPLEMENTATION_TRACE.md` must map each accepted screen to
  implementation target, approved visual asset, design source reference, HTML
  companion path, cut asset decision, test evidence, and status
  before UI build starts.

## Cut Asset Rules

`ASSET_MANIFEST.md` must identify the approved source asset, region or frame,
output path, format, alpha behavior, runtime path, usage, replacement/source
reason, and notes. Transparent PNG assets must preserve alpha. Icon matrices
and spritesheets must record grid, frame size, frame order, anchor point, scale,
and intended FPS or state mapping.

## Implementation Use

Use formal visual assets and companion packages to extract layout hierarchy,
responsive density, spacing, typography, colors, component states, icon style,
and motion direction. Do not implement from a draft or screenshot and then
treat the runtime screenshot as the design source. Do not implement directly
from product-designer prose; route that prose into a formal visual producer or
mark the task as no-UI/no-UX/code-only with `UI_FLOW=disabled`.
