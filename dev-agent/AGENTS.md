# Dev Agent Runtime Instructions

This directory is the canonical source for Dev Agent OPC skills, commands,
personas, references, templates, and native install metadata.

## Source Boundaries

- Canonical commands live in `commands/`.
- Host-specific command adapters live in `.claude/commands/` and `.gemini/commands/`.
- Workflow skills live in `skills/<name>/SKILL.md`.
- Specialist personas live in `agents/<role>.md`.
- Shared gates, checklists, and orchestration notes live in `references/`.
- Production/formal data safety rules live in
  `references/production-data-safety.md`.
- Project scaffolding lives in `templates/project/`.
- Native user-facing entry metadata lives in `dev-agent.manifest.json` and `native/skills/dev-agent/SKILL.md`.

Treat generated installs and package output as disposable. Do not make source
changes in `.codex/`, generated `.claude/`, generated `.gemini/`, `.openclaw/`,
`.opencode/`, or `dist/`.

## Runtime Model

Dev Agent exposes one primary visible entrypoint:

```text
/dev agent
```

The stable ID is `dev-agent`; `/dev-agent` remains a compatibility alias. Keep
the public command surface centered on `/dev agent` and let users describe goals
in natural language.

## Intent Mapping

Map user intent to the smallest useful flow:

- Idea clarification: `idea-refine`
- Product scope, PRD, user stories, acceptance, metrics, requirements,
  technical specification, and agent runtime contracts:
  `spec-driven-development`
- Customer-facing UI, visual direction, references, or screen acceptance: `design-flow`
- Build technical plans, slices, task slicing, and local proof: `incremental-implementation`
- Debugging or unexpected behavior: `debugging-and-error-recovery`
- UI implementation, optional Acceptance QA, and quality review: `frontend-ui-engineering`
- Security-sensitive work: `security-and-hardening`
- Release readiness: `shipping-and-launch`

For APIs or public module boundaries, include `api-and-interface-design`.
For architecture/data/security/integration risk, thin evidence, too-smooth QA,
or release readiness, include the `technical-steward` persona to challenge
`SPEC.md` and `tasks/TECHNICAL_PLAN.md`.

## Personas, Skills, And Commands

- Skills are the workflow: they define steps and exit criteria.
- Personas are the role: they provide perspective and output shape.
- Commands are the entrypoint: they route user intent into the right skill or persona.

Personas do not invoke other personas. Use parallel fan-out only when independent
reviews can run separately and then be merged by the main agent, such as release
review across technical stewardship, code, security, and test perspectives.

## Maintenance Rules

- Keep command wording short and install-friendly.
- Keep workflow details inside skills and references, not command files.
- Keep native entry descriptions user-facing and plain language.
- Preserve design and QA gates for customer-facing UI.
- Preserve design traceability: design must read idea/product/spec artifacts,
  and each `SCREEN_ACCEPTANCE.md` screen or global UI surface needs a
  `Requirement source:` line before UI build.
- Preserve host requirements as early-recorded but late-blocking: record likely
  needs during idea/spec/design, run `env-check` before current-slice
  host-dependent build/test work or before ship.
- Preserve project runtime folders as output rather than reusable workflow source.
- Preserve production data safety: production/formal verification must be
  read-only or rejection-only. Write-path smoke that creates users, sessions,
  orders, files, accepted webhooks, billing syncs, or business records belongs
  in test/staging and must include cleanup evidence.

After command, installer, or runtime changes, run `tests/dev-flow-smoke.sh` from
the repository root.
