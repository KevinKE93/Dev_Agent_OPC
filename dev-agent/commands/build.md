---
description: Think through readiness, then implement the next build slice
---

Invoke the `incremental-implementation` skill. It owns lightweight planning and
proof-first verification inside the build flow. Use its development discipline:
think before coding, keep it simple, edit canonical sources, and map goals to
gates, proof commands, or blocker records.

Before coding, decide whether the build is ready:

1. Read `PRD.md`, `SPEC.md`, design handoff, nearby code/tests, and conventions.
2. Create/update `tasks/TECHNICAL_PLAN.md`; no implementation starts without it.
3. Detail platform/language choices, client/web/backend architecture applicability, state/routing/component strategy, security, and proof path.
4. State clarity, source boundary, module boundary, design readiness, and host needs.
5. Check `dev-agent/HOST_REQUIREMENTS.md`; run `env-check` only for the current slice.
6. Escalate missing clarity/assets/permissions/env/risk to the owning flow or user.
7. Run checks, record `dev-agent/reviews/VERIFICATION.md` or `BLOCKED_BUILD.md`, then `verify-phase build`.

Use `technical-steward` to challenge SPEC + TECHNICAL_PLAN when architecture, data, security, integration, or evidence risk is material.
