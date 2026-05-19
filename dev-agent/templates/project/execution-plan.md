# Execution Plan: {{PROJECT}}

`bin/dev-flow plan {{PROJECT}}` records plan snapshots here before autonomous
execution. The plan review must pass before a heartbeat executes task batches.

## Policy
- Review before execute: required
- Heartbeat interval: 1m
- Safe Batch Policy: execute a batch of clear, low-risk tasks per heartbeat; stop before ambiguity, high-risk work, or failed proof.

## Plan Snapshots
