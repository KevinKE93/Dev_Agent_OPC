# Dev Flow Native Adapter Workflow

This workspace packages `dev-agent` as the canonical workflow source and adds a
thin helper layer for project state, quality gates, adapter packaging, and direct
adapter installation.

## What Is Here

- `dev-agent/`: canonical workflow pack with skills, agents, commands, references, and platform docs.
- `dev-agent/commands/`: platform-neutral prompts for lifecycle and focused auxiliary flows.
- `dev-agent/dev-agent.manifest.json`: native flow, role, and gate index used by `/dev agent` and `/dev-agent`.
- `AGENTS.md`: local instruction layer telling agents how to use the pack here.
- `bin/dev-flow`: helper script for listing workflows, managing project state, checking host requirements, enforcing gates, packaging adapters, and installing adapters.
- `<project-name>/`: the runnable project root; development output and source files live here.
- `<project-name>/dev-agent/`: process-management artifacts, gates, specs, design handoff, reviews, and launch notes.

## Lifecycle Commands

The primary lifecycle is deliberately small:

```text
idea -> spec -> design -> build -> qa -> ship
```

`qa` and `ship` are optional unless the user or project applicability requires
them. Product, agent-contract, testing, and review checks are folded into
`spec`, `build`, `qa`, and `ship`; task-list planning is surfaced by `next` and
`plan`.
`technical-steward` is an optional quality role, not a seventh phase. Use it to
challenge `SPEC.md`, `tasks/TECHNICAL_PLAN.md`, implementation evidence,
too-smooth QA, and release readiness before the main host advances.

| Intent | Prompt alias | Native action | Loads |
|---|---|---|---|
| Refine a rough idea | `Use local flow: idea` | `/dev agent flow idea` | `idea-refine` |
| Write PRD + buildable spec | `Use local flow: spec` | `/dev agent flow spec` | `spec-driven-development` with agent contract when needed |
| Design the experience | `Use local flow: design` | `/dev agent flow design` | `design-flow` |
| Review task execution | `Use local flow: plan` | `/dev agent flow plan` | `bin/dev-flow plan` task queue and autonomy review |
| Implement a slice | `Use local flow: build` | `/dev agent flow build` | `incremental-implementation` with micro-plan and proof-first checks |
| Optional QA | `Use local flow: qa` | `/dev agent flow qa` | acceptance, monkey, visual, and quality review when required |
| Optional launch | `Use local flow: ship` | `/dev agent flow ship` | `shipping-and-launch` with technical stewardship when risk warrants it |

Stable native entrypoints:

```text
/dev agent flow <flow-name> [project-name]
/dev agent role <role-name> [task]
/dev agent next <project-name>
/dev agent check <gate-name> <project-name> [phase-or-options]
/dev-agent <action> ...
```

## Execution Navigator

`bin/dev-flow` is the runtime navigator. For existing project work, agents
should start with:

```bash
bin/dev-flow status <project-name>
bin/dev-flow next <project-name> [--brief|--phase-brief|--full]
bin/dev-flow plan <project-name>
bin/dev-flow task <project-name> <next|start|done|block> [task-id] [reason]
bin/dev-flow autonomy <project-name>
bin/dev-flow delegate <project-name>
```

`next` is layered to control context size. The default `--brief` output is an
L0 navigator with the immediate task, output, acceptance, proof command, gate,
plan review, and autonomy/heartbeat decision. Use `--phase-brief` when you need
the command, skill, load list, required outputs, blockers, and subagent
recommendations for a phase. Use `--full` for workflow-pack maintenance,
migration, or debugging the navigator itself. Load only the context named by the
selected brief layer instead of reading the workflow pack broadly.

## Project Lifecycle

Create one self-contained project folder before starting real work:

```bash
bin/dev-flow init <project-name> [--type ui|agent|api|library|docs]
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>          # default L0 navigator
bin/dev-flow next <project-name> --phase-brief
bin/dev-flow plan <project-name>
bin/dev-flow autonomy <project-name>
bin/dev-flow delegate <project-name>
bin/dev-flow phase <project-name> spec "Write PRD and SPEC"
bin/dev-flow verify-phase <project-name> spec
bin/dev-flow design-check <project-name>
bin/dev-flow phase <project-name> build "Build the first slice"
bin/dev-flow verify-phase <project-name> build
bin/dev-flow qa-check <project-name>      # only when QA is required
bin/dev-flow ship-check <project-name>    # only when shipping
```

