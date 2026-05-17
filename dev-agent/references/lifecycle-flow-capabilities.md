# Dev Agent Lifecycle Flow Capabilities

This reference answers three questions for each primary lifecycle flow:

- What capabilities does this flow own?
- How is it triggered?
- What gate proves the flow is complete?

Use `bin/dev-flow status <project-name>` and `bin/dev-flow next <project-name>`
as the runtime source of truth. Native commands such as
`/dev agent flow <flow-name> <project-name>` select the workflow. The command
loads the flow instructions, while `bin/dev-flow verify-phase`,
`design-check`, `qa-check`, and `ship-check` enforce the actual gates.

QA and Ship are optional by default. Design applies when the project has
customer-facing UI, visual direction, brand/KV, motion, or formal design
handoff needs.

`technical-steward` is a role, not a seventh lifecycle phase. In the first
version it is invoked by risk or user request and does not add a hard executable
gate.

| Flow | Primary job | Main command | Completion gate | Main roles |
|---|---|---|---|---|
| [Idea](#idea-flow) | Turn a rough request into a focused brief | `/dev agent flow idea` | `bin/dev-flow verify-phase <project> idea` | Main host, optional product design judgment |
| [Spec](#spec-flow) | Produce PRD and buildable SPEC | `/dev agent flow spec` | `bin/dev-flow verify-phase <project> spec` | Main host, optional technical/product/security/test judgment |
| [Design](#design-flow) | Produce build-ready UX and visual handoff | `/dev agent flow design` | `bin/dev-flow design-check <project>` | `product-designer` |
| [Build](#build-flow) | Implement verified slices in source code | `/dev agent flow build` | `bin/dev-flow verify-phase <project> build` and `bin/dev-flow check <project>` | Main host, optional `technical-steward`/reviewer/test/security roles |
| [QA](#qa-flow) | Run optional acceptance, monkey, visual, and quality QA | `/dev agent flow qa` | `bin/dev-flow qa-check <project>` when QA is required | `technical-steward`, `test-engineer`, `ui-quality-reviewer` |
| [Ship](#ship-flow) | Prepare release evidence, rollback, and GO/NO-GO | `/dev agent flow ship` | `bin/dev-flow ship-check <project>` | `technical-steward`, `code-reviewer`, `security-auditor`, `test-engineer` |

<a id="idea-flow"></a>
## Idea Flow / Idea 流程

**Owns**

- Clarifies target users, jobs to be done, outcome, and constraints.
- Expands and stress-tests a rough idea before it becomes a spec.
- Separates must-have scope from optional exploration.
- Records requirement attribution: user-stated inputs, agent inferences,
  product decisions, external constraints, and open confirmations.
- For customer-facing apps, asks for references or records whether visual
  direction is delegated.

**Triggers**

- A new project starts from a rough idea.
- The user asks to refine, ideate, stress-test, or shape a concept.
- `bin/dev-flow next <project-name>` reports `idea` as the next phase.
- Direct native call: `/dev agent flow idea <project-name>`.
- Local command context: `dev-agent/commands/idea.md` with
  `dev-agent/skills/idea-refine/SKILL.md`.

**Role capabilities**

- Main host owns this flow by default.
- Use [product-designer](../agents/product-designer.md) only when early
  customer-facing UX judgment, reference interpretation, or visual direction
  materially affects the brief.

**Completion gate**

- Required artifact:
  `<project-name>/.dev-agent/ideas/idea-brief.md`.
- The brief must capture the problem, recommended direction, attribution,
  assumptions, MVP scope, non-goals, and open questions.
- Gate command:
  `bin/dev-flow verify-phase <project-name> idea`.
- Do not enter development from Idea. Continue to Spec unless the task is
  trivial and explicitly outside the lifecycle.

<a id="spec-flow"></a>
## Spec Flow / Spec 流程

**Owns**

- Converts the idea brief into the product and technical source of truth.
- Writes `PRD.md` for objective, users, MVP scope, core flows or IA, acceptance
  criteria, metrics when useful, and non-goals.
- Writes `SPEC.md` for stack, commands, source boundaries, data/domain model,
  interfaces, code style, test strategy, privacy/security, risks, success
  criteria, and open questions.
- Decides whether UI/design applies and whether design assets are required,
  delegated, already sufficient, or not needed.
- Adds `Agent Runtime Contract` when agent automation is in scope: job,
  tools/permissions, approval points, prompts/skills/context,
  memory/checkpoints, evals, operations, and failure recovery/escalation.
- Absorbs external references structurally instead of pasting long reference
  text into the spec.

**Triggers**

- Idea is approved and the work is non-trivial.
- Requirements are ambiguous, architectural, multi-file, or likely to take more
  than a short isolated fix.
- The user asks for PRD, SPEC, architecture, or buildable planning.
- `bin/dev-flow next <project-name>` reports `spec` as the next phase.
- Direct native call: `/dev agent flow spec <project-name>`.
- Local command context: `dev-agent/commands/spec.md` with
  `dev-agent/skills/spec-driven-development/SKILL.md`.

**Role capabilities**

- Main host owns PRD and SPEC.
- Use [product-designer](../agents/product-designer.md) when product IA,
  onboarding, states, or visual direction needs specialist judgment.
- Use [technical-steward](../agents/technical-steward.md) when the spec makes
  a high-risk architecture, data model, permission, synchronization, AI-agent,
  cross-platform, or integration choice that should be challenged before build.
- Use [security-auditor](../agents/security-auditor.md) when the spec includes
  auth, permissions, secrets, payments, data deletion, PII, or other high-risk
  behavior.
- Use [test-engineer](../agents/test-engineer.md) when acceptance and coverage
  strategy are unclear.

**Completion gate**

- Required artifacts:
  `<project-name>/.dev-agent/product/PRD.md` and
  `<project-name>/.dev-agent/specs/SPEC.md`.
- For UI projects, PRD must cover MVP scope, core flows or IA, acceptance, and
  non-goals. SPEC must cover stack, commands, data/domain model, testing,
  UI/design applicability, privacy/security, and open questions.
- If agent automation applies, `SPEC.md` must include `Agent Runtime Contract`,
  tools/permissions, and failure recovery or escalation boundaries.
- Gate command:
  `bin/dev-flow verify-phase <project-name> spec`.

<a id="design-flow"></a>
## Design Flow / Design 流程

**Owns**

- Resolves customer-facing UX, visual direction, product structure, screen
  hierarchy, interaction states, and platform behavior before build.
- Runs reference intake for screenshots, apps, websites, Figma exports,
  competitor products, or delegated visual direction.
- Produces `DESIGN.md`, `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md`.
- Defines screen acceptance with requirement source, content, states,
  breakpoints, actions, accessibility, and visual acceptance.
- Decides whether formal design assets are needed and whether existing assets
  are build-ready.
- Uses high-fidelity HTML/CSS design packages as the preferred build handoff
  when formal design is required.
- Requires Image Gen / GPT Image provenance for final logo, app icon, brand/KV,
  and high-quality bitmap assets. Local SVG or canvas renders are drafts only.
- Handles Figma handoff when Figma is used.

**Triggers**

- Spec marks UI/design as required.
- The work touches customer-facing UI, visual direction, brand/KV, motion, or
  screen-state design.
- Existing design resources are missing, insufficient, or need build-ready
  translation.
- `bin/dev-flow next <project-name>` reports `design` as the next phase.
- Direct native call: `/dev agent flow design <project-name>`.
- Local command context: `dev-agent/commands/design.md` with
  `dev-agent/skills/design-flow/SKILL.md`.

**Role capabilities**

- [product-designer](../agents/product-designer.md) is the primary specialist
  for reference interpretation, UX judgment, IA, visual system, states, and
  missing design-resource decisions.
- Use Image Gen / GPT Image tooling for required identity and high-quality
  bitmap assets.
- Use Figma-specific flows only when the project needs a Figma handoff,
  reusable components, or a stronger visual QA baseline.

**Completion gate**

- Required artifacts when design applies:
  `<project-name>/.dev-agent/design/DESIGN.md`,
  `VISUAL_SYSTEM.md`, and `SCREEN_ACCEPTANCE.md`.
- Each screen in `SCREEN_ACCEPTANCE.md` must include `Requirement source:`.
- If references are required, reference assets or links must exist. If visual
  direction is delegated, `REFERENCE_BOARD.md` must exist.
- If formal design assets are required, the design artifact contract must be
  satisfied, including approved HTML/CSS packages and asset coverage when in
  scope.
- If Figma is used, `bin/dev-flow figma-check <project-name>` must pass.
- Main gate command:
  `bin/dev-flow design-check <project-name>`.

<a id="build-flow"></a>
## Build Flow / Build 流程

**Owns**

- Implements the smallest focused source slice that satisfies the current
  spec/design requirement.
- Checks readiness before coding: requirement clarity, source boundary, design
  readiness, host needs, permissions, and risk.
- Uses lightweight micro-plans only when the slice is too large to hold in the
  current response or status.
- Runs proof-first verification: tests, builds, lint, manual proof, or a
  recorded blocker when proof is not possible.
- Keeps process files under `.dev-agent/` and source/development output in the
  project root.
- For UI work, maps implemented screens and states to
  `IMPLEMENTATION_TRACE.md`.
- Records a one-pass runtime UI polish budget with `bin/dev-flow ui-polish`
  when visual inspection is needed; P2/P3 polish becomes `UI_DEBT.md` after the
  budget is used.
- Routes blockers back to spec, design, debug, security, host requirements, or
  the user instead of coding around missing decisions.

**Triggers**

- Spec is complete and design is complete or not applicable.
- The user asks to implement, build, code, fix, or continue a slice.
- `bin/dev-flow next <project-name>` reports `build` as the next phase.
- Direct native call: `/dev agent flow build <project-name>`.
- Local command context: `dev-agent/commands/build.md` with
  `dev-agent/skills/incremental-implementation/SKILL.md`.

**Role capabilities**

- Main host owns implementation and integration.
- [technical-steward](../agents/technical-steward.md) challenges final
  technical readiness when the build changes architecture, data/state,
  permissions, cross-module integration, UI/backend coupling, or agent runtime
  behavior, or when verification evidence is thin.
- [test-engineer](../agents/test-engineer.md) supports proof-first tests,
  coverage strategy, and bug reproduction tests.
- [code-reviewer](../agents/code-reviewer.md) reviews correctness,
  readability, architecture, security, performance, and regression risk.
- [security-auditor](../agents/security-auditor.md) is used when the slice
  touches auth, permissions, secrets, payments, PII, destructive behavior, or
  public attack surfaces.
- [ui-quality-reviewer](../agents/ui-quality-reviewer.md) is not a default
  build role; use it when implemented UI needs specialist visual QA before
  delivery.

**Completion gate**

- Source or development output exists under the project root, such as `src/`,
  `app/`, `apps/`, `packages/`, `server/`, or stack manifest files.
- Required evidence:
  `<project-name>/.dev-agent/reviews/VERIFICATION.md` or
  `<project-name>/.dev-agent/reviews/BLOCKED_BUILD.md`.
- For UI projects, `tasks/IMPLEMENTATION_TRACE.md` maps required screens,
  states, design inputs, and proof evidence.
- Host-dependent slices update `HOST_REQUIREMENTS.md` and run
  `bin/dev-flow env-check <project-name>` only when the current slice needs the
  host capability.
- Gate commands:
  `bin/dev-flow verify-phase <project-name> build` and
  `bin/dev-flow check <project-name>`.

<a id="qa-flow"></a>
## QA Flow / QA 流程

**Owns**

- Optional Acceptance QA, monkey/exploratory QA, visual QA, and quality risk
  review after the requested implementation scope is complete.
- Acceptance QA uses `acceptance-qa.md` to split deterministic user-flow
  validation from monkey stability validation.
- Functional evidence covers happy paths and recovery paths from acceptance
  criteria or `SCREEN_ACCEPTANCE.md`.
- Monkey/exploratory QA stresses navigation, repeated actions, invalid inputs,
  resizing, and state changes.
- Visual QA compares implemented UI against `DESIGN.md`, `VISUAL_SYSTEM.md`,
  `SCREEN_ACCEPTANCE.md`, approved assets, HTML/CSS design packages, cut
  assets, references, and required design inputs.
- Quality review covers correctness, state coverage, simplicity, boundaries,
  accessibility, security/privacy, and performance.
- Runtime screenshots are required only for exceptions, blocked flows, or
  explicit user requests.

**Triggers**

- `AUTOMATED_QA="required"` enables Acceptance QA: functional user-flow proof,
  monkey/exploratory stability proof, and an HTML evidence report.
- `VISUAL_QA="required"` enables visual comparison QA.
- The user explicitly asks for QA, visual comparison, extra validation, or
  review evidence.
- `bin/dev-flow next <project-name>` reports `qa` as the next phase only when
  QA is required by project applicability.
- Direct native call: `/dev agent flow qa <project-name>`.
- Local command context: `dev-agent/commands/qa.md` and
  `dev-agent/references/acceptance-qa.md` plus
  `dev-agent/references/visual-qa-rubric.md` when visual QA applies.

**Role capabilities**

- [test-engineer](../agents/test-engineer.md) owns test strategy, coverage
  analysis, Acceptance QA lanes, and proof-oriented verification.
- [ui-quality-reviewer](../agents/ui-quality-reviewer.md) owns visual
  comparison scoring, UI acceptance evidence, monkey evidence, responsive
  review, accessibility, and exception screenshot review.
- [technical-steward](../agents/technical-steward.md) reviews whether QA
  evidence is strong enough to trust final technical readiness and can send the
  task back to spec, design, build, debug, security, or the user.
- [code-reviewer](../agents/code-reviewer.md) can be used for quality review
  when implementation risk warrants it.
- [security-auditor](../agents/security-auditor.md) can be used when QA exposes
  security-sensitive risk.

**Completion gate**

- QA is skipped by `qa-check` when neither `AUTOMATED_QA` nor `VISUAL_QA` is
  required.
- When QA is required, `reviews/VERIFICATION.md` must exist and have substance.
- If `AUTOMATED_QA` is required:
  `reviews/FUNCTIONAL_TEST.md` and `reviews/MONKEY_TEST.md` must exist and have
  substance. `reviews/ACCEPTANCE_QA.html` is the human-readable QA evidence
  report and should be produced with the same pass.
- If `VISUAL_QA` is required for a UI project:
  `design/DESIGN.md`, `design/VISUAL_SYSTEM.md`,
  `design/SCREEN_ACCEPTANCE.md`, and `reviews/VISUAL_COMPARISON.md` must exist.
- `VISUAL_COMPARISON.md` must include `Overall score: N/100`; high-fidelity UI
  delivery requires at least `90/100` unless the user explicitly lowers the bar.
- `VISUAL_COMPARISON.md` must include `Compared Inputs`,
  `Screen Fidelity Matrix`, `Score Breakdown`, `Differences`, and `Decision`.
- If an exception or blocked-flow record exists, screenshot evidence must be
  under `reviews/acceptance-screenshots/` or `reviews/visual-screenshots/`, or
  `reviews/BLOCKED_SCREENSHOT.md` must explain why capture is impossible.
- Main gate commands:
  `bin/dev-flow verify-phase <project-name> qa` and
  `bin/dev-flow qa-check <project-name>`.

<a id="ship-flow"></a>
## Ship Flow / Ship 流程

**Owns**

- Optional release readiness, launch evidence, rollback plan, monitoring notes,
  known risks, and GO/NO-GO decision.
- Runs final project-local lint, test, build, packaging, and smoke checks that
  are appropriate for the release scope.
- Reviews code quality, security, test coverage, accessibility,
  infrastructure, docs, and operational risk.
- Uses staged rollout and feature-flag thinking when risk warrants it.
- For production or formal environments, uses read-only or rejection-only smoke
  evidence unless the user explicitly approves a canary data plan. Write-path
  smoke belongs in test/staging and needs cleanup evidence.

**Triggers**

- The user asks to release, ship, publish, deploy, prepare launch evidence, or
  make a GO/NO-GO decision.
- `SHIP_FLOW="required"` enables Ship as an applicable lifecycle phase.
- Existing `ship/LAUNCH.md` indicates release work is already in progress.
- `bin/dev-flow next <project-name>` reports `ship` as the next phase when Ship
  is required or already active.
- Direct native call: `/dev agent flow ship <project-name>`.
- Local command context: `dev-agent/commands/ship.md` with
  `dev-agent/skills/shipping-and-launch/SKILL.md`.

**Role capabilities**

- [code-reviewer](../agents/code-reviewer.md) reviews correctness,
  maintainability, architecture, performance, and regression risk before merge
  or release.
- [technical-steward](../agents/technical-steward.md) provides independent
  final quality sign-off by challenging the release plan, implementation story,
  evidence quality, accepted debt, and GO/NO-GO readiness.
- [security-auditor](../agents/security-auditor.md) reviews exploitable
  vulnerabilities, auth/authorization, data protection, secrets, infrastructure,
  and third-party integrations.
- [test-engineer](../agents/test-engineer.md) reviews test strategy, coverage
  gaps, and release proof.
- Main host merges specialist reports and owns the final GO/NO-GO decision.

**Completion gate**

- Required artifact:
  `<project-name>/.dev-agent/ship/LAUNCH.md`.
- `LAUNCH.md` must include release evidence, known risks, monitoring notes,
  rollback steps, and a GO or NO-GO decision.
- `bin/dev-flow ship-check <project-name>` verifies every applicable prior
  phase, then runs the project default check, `env-check`, and `qa-check` when
  QA is required.
- Do not give a GO decision without a rollback plan.
