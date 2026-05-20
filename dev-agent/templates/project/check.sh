#!/usr/bin/env bash
set -euo pipefail

CONTROL_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_ROOT="$(cd "$CONTROL_ROOT/.." && pwd)"
if [[ -d "$PROJECT_ROOT/dev-agent/state" || -f "$PROJECT_ROOT/dev-agent/context.md" || -f "$PROJECT_ROOT/dev-agent/HOST_REQUIREMENTS.md" ]]; then
  PROCESS_ROOT="$PROJECT_ROOT/dev-agent"
  PROCESS_LABEL="dev-agent"
else
  PROCESS_ROOT="$CONTROL_ROOT"
  PROCESS_LABEL=".dev-agent"
fi

required_process_dirs=(state)
for d in "${required_process_dirs[@]}"; do
  [[ -d "$PROCESS_ROOT/$d" ]] || { echo "Missing directory: $PROCESS_LABEL/$d" >&2; exit 1; }
done

required_control_dirs=(bin)
for d in "${required_control_dirs[@]}"; do
  [[ -d "$CONTROL_ROOT/$d" ]] || { echo "Missing directory: .dev-agent/$d" >&2; exit 1; }
done

required_process_files=(state/state.env state/schema.env state/applicability.env context.md HOST_REQUIREMENTS.md)
for f in "${required_process_files[@]}"; do
  [[ -f "$PROCESS_ROOT/$f" ]] || { echo "Missing file: $PROCESS_LABEL/$f" >&2; exit 1; }
done

required_control_files=(bin/check)
for f in "${required_control_files[@]}"; do
  [[ -f "$CONTROL_ROOT/$f" ]] || { echo "Missing file: .dev-agent/$f" >&2; exit 1; }
done

if [[ -d "$PROCESS_ROOT/design" ]]; then
  for f in design/DESIGN.md design/VISUAL_SYSTEM.md design/SCREEN_ACCEPTANCE.md; do
    [[ -f "$PROCESS_ROOT/$f" ]] || { echo "Missing design file: $PROCESS_LABEL/$f" >&2; exit 1; }
  done
fi

echo "Default workflow gate passed for $(basename "$PROJECT_ROOT")."
