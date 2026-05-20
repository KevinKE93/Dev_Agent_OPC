---
description: Optionally prepare launch evidence, go/no-go decision, and rollback plan
---

Invoke the `shipping-and-launch` skill.

Prepare release evidence under `<project-name>/dev-agent/ship/`:

1. Run `bin/dev-flow env-check <project-name>`, then final lint, test, build, smoke, and packaging checks from project-local source paths.
2. Review code quality, security, test coverage, accessibility, infrastructure, and docs.
3. For non-trivial releases, use the `technical-steward`, `code-reviewer`, `security-auditor`, and `test-engineer` personas as independent review passes, then merge their reports in the main context.
4. Write launch notes, known risks, monitoring notes, and rollback steps.
5. Run `bin/dev-flow ship-check <project-name>`.
6. Produce a `GO` or `NO-GO` decision.

Ship is optional. Enter this flow only when the user/project requests release evidence or `SHIP_FLOW="required"`. Do not give a `GO` decision without a rollback plan.