`init` creates a visible process layer under `<project-name>/dev-agent/` plus
one hidden wrapper at `<project-name>/.dev-agent/bin/check`:

- `dev-agent/state/state.env`: current phase, active task, blockers, last verification
- `dev-agent/state/schema.env`: project schema version and project type
- `dev-agent/state/applicability.env`: optional gates such as `UI_FLOW`, `UI_REFERENCES`, `UI_DESIGN_ASSETS`, `AUTOMATED_QA`, `VISUAL_QA`, `SHIP_FLOW`, `AUTONOMY_LOOP`, `AUTONOMY_TASK_MODE`, `AUTONOMY_HEARTBEAT_ON_TASK_LIST`, and `SUBAGENTS`
- `dev-agent/context.md`: minimal context loading guidance
- `dev-agent/HOST_REQUIREMENTS.md`: host SDKs, CLIs, services, credentials, and permissions
- `dev-agent/state/autonomy.env`: lightweight counters and last-result state for autonomous continuation
- `.dev-agent/bin/check`: project gate wrapper
Process folders are created later by `bin/dev-flow next` or `bin/dev-flow phase`
when that phase becomes current: `dev-agent/ideas/`, `dev-agent/product/`,
`dev-agent/specs/`, `dev-agent/design/`, `dev-agent/tasks/`,
`dev-agent/reviews/`, and `dev-agent/ship/`. Source folders such as `src/`,
`app/`, `apps/`, or `packages/` stay in the project root.

`bin/dev-flow phase` only records state. By default it verifies all prior
applicable lifecycle phases before moving forward. Use `--force` only when you
intentionally record early state and will complete missing artifacts later.

`bin/dev-flow autonomy <project-name>` is the standalone continuation decision.
It tells a host whether to continue now, suggest a heartbeat interval, or stop
for a blocker/approval. `bin/dev-flow plan <project-name>` normalizes explicit
TODO lists or phase outputs into `dev-agent/tasks/TASKS.md`, writes
`dev-agent/tasks/EXECUTION_PLAN.md`, and returns `Plan Review: pass`, `pause`,
or `approval-required`. Multiple clear pending tasks enable 1-minute heartbeat
batches; a batch may contain more than one task only when tasks are low-risk and
share the same module boundary or proof path. `bin/dev-flow delegate <project-name>` is the standalone
subagent planner. It emits optional task packets for host clients that support
parallel agents; the main host remains responsible for integration and gates.
For UI build work, `bin/dev-flow ui-polish <project-name>` records the single
runtime visual pass budget. After that pass, P2/P3 polish is debt and only P0/P1
defects block the current task.

## Host Environment Contract

Host SDKs and services are machine capabilities, not project runtime files. Do
not install shared SDKs such as Xcode, Android SDK, Java/JDK, Docker,
Playwright browsers, Figma MCP, simulators, or package-manager caches inside
`<project-name>/`.

Record those requirements in `dev-agent/HOST_REQUIREMENTS.md`. Run
`bin/dev-flow env-check <project-name>` only before a build slice or ship scope
actually uses the host capability. Slow or permission-heavy setup should be a
separate environment-prep pass that audits the host and asks before installing or
starting shared services.

## UI Design And Build Gates

For customer-facing apps, ask whether the user has references: screenshots,
reference images, Figma exports, apps, websites, or competitors. If no reference
exists and the user has not delegated visual direction, ask for examples before
UI build. If the user delegates visual direction, create `dev-agent/design/REFERENCE_BOARD.md`
and use `bin/dev-flow design-check <project-name> --allow-no-reference`.

Do not require sketches or prototypes. If the task/spec is no-UI/no-UX/code-only,
set `UI_FLOW="disabled"` and proceed through spec/build gates. If UI/UX design
applies, run the formal contract. Satisfy `dev-agent/references/design-artifacts.md`
as the formal visual source plus HTML/CSS companion contract, and run
`bin/dev-flow design-check <project-name>`. Product-designer output is direction
only; Image Gen/GPT Image or Figma must provide high-fidelity design sources
before UI build. For Image Gen/GPT Image sources, every non-icon visual asset
must include a synchronized HTML/CSS companion; icon/logo/app-icon assets do not
need HTML. Briefs, product-designer prose, local prototypes, uploads, external
exports, design-system exports, and screenshots are not development resources by
themselves. When Figma is used, satisfy
`dev-agent/references/figma-handoff.md` and run
`bin/dev-flow figma-check <project-name>`.

