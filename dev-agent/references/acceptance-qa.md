# Acceptance QA

Use Acceptance QA when `AUTOMATED_QA` is required or when the user asks for a
hands-on validation pass after the requested implementation scope is complete.
It is part of the QA flow, not a separate lifecycle phase.

## Goal

Prove that a real user can complete the important flows and that random or
adversarial interaction does not expose crashes, blocking UI, broken state, or
obvious performance failure.

## Inputs

- Current user request, PRD/SPEC acceptance criteria, and build verification.
- `SCREEN_ACCEPTANCE.md` when UI applies.
- The runnable app, target device/browser/simulator, and host requirements.
- Known risks, blockers, and UI debt from the build phase.

## Lanes

### 1. Acceptance Navigator

Run deterministic user-like paths:

- Open the app from a clean start.
- Walk the core flows from acceptance criteria or screen acceptance.
- Exercise required states: empty, loading, error, retry, success, navigation,
  disabled actions, validation, and persistence when applicable.
- Record blocker, severe usability problem, missing state, console/runtime error,
  or mismatch that prevents completion.

Write findings to `reviews/FUNCTIONAL_TEST.md`.

### 2. Monkey Stability Runner

Run exploratory or random interactions:

- Repeated taps/clicks, route changes, back/forward, resize/rotate, text entry,
  invalid input, rapid submit, background/foreground, and repeated reloads.
- Watch for crash, blank screen, frozen UI, lost data, broken focus, runaway
  loading, severe jank, or unhandled error.
- Keep the test bounded. Stop when a blocking defect is found, the planned event
  count/timebox is reached, or the environment cannot continue.

Write findings to `reviews/MONKEY_TEST.md`.

## Subagent Split

When the host supports parallel agents, split only independent work:

- `acceptance-navigator`: deterministic flow walk and usability blockers.
- `monkey-stability-runner`: random/adversarial stability and performance risk.

The main host owns setup, shared environment safety, evidence merge, final
decision, and any follow-up fix planning.

## Evidence

Required when Acceptance QA runs:

- `reviews/FUNCTIONAL_TEST.md`
- `reviews/MONKEY_TEST.md`
- `reviews/ACCEPTANCE_QA.html`

Optional evidence:

- `reviews/acceptance-screenshots/` for blockers, exceptions, visible broken UI,
  or explicit user request.
- `reviews/BLOCKED_SCREENSHOT.md` when capture is impossible.

`ACCEPTANCE_QA.html` should summarize scope, device/runtime, flows, monkey
events, issue severity, screenshots, and final decision in a format a client can
open directly.

## Decision

- `PASS`: no P0/P1 issue and critical flows are proven.
- `PASS_WITH_DEBT`: only P2/P3 issues remain and they are recorded.
- `REQUEST_FIXES`: P0/P1 defect, unproven critical flow, crash, data loss,
  severe usability blocker, or weak evidence.
- `BLOCKED`: environment, permission, account, SDK, device, or missing decision
  prevents credible execution.

Use `technical-steward` when evidence looks too smooth, skips critical flows, or
does not justify final technical readiness.

