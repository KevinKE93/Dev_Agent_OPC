---
name: spec-driven-development
description: Creates specs before coding. Use when starting a new project, feature, or significant change and no specification exists yet. Use when requirements are unclear, ambiguous, or only exist as a vague idea.
---

# Spec-Driven Development

## Overview

Write a structured specification before writing any code. The spec is the shared source of truth between you and the human engineer — it defines what we're building, why, and how we'll know it's done. Code without a spec is guessing.

This skill owns the lean product/spec merge. Capture product intent, MVP scope,
stories, acceptance criteria, useful metrics, technical constraints, and any
AI-agent runtime contract in one pass. Do not create separate PM or agent
phases. The required outputs are `dev-agent/product/PRD.md` and
`dev-agent/specs/SPEC.md`.

Keep the split crisp: `PRD.md` owns users, scope, flows, product rules,
acceptance, metrics, and non-goals. `SPEC.md` owns architecture, data,
interfaces, commands, tests, privacy/security boundaries, risks, and open
technical decisions.

In Dev Agent projects, this skill owns `<project-name>/dev-agent/specs/SPEC.md`.
Do not create implementation artifacts from this skill; hand off to
`design-flow` for customer-facing UI and then `incremental-implementation`.

## When to Use

- Starting a new project or feature
- Requirements are ambiguous or incomplete
- The change touches multiple files or modules
- You're about to make an architectural decision
- The task would take more than 30 minutes to implement

**When NOT to use:** Single-line fixes, typo corrections, or changes where requirements are unambiguous and self-contained.

## Lifecycle Boundary

Spec work has one gate here: produce and validate `dev-agent/product/PRD.md`
and `dev-agent/specs/SPEC.md`. The broader Dev Agent lifecycle continues
through design, build, optional QA, and optional ship.

```
IDEA INPUTS ──→ PRD + SPEC ──→ design when UI applies ──→ build
```

### Phase 1: Specify

Start with a high-level vision. Ask the human clarifying questions until requirements are concrete.

If product artifacts already exist, reuse them. Otherwise write the minimum PRD:
objective, target user, MVP scope, acceptance criteria, non-goals, and metrics
only when they affect build or QA decisions. Flag conflicts instead of silently
changing product scope.

If external references are provided, absorb them structurally:

- Extract reusable decisions into PRD/SPEC sections.
- Reject or flag unsafe anti-patterns, such as floating-point money, overlarge
  P0 scope, silent financial deletion, automatic posting without confirmation,
  or paywalling platform-provided system capability as if it were proprietary.
- Record conflicts and source differences instead of pasting long reference
  text into the spec.

**Surface assumptions immediately.** Before writing any spec content, list what you're assuming:

```
ASSUMPTIONS I'M MAKING:
1. This is a web application (not native mobile)
2. Authentication uses session-based cookies (not JWT)
3. The database is PostgreSQL (based on existing Prisma schema)
4. We're targeting modern browsers only (no IE11)
→ Correct me now or I'll proceed with these.
```

Don't silently fill in ambiguous requirements. The spec's entire purpose is to surface misunderstandings *before* code gets written — assumptions are the most dangerous form of misunderstanding. If the workspace instructions explicitly delegate defaults, record those assumptions in the spec and continue unless the issue is a named human review gate.

**Write a PRD and spec covering these core areas:**

1. **Objective** — What are we building and why? Who is the user? What does success look like?

2. **Commands** — Full executable commands with flags, not just tool names.
   ```
   Build: npm run build
   Test: npm test -- --coverage
   Lint: npm run lint --fix
   Dev: npm run dev
   ```

3. **Project Structure** — Where source code lives, where tests go, where docs belong.
   ```
   <project-name>/           → Project root for code and stack manifests
   <project-name>/src/       → Simple source root when a monorepo is unnecessary
   <project-name>/apps/      → Runnable app packages when the stack needs them
   <project-name>/packages/  → Shared packages when the project needs them
   <project-name>/dev-agent/ → Dev Agent process artifacts
   <project-name>/dev-agent/specs/     → Product and technical specs
   <project-name>/dev-agent/tasks/     → Plans and task lists
   apps/web/src/           → Application source code
   apps/web/src/components → React components
   apps/web/src/lib        → Shared utilities
   apps/web/tests/         → Unit and integration tests
   apps/web/e2e/           → End-to-end tests
   docs/                   → Project documentation
   ```

4. **Code Style** — One real code snippet showing your style beats three paragraphs describing it. Include naming conventions, formatting rules, and examples of good output.

5. **Testing Strategy** — What framework, where tests live, coverage expectations, which test levels for which concerns.

6. **Agent Runtime Contract** — Only when agent automation is in scope. Define
   the agent job, non-goals, tools, permissions, approval points, prompts,
   skills/context, memory/checkpoints, evals, observability, and failure
   recovery/escalation. If a tool, permission, or recovery path is unclear,
   raise it instead of inventing a workaround.

7. **Boundaries** — Three-tier system:
   - **Always do:** Run tests before commits or checkpoints, follow naming conventions, validate inputs
   - **Ask first:** Database schema changes, adding dependencies, changing CI config, high-risk architecture, security/payment/permission/data-deletion behavior, production launch approval
   - **Never do:** Commit secrets, edit vendor directories, remove failing tests without approval

