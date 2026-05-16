---
name: dev-agent
description: 用精简流程帮你从想法进入 spec、design、build，并按需执行 QA 与发布门禁。
---

# Dev Agent

Use this as the single native entry skill for Dev Agent. The detailed
workflow skills, personas, commands, references, templates, and gates live in
the installed `dev-agent-runtime/` folder.

For existing project work, do not start by reading workflow Markdown. Locate the
runtime and run:

```bash
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
```

Treat `next` as the execution brief and load only the command, skill,
references, and project files it names. Use `bin/dev-flow autonomy <project-name>`
for the standalone heartbeat/continue decision and
`bin/dev-flow delegate <project-name>` for optional host subagent task packets.
Use `bin/dev-flow ui-polish <project-name>` to record the single UI runtime
visual pass before moving P2/P3 details to UI debt.

Prefer the visible entry:

- `/dev agent flow <flow-name> [project-name]`
- `/dev agent next <project-name>`
- `/dev agent check <gate-name> <project-name> [phase-or-options]`
- `/dev agent role <role-name> [task]`

Compatibility alias:

- `/dev-agent <action> ...`

Primary lifecycle flows are `idea`, `spec`, `design`, `build`, `qa`, and
`ship`. `qa` and `ship` are optional unless the user or project applicability
requires them.

Focused auxiliary flows include `figma-design`, `figma-library`, `debug`, `ui`,
`api`, `security`, and `code-simplify`.

Supported roles are `code-reviewer`, `product-designer`, `security-auditor`,
`technical-steward`, `test-engineer`, and `ui-quality-reviewer`. Invoke roles
only on explicit user request or when the current risk needs that specialist
view; lifecycle phases do not auto-require personas.

When command snippets are unavailable, locate the installed runtime in one of:

- `.codex/dev-agent-runtime/`
- `${CODEX_HOME:-$HOME/.codex}/dev-agent-runtime/`
- `.claude/dev-agent-runtime/`
- `$HOME/.claude/dev-agent-runtime/`

Then use `bin/dev-flow status <project-name>` and
`bin/dev-flow next <project-name>` to load the current execution brief. Use
`bin/dev-flow manifest`, `bin/dev-flow command <flow-name>`, and
`bin/dev-flow agent <role-name>` only when the brief or maintenance task calls
for them.
Installed runtime commands manage `<project-name>/` in the active
workspace/current shell directory, or in `DEV_FLOW_WORKSPACE_ROOT` when set.

Do not copy project-specific work into the install directory. Project artifacts
belong under `<project-name>/` in the active workspace.
