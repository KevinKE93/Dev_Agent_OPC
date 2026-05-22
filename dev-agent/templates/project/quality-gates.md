# Quality Gates: {{PROJECT}}

Project-specific verification belongs here. Keep commands runnable from this project folder and mirror them in `bin/check` when they become stable.

## Default Gate
- [ ] Required workflow folders exist only after their phase needs them
- [ ] Schema and status ledgers exist
- [ ] Context loading guidance exists
- [ ] Host SDKs, CLIs, services, credentials, and permissions are recorded in `dev-agent/HOST_REQUIREMENTS.md` when known
- [ ] Shared host SDKs are not downloaded into the `{{PROJECT}}/` runtime folder
- [ ] `bin/dev-flow env-check {{PROJECT}}` passes before the current build slice or ship scope uses host capabilities
- [ ] Reference intake exists for customer-facing UI work
- [ ] `dev-agent/references/design-artifacts.md` is satisfied when formal visual assets are required
- [ ] `dev-agent/references/figma-handoff.md` is satisfied when Figma is used
- [ ] `bin/dev-flow design-check {{PROJECT}}` passes before UI implementation, when UI applies
- [ ] `tasks/TECHNICAL_PLAN.md` exists before implementation and covers platform/language, client/web/backend applicability, state/routing/component strategy, security, build slice proof, and steward review decision
- [ ] `tasks/IMPLEMENTATION_TRACE.md` maps required UI screens to implementation targets and evidence, when UI applies
- [ ] Source Structure is recorded for UI-heavy or multi-file build slices

## Add When The Project Has Code
- [ ] Lint
- [ ] Type check
- [ ] Unit tests
- [ ] Build
- [ ] Browser or device smoke test, when user-facing
- [ ] Production/formal verification is read-only or rejection-only; write-path smoke ran only in test/staging and has cleanup evidence
- [ ] `bin/dev-flow ui-polish {{PROJECT}}` recorded if a runtime visual pass was used
- [ ] P2/P3 UI polish is recorded in `reviews/UI_DEBT.md` and does not block the current build task
- [ ] Feature modules, containers, presentational views, shared primitives, and state/service boundaries are split or exceptions are recorded
- [ ] Functional flow test, when `AUTOMATED_QA` is required
- [ ] Monkey or exploratory stress test, when `AUTOMATED_QA` is required
- [ ] Visual comparison score is at least 90/100 against required design contract inputs, when `VISUAL_QA` is required
- [ ] `bin/dev-flow doctor {{PROJECT}}`, before delivery
- [ ] `bin/dev-flow qa-check {{PROJECT}}`, before delivery only when QA is required
