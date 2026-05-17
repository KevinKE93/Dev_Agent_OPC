---
name: frontend-ui-engineering
description: Use when building, modifying, or reviewing user-facing UI, responsive states, accessibility, visual fidelity, acceptance QA, monkey testing, or product-grade frontend polish.
---

# Frontend UI Engineering

Build production-quality interfaces that match the approved design contract,
respect platform conventions, and survive functional, exploratory, and visual
QA. The output should feel intentionally designed, not template-generated.

## Before Editing

- Inspect the existing stack, component conventions, design tokens, routing,
  state management, tests, and build commands.
- State assumptions, trade-offs, conflicts with platform conventions, and any
  missing design inputs before changing UI code.
- Choose the smallest implementation that satisfies the current planned batch.
- Keep source changes inside the project-local app/package unless shared code is
  explicitly required.

## Customer-Facing UI Gate

Do not start customer-facing UI implementation until these exist and pass for
the current scope:

- `<project-name>/.dev-agent/design/DESIGN.md`
- `<project-name>/.dev-agent/design/VISUAL_SYSTEM.md`
- `<project-name>/.dev-agent/design/SCREEN_ACCEPTANCE.md`
- `<project-name>/.dev-agent/tasks/IMPLEMENTATION_TRACE.md`
- `bin/dev-flow design-check <project-name>`

Also read these when applicable:

- `DESIGN_ARTIFACTS.md`, `DESIGN_IMAGE_DESCRIPTIONS.md`, `FIGMA_HANDOFF.md`,
  `design/approved/html/`, and `design/cut-assets/ASSET_MANIFEST.md` when
  required by the design contract

Satisfy `dev-agent/references/design-artifacts.md` and run
`bin/dev-flow design-check <project-name>`. When Figma is used, satisfy
`dev-agent/references/figma-handoff.md` and run
`bin/dev-flow figma-check <project-name>`. If required design inputs cannot be
confirmed, stop and return to design instead of implementing around a guess.

## Design Contract Boundary

- Implement from `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md`.
  Use formal assets and HTML/CSS design packages only through the design
  artifact contract.
- If a needed visual source, runtime asset, or acceptance decision is missing,
  return to design instead of guessing.

## Implementation Workflow

1. **Create a screen checklist**
   - Map each current `SCREEN_ACCEPTANCE.md` screen/state to implementation
    files, design contract inputs, and test evidence.
   - Keep `tasks/IMPLEMENTATION_TRACE.md` current as work progresses.

2. **Translate design into primitives**
   - Extract layout grid, breakpoints, spacing, typography, colors, component
     variants, icon/illustration usage, motion, and state rules.
   - Use approved HTML/CSS design packages as the clearest source for tokens,
     layout, responsive behavior, states, and motion. Adapt to the app stack
     deliberately instead of copying brittle static markup wholesale.
   - Preserve hierarchy first: navigation, primary action, grouping, density,
     responsive behavior, and required empty/loading/error/success states.
   - Adapt intentionally when platform conventions require it, and record the
     deviation in the trace or review artifact.

3. **Use local patterns**
   - Reuse existing components, tokens, icons, forms, data-fetching patterns,
     test helpers, and accessibility utilities.
   - Add abstraction only when it removes current duplication or matches an
     established local pattern.
   - Prefer composition and focused components over large configurable objects.

4. **Manage state simply**
   - Local state: component-only UI state.
   - Lifted state: a few sibling components.
   - URL state: filters, tabs, pagination, and shareable view state.
   - Server state: cached remote data.
   - Global store: genuinely app-wide client state.

5. **Build required states**
   - Implement default, empty, loading, error, success, disabled, selected,
     long-content, narrow-screen, and permission states when applicable.
   - Use realistic content so wrapping, truncation, overflow, and localization
     risks are visible during development.

6. **Finish the planned batch**
   - Complete the current screen set, task slice, or release-candidate scope
     recorded in `tasks/PLAN.md` or `tasks/IMPLEMENTATION_TRACE.md`.
   - Cheap local checks are fine per screen, but final visual scoring and broad
     runtime screenshot capture wait until the batch is implemented.
   - Mid-batch screenshots are only for blocked flows, exception evidence,
     regressions that need proof, or explicit user request.
   - Runtime visual inspection has a default one-pass budget. Record it with
     `bin/dev-flow ui-polish <project-name>` when it happens.
   - After that pass, only P0/P1 defects block the current task. Record P2/P3
     polish in `reviews/UI_DEBT.md` and advance to the next implementation task.

## UI Standards

- Use semantic design tokens before raw colors or one-off values.
- Keep spacing, radius, shadows, and type hierarchy consistent with the project.
- Avoid generic AI aesthetics: purple-heavy gradients, decorative blobs, stock
  card grids, nested cards, excessive shadows, and oversized hero layouts in
  utility products.
