---
description: Think through readiness, then implement the next build slice
---

Invoke the `incremental-implementation` skill. It owns lightweight planning and
proof-first verification inside the build flow. Use its development discipline:
think before coding, keep it simple, edit canonical sources, and map goals to
gates, proof commands, or blocker records.

Before coding, decide whether the build is ready:

1. Read `PRD.md`, `SPEC.md`, design handoff, nearby code/tests, and conventions.
2. State clarity, source boundary, design readiness, and host needs.
3. Escalate missing clarity/assets/permissions/env/risk to the owning flow or user.
4. Check `dev-agent/HOST_REQUIREMENTS.md`; run `env-check` only for the current slice.
5. Micro-plan/prove when useful, then implement the smallest focused slice.
6. Run checks, record `dev-agent/reviews/VERIFICATION.md` or `BLOCKED_BUILD.md`, then `verify-phase build`.

If implementation stalls, use `debugging-and-error-recovery`; if quality risk is high or evidence is thin, use `technical-steward` before delivery.
