---
description: Normalize task records, review execution readiness, and prepare autonomous batches
---

Use this before autonomous execution when the request has multiple tasks or the
current phase has outputs but no task queue yet.

1. Run `bin/dev-flow plan <project-name>`.
2. Review `.dev-agent/tasks/TASKS.md` and `.dev-agent/tasks/EXECUTION_PLAN.md`.
3. Continue only when `Plan Review: pass`.
4. If the review pauses or requires approval, ask the user with the blocker.
5. When multiple clear pending tasks exist, use 1-minute heartbeat batches; each
   batch may contain more than one task only when the tasks are clear,
   low-risk, and share the same proof path.
6. Update task status with `bin/dev-flow task <project-name> start|done|block`.