Before UI build, run `bin/dev-flow design-check <project-name>`. During build,
think before coding: confirm the spec is clear, then create or update
`dev-agent/tasks/TECHNICAL_PLAN.md` before implementation. Spec records
product-level technical expectations; Build owns detailed platform/language,
client/web/backend architecture, componentization, MVVM/state, routing,
service/security, proof commands, and steward review triggers. Route blockers
back to spec/design/debug/security/host requirements instead of guessing.
Runtime visual inspection is a one-pass budget by default. Use it to catch P0/P1
issues, then record remaining P2/P3 details in `dev-agent/reviews/UI_DEBT.md` and advance
to the next implementation task.

## QA And Ship

QA is optional by default. Enable it with:

```bash
AUTOMATED_QA="required"
VISUAL_QA="required"
```

in `<project-name>/dev-agent/state/applicability.env`, or run it when the user
asks. Automated QA records `dev-agent/reviews/FUNCTIONAL_TEST.md`,
`dev-agent/reviews/MONKEY_TEST.md`, and `dev-agent/reviews/ACCEPTANCE_QA.html`;
visual QA records `dev-agent/reviews/VISUAL_COMPARISON.md` with `Overall score:
N/100`. Runtime screenshots are required only for exceptions, blocked flows, or
explicit user requests.

Do not enter QA automatically after each build slice. Run QA after the overall
requested implementation is complete, when these flags require it, or when the
user explicitly asks for QA evidence.

Ship is optional and centered on launch evidence, rollback, and go/no-go.
For production or any formal environment, ship evidence must use read-only or
rejection-only smoke checks unless the user explicitly approves a canary data
plan. Do not run smoke tests that create users, sessions, orders, files,
webhooks, billing syncs, or business records in production. Write-path smoke
belongs in test/staging and must have a cleanup command or documented cleanup
owner. Use `dev-agent/references/production-data-safety.md` as the governing
reference for release verification and destructive data reset decisions.

## Artifact Summary

| Phase | Required output |
|---|---|
| Idea | `dev-agent/ideas/idea-brief.md` |
| Spec | `dev-agent/product/PRD.md`, `dev-agent/specs/SPEC.md` |
| Design, when UI applies | `dev-agent/design/DESIGN.md`, `VISUAL_SYSTEM.md`, `SCREEN_ACCEPTANCE.md`, `DESIGN_ARTIFACTS.md`, formal visual sources, and HTML/CSS companion packages |
| Build | source under the project root, `dev-agent/tasks/TECHNICAL_PLAN.md`, `dev-agent/reviews/VERIFICATION.md` or `dev-agent/reviews/BLOCKED_BUILD.md`, UI implementation trace when UI applies, optional autonomy/delegation logs, `dev-agent/reviews/UI_DEBT.md` when polish remains |
| QA, when required | `dev-agent/reviews/FUNCTIONAL_TEST.md`, `MONKEY_TEST.md`, `ACCEPTANCE_QA.html`, `VISUAL_COMPARISON.md` as applicable |
| Ship, when requested | `dev-agent/ship/LAUNCH.md` with risk, rollback, and GO/NO-GO |

Only stop for human review at requirement confirmation, customer-facing visual
direction when no reference is available, high-risk architecture choices,
security/payment/permission/data-deletion behavior, and production launch
approval.

## Adapter Packaging

Generate a disposable adapter package:

```bash
bin/dev-flow package-adapters dist/dev-flow-native
```

Direct installs default to native mode: one `dev-agent` top-level skill,
`/dev agent` plus `/dev-agent` commands, and a `dev-agent-runtime/` folder under
the destination. Use `--mode full` only when you intentionally want every
internal workflow skill installed as a top-level skill.

```bash
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope project
bin/dev-flow install gemini --scope project
bin/dev-flow uninstall codex --scope user
```

After changing this workflow pack, run:

```bash
tests/dev-flow-smoke.sh
```
