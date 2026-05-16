# Dev Agent Personas

Specialist personas provide one role, one perspective, and one report shape.
They can be invoked directly by a user, routed by a Dev Agent command, or used by
a host that supports native subagents.

| Persona | Role | Best For |
|---------|------|----------|
| [code-reviewer](code-reviewer.md) | Senior Staff Engineer | Five-axis review before merge |
| [product-designer](product-designer.md) | Product Designer | Customer-facing UX, visual systems, references, and screen acceptance |
| [security-auditor](security-auditor.md) | Security Engineer | Vulnerability detection and risk review |
| [technical-steward](technical-steward.md) | Technical Quality Steward | Independent architecture, evidence, and final readiness challenge |
| [test-engineer](test-engineer.md) | QA Engineer | Test strategy, coverage analysis, and proof-oriented verification |
| [ui-quality-reviewer](ui-quality-reviewer.md) | UI Quality Reviewer | Visual comparison scoring, functional QA evidence, and exception screenshot review |

## Composition Rules

- Skills are the process: the how.
- Personas are the perspective: the who.
- Commands are the entrypoint: the when.

Personas do not invoke other personas. Do not call a persona just because a
phase exists; invoke one only when the user asks for that role or the current
risk needs that specialist view. If multiple reviews are needed, the main agent
or command should fan out to independent personas, collect reports, and merge the
go/no-go decision.

## Use Cases

- Use `product-designer` before customer-facing UI implementation when visual direction, reference intake, or screen acceptance is needed.
- Use `ui-quality-reviewer` before delivery for visual comparison, functional QA evidence, and exception-only screenshot review.
- Use `code-reviewer` for implementation risk, maintainability, correctness, and regression review.
- Use `security-auditor` for auth, permissions, secrets, payments, data deletion, and other high-risk surfaces.
- Use `technical-steward` for independent technical sign-off, architecture challenge, evidence review, and final quality gap analysis.
- Use `test-engineer` for missing coverage, test design, and verification strategy.

## Adding A Persona

1. Create `agents/<role>.md` with the same frontmatter style used by existing personas.
2. Define scope, responsibilities, output format, and hard boundaries.
3. End with a composition block that states when to invoke it directly and when not to.
4. Add the persona to the table above.
5. Document any new orchestration pattern in `references/orchestration-patterns.md`.