- Use stable responsive constraints for boards, grids, controls, counters,
  toolbars, and repeated tiles so labels, icons, hover states, and dynamic
  content do not shift layout.
- Do not let text overlap, clip, or overflow its control at mobile or desktop
  widths.
- Prefer native controls and semantic elements; icon-only buttons need labels.
- Use project icon libraries where available; do not substitute text glyphs when
  the approved design uses illustrated icons or product imagery.

## Accessibility

Use `references/accessibility-checklist.md` for detail. Minimum bar:

- Keyboard reaches every interactive element in a logical order.
- Focus states are visible and managed through dialogs, menus, and route changes.
- Inputs have labels; icon-only controls have accessible names.
- Normal text contrast is at least 4.5:1; large text and UI indicators meet 3:1.
- State is not communicated by color alone.
- Screen reader structure follows headings, landmarks, lists, form labels, and
  status regions.
- Motion, loading, and optimistic updates have fallbacks and recovery paths.

## Runtime Asset Handling

- Use `design/cut-assets/ASSET_MANIFEST.md` as the runtime asset source of truth
  when the design artifact contract requires it.
- If a runtime asset is missing or ambiguous, return to design.
- For mobile apps, replace default app icon, adaptive icon, and splash icon
  before release packaging when product assets are in scope.

## QA Gate

QA is optional unless `AUTOMATED_QA` or `VISUAL_QA` is required by
`.dev-agent/state/applicability.env` or the user asks for it. After implementing the
overall requested customer-facing UI scope:

1. Confirm every screen/state in the batch is implemented or marked blocked in
   `tasks/IMPLEMENTATION_TRACE.md`.
2. For `AUTOMATED_QA`, use `references/acceptance-qa.md`: run an Acceptance
   Navigator pass for critical flows and save `reviews/FUNCTIONAL_TEST.md`.
3. Run a Monkey Stability Runner pass across navigation, repeated actions,
   invalid inputs, resizing, state changes, and obvious performance risks; save
   `reviews/MONKEY_TEST.md`.
4. Summarize both automated QA lanes in `reviews/ACCEPTANCE_QA.html`; if host
   subagents are available, split the lanes and merge evidence in the main host.
5. When `VISUAL_QA` is required, compare the UI against the required design
   contract inputs; save `reviews/VISUAL_COMPARISON.md`.
6. `VISUAL_COMPARISON.md` must include `Overall score: N/100`, per-screen rows
   for every `SCREEN_ACCEPTANCE.md` screen, approved asset path, runtime
   surface, score, decision, differences, and final decision.
7. Review implementation quality before delivery: correctness, state coverage,
   accessibility, source boundaries, simplicity, security/privacy impact, and
   performance risk. Use specialist personas only when risk warrants it.
8. High-fidelity delivery requires at least 90/100 unless the user explicitly
   narrows scope or lowers the bar.
9. Capture runtime screenshots under `reviews/acceptance-screenshots/` or
   `reviews/visual-screenshots/` only when an exception, blocked flow, visible
   broken UI, or explicit user request requires screenshots.
10. Run `bin/dev-flow qa-check <project-name>` when QA is required.

Do not enter QA automatically after each build slice. Keep building until the
requested implementation is complete, then run QA only when required or requested.

Use `references/visual-qa-rubric.md` for detailed scoring.

## Red Flags

- Implementation starts before `design-check` and `IMPLEMENTATION_TRACE.md`.
- Required design artifact or Figma handoff contract evidence is missing.
- Required states are missing.
- Text overlaps, clips, or becomes unreadable at required breakpoints.
- Keyboard or screen-reader access is broken.
- UI ignores approved asset hierarchy, imagery, or icon direction.
- Visual comparison misses screens or scores below 90/100 for high-fidelity work.
- The agent keeps taking screenshots or using device/simulator time to tune P2/P3
  details after the UI polish budget is used.

## Verification

- `bin/dev-flow design-check <project-name>` passed before UI implementation.
- `tasks/IMPLEMENTATION_TRACE.md` maps screens to implementation targets and
  test evidence; formal asset fields may be `none` when not required.
- Required design artifact and Figma handoff contracts are satisfied.
- Required responsive states and accessibility states are implemented.
- Runtime has no known console/build errors.
- Functional, monkey, and visual comparison review files exist for
  customer-facing UI.
- Visual comparison covers every accepted screen and meets the required score.
- Screenshots exist only for recorded exceptions, blocked flows, or explicit
  user requests.
- `bin/dev-flow qa-check <project-name>` passes when QA is required.
