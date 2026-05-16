---
description: Run Dev Agent through the visible /dev agent entrypoint
---

Use this as `/dev agent <action> ...`.

Compatibility alias: `/dev-agent <action> ...`.

Stable ID: `dev-agent`.

For project work, `bin/dev-flow` is the execution navigator. Do not bulk-read Markdown or infer the phase manually. First run:

```bash
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
```

Then load only the command, skill, references, and project files named by
`next`. Use direct command/persona reads only when `next` asks for them or when
maintaining the workflow pack itself.

Supported actions:

- `flow <flow-name> [project-name]`: resolve the flow from `dev-agent/dev-agent.manifest.json`, then read `dev-agent/commands/<flow-name>.md` with `bin/dev-flow command <flow-name>` when available.
- `role <role-name> [task]`: resolve the role from `dev-agent/dev-agent.manifest.json`, then read the persona with `bin/dev-flow agent <role-name>` when available.
- `next <project-name>`: run `bin/dev-flow status <project-name>` and `bin/dev-flow next <project-name>`.
- `check <gate-name> <project-name> [phase-or-options]`: resolve the gate from `dev-agent/dev-agent.manifest.json`, then run the matching `bin/dev-flow` gate.

Primary lifecycle flows: `idea`, `spec`, `design`, `build`, `qa`, `ship`.

Focused auxiliary flows: `figma-design`, `figma-library`, `debug`, `ui`,
`api`, `security`, `code-simplify`.

Supported roles: `code-reviewer`, `product-designer`, `security-auditor`, `technical-steward`, `test-engineer`, `ui-quality-reviewer`. Invoke roles only on explicit user request or when the current risk needs that specialist view; lifecycle phases do not auto-require personas.

Runtime resolution:
1. Prefer project-local `bin/dev-flow`.
2. If unavailable, use an installed runtime at `.codex/dev-agent-runtime/bin/dev-flow`, `${CODEX_HOME:-$HOME/.codex}/dev-agent-runtime/bin/dev-flow`, `.claude/dev-agent-runtime/bin/dev-flow`, or the host adapter's `dev-agent-runtime/bin/dev-flow`.
3. Installed runtime commands read and write `<project-name>/` under the active workspace/current shell directory, or under `DEV_FLOW_WORKSPACE_ROOT` when that env var is set.

Do not create a new workflow. Load only the required context from the `next`
brief, write outputs under `<project-name>/`, run the listed gate, then
record the next lifecycle phase with `phase` after the gate passes.
