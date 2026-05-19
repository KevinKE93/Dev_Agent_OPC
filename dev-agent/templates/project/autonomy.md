# Autonomy Loop: {{PROJECT}}

Records autonomous-continuation decisions. `bin/dev-flow next {{PROJECT}}` is
the source of truth for the current recommendation; host clients decide whether
they can schedule heartbeat follow-ups.

## Current Policy
- AUTONOMY_LOOP:
- AUTONOMY_TASK_MODE:
- AUTONOMY_REVIEW_BEFORE_EXECUTE:
- AUTONOMY_HEARTBEAT_ON_TASK_LIST:
- AUTONOMY_BATCH_POLICY:
- HEARTBEAT_INTERVAL:
- AUTONOMY_MAX_CYCLES:
- AUTONOMY_STOP_ON:

## Cycle Log
| Time | Phase | Continue | Heartbeat | Batch policy | Action | Stop reason / blocker |
|---|---|---|---|---|---|---|
