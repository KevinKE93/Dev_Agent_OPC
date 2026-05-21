# Implementation Trace: {{PROJECT}}

Map required UI screens and states to concrete implementation targets before
build starts. Use `none` for asset/source fields when formal design packages are
not required. Non-UI projects may keep this file as a no-op trace. The `HTML
companion` column records the approved HTML/CSS design package path when one is
required.

## Screen Trace
| Screen | State | Implementation target | Approved asset | Design source | HTML companion | Cut assets | Test evidence | Status |
|---|---|---|---|---|---|---|---|---|

## Source Structure
Record the structure for UI-heavy or multi-file build slices so future agents
can load the feature-local files instead of the whole app.

| Feature/module | Container target | Presentational target(s) | Shared primitives | State/service/hooks | Proof command | Status |
|---|---|---|---|---|---|---|
