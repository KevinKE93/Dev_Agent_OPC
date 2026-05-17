# Context Loading: {{PROJECT}}

Load only the files needed for the current phase.

- Idea: read `ideas/` and relevant user notes.
- Spec: read the idea brief, existing product notes, relevant agent notes, and existing app files if present. Produce PRD + SPEC together, including UI/design applicability and an Agent Runtime Contract section when agent automation is in scope.
- Host environment: record likely host needs during idea/spec/design, but run `env-check` only before the current build/test slice or ship scope relies on machine-level SDKs, CLIs, services, credentials, simulators, or MCP connections.
- Design: read `ideas/idea-brief.md`, product artifacts (`PRD.md`, `USER_STORIES.md`, `ACCEPTANCE.md`, `METRICS.md`) when present, agent notes when present, `specs/SPEC.md`, reference intake, delegated reference board when present, user-provided references, existing screens, and platform constraints. Read formal package ledgers only when formal packages are required or already present.
- Build: think through clarity, architecture, environment needs, and design readiness first; then read the current build slice, implementation trace, required design docs/packages, nearby source files, tests, and `reviews/UI_DEBT.md` only when polish debt exists.
- QA: optional unless `AUTOMATED_QA` or `VISUAL_QA` is required; run after the overall requested implementation is complete or when the user asks. Read verification, acceptance/monkey logs, visual comparison, and exception screenshots only when needed.
- Ship: optional; read QA evidence, verification evidence, risks, rollback, and launch notes.

Do not bulk-load `dev-agent/` or unrelated project folders.
