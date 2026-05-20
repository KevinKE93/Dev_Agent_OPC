---
description: Write PRD and buildable SPEC before design or build
---

Invoke the `spec-driven-development` skill. Product and agent-contract thinking
belong inside this flow; do not create separate PM or agent phases.

Read the approved idea artifacts and create the lean product/technical source of
truth:

1. Define the objective, target users, and user-visible outcomes from the idea attribution table.
2. Write or update `<project-name>/dev-agent/product/PRD.md` as the product source: MVP scope, core flows or IA, feature rules, acceptance criteria, metrics when useful, and explicit non-goals.
3. For customer-facing products, cover the product domain enough for design/build: onboarding, default data, field matrices, states/errors, permissions/privacy, monetization, analytics, non-functional needs, and version boundaries when they apply.
4. Write `<project-name>/dev-agent/specs/SPEC.md` as the technical source: stack constraints, host needs, source boundaries, commands, data/domain model, interfaces, code style, test strategy, privacy/security boundaries, risks, success criteria, and open questions.
5. Absorb external references structurally: extract useful decisions, reject unsafe anti-patterns, and do not paste long reference text as the spec.
6. When agent automation is in scope, add `## Agent Runtime Contract` covering job, tools/permissions, approval points, prompts/skills/context, memory/checkpoints, evals, operations, and failure recovery/escalation.
7. For customer-facing UI, identify whether design references exist, whether visual direction is delegated, and what design decisions must be resolved before build.
8. If requirements are unclear or high-risk, raise the blocker to idea/spec or the user instead of guessing.

Confirm with the user before proceeding unless the user has explicitly delegated defaults.