For customer-facing products, also cover product-domain depth where applicable:
information architecture, onboarding, default data, feature field matrices,
states/errors, permissions/privacy copy, monetization/paywall rules, analytics
events, non-functional requirements, and version boundaries. Keep it lean, but
make design/build-ready decisions visible.

Also decide design applicability. If the work touches UI, visual direction,
brand/KV, screen states, or motion, mark design as required and hand off to
`design-flow`. If the work has no user-facing UI or design is already complete
and build-ready, record why design can be skipped or considered complete. When
the decision changes lifecycle behavior, update `dev-agent/state/applicability.env`
instead of leaving build to guess.

**Minimum PRD template:**

```markdown
# PRD: [Project/Feature Name]

## Objective

## Users And Jobs

## MVP Scope

## Core Flows / Information Architecture

## Acceptance Criteria

## Non-Goals

## Metrics / Guardrails
```

**Spec template:**

```markdown
# Spec: [Project/Feature Name]

## Objective
[What we're building and why. User stories or acceptance criteria.]

## Tech Stack
[Framework, language, key dependencies with versions]

## Commands
[Build, test, lint, dev — full commands]

## Data / Domain Model
[Entities, fields, invariants, persistence and sync-sensitive states]

## Interfaces / Integrations
[Public APIs, SDKs, permissions, auth providers, payments, background jobs]

## Project Structure
[Directory layout with descriptions]

## Code Style
[Example snippet + key conventions]

## Testing Strategy
[Framework, test locations, coverage requirements, test levels]

## UI / Design Applicability
[Whether UI/design applies, whether formal visual sources and HTML/CSS
companions are required, and whether existing design resources are build-ready.]

## Privacy / Security
[Data handling, permissions, deletion, secrets, compliance-sensitive choices]

## Agent Runtime Contract
[Only when agent automation is in scope: job, tools/permissions, approval
points, prompts/skills/context, memory/checkpoints, evals, operations, and
failure recovery/escalation.]

## Boundaries
- Always: [...]
- Ask first: [...]
- Never: [...]

## Success Criteria
[How we'll know this is done — specific, testable conditions]

## Open Questions
[Anything unresolved that needs human input]
```

**Reframe instructions as success criteria.** When receiving vague requirements, translate them into concrete conditions:

```
REQUIREMENT: "Make the dashboard faster"

REFRAMED SUCCESS CRITERIA:
- Dashboard LCP < 2.5s on 4G connection
- Initial data load completes in < 500ms
- No layout shift during load (CLS < 0.1)
→ Are these the right targets?
```

This lets you loop, retry, and problem-solve toward a clear goal rather than guessing what "faster" means.

### Downstream: Design

For user-facing products, run `design-flow` before build. The design package
should define information architecture, interaction model, platform/HCI
requirements, and visual direction under `<project-name>/dev-agent/design/`.

Skip this phase only for non-UI work or tiny changes with no user-facing behavior.

Do not write design files from this skill; hand off once `SPEC.md` is clear.

### Downstream: Implement

Execute one build slice at a time with `incremental-implementation`. A separate
`tasks/PLAN.md` is optional; use it only when the slice cannot be held clearly
inside the spec and status ledger.

## Keeping the Spec Alive

The spec is a living document, not a one-time artifact:

- **Update when decisions change** — If you discover the data model needs to change, update the spec first, then implement.
- **Update when scope changes** — Features added or cut should be reflected in the spec.
- **Commit the spec** — The spec belongs in version control alongside the code.
- **Reference the spec in PRs** — Link back to the spec section that each PR implements.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "This is simple, I don't need a spec" | Simple tasks don't need *long* specs, but they still need acceptance criteria. A two-line spec is fine. |
| "I'll write the spec after I code it" | That's documentation, not specification. The spec's value is in forcing clarity *before* code. |
| "The spec will slow us down" | A 15-minute spec prevents hours of rework. Waterfall in 15 minutes beats debugging in 15 hours. |
| "Requirements will change anyway" | That's why the spec is a living document. An outdated spec is still better than no spec. |
| "The user knows what they want" | Even clear requests have implicit assumptions. The spec surfaces those assumptions. |

## Red Flags

- Starting to write code without any written requirements
- Asking "should I just start building?" before clarifying what "done" means
- Implementing features not mentioned in any spec or task list
- Making architectural decisions without documenting them
- Skipping the spec because "it's obvious what to build"

## Verification

Before proceeding to implementation, confirm:

- [ ] `product/PRD.md` exists with MVP scope and acceptance criteria
- [ ] UI/customer-facing PRDs cover core flows or IA, acceptance criteria, and non-goals
- [ ] `specs/SPEC.md` covers all core technical areas
- [ ] UI/customer-facing specs cover stack, commands, data/domain model, testing, privacy/security, and open questions
- [ ] Specs decide whether UI/design applies and whether design assets/packages are required or already build-ready
- [ ] External references were converted into structured decisions and unsafe reference patterns were flagged
- [ ] The human has reviewed and approved the spec, or workspace instructions explicitly delegate defaults and no human review gate is open
- [ ] Success criteria are specific and testable
- [ ] Boundaries (Always/Ask First/Never) are defined
- [ ] The spec is saved under `<project-name>/dev-agent/specs/`
- [ ] Project-specific app or source directories are under `<project-name>/`, not beside it
