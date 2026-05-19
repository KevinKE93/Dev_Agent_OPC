<p align="center">
  <img src="assets/readme-hero.png" alt="Dev Agent OPC hero banner" width="100%">
</p>

<h1 align="center">Dev Agent OPC</h1>

<p align="center">
  <strong>Automatic Dev Agent from idea → spec → design → build → QA → ship</strong>
  <br>
  <strong>面向 OPC 与小型业务团队的精简自动化开发 Agent 工作流</strong>
</p>

<p align="center">
  <a href="#中文">中文</a>
  · <a href="#english">English</a>
  · <a href="#使用方式">使用方式</a>
  · <a href="#usage">Usage</a>
</p>

<p align="center">
  <a href="#发布日志"><img alt="Version" src="https://img.shields.io/badge/version-v0.11-blue.svg"></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-green.svg"></a>
  <a href="DEV_FLOW.md"><img alt="Dev Agent Runtime" src="https://img.shields.io/badge/dev--agent-runtime-111827.svg"></a>
  <img alt="Lean Flow" src="https://img.shields.io/badge/lean-flow-f97316.svg">
  <img alt="QA Optional" src="https://img.shields.io/badge/QA-optional-14b8a6.svg">
</p>

<p align="center">
  由 <strong>Kevin KE / laoke.ai</strong> 创建和维护，并与 <strong>Codex-5.5</strong> 协作完成。
  <br>
  Created and maintained by <strong>Kevin KE / laoke.ai</strong>, worked with <strong>Codex-5.5</strong>.
</p>

---

## 中文

Dev Agent OPC 是一套给 AI Coding Agent 使用的精简交付工作流。它把模糊想法推进到可验证输出：`idea → spec → design → build → QA → ship`。其中 QA 和 ship 默认可选，重点是先高效完成正确的 build 输出，再按需要增加质量证明和发布检查。

### 定位与价值

- **精简生命周期**：Spec 合并 PRD/产品范围，Build 内部完成必要的轻量任务拆解，去掉默认 PDCA 支流。
- **不硬干**：发现需求、设计、环境、权限或安全风险不足时，回到上一级 flow 或让用户决策。
- **设计更稳**：Design 不强制草图或原型；先问用户是否有参考，没有则基于 Spec 评估设计方案。高保真实现才要求 AI 可读的正式设计资产。
- **Build 优先**：Build 先判断需求/spec 清晰度、功能架构、design 资源和环境需求，再进入 coding。
- **QA 可选**：验收/monkey/视觉 QA 可由项目开关或用户要求开启，避免每次都生成重文档。

### 使用方式

安装后，从主入口开始：

```text
/dev agent
```

常见调用：

```text
/dev agent 帮我把这个产品想法梳理成 PRD 和 SPEC，然后进入 build。
/dev agent 这是一个 UI 项目，先检查 design 是否足够支持高保真实现。
/dev agent next my-project
/dev agent flow build my-project
/dev agent flow qa my-project
```

`bin/dev-flow` 是唯一执行导航器。已有项目不要先通读 Markdown；先运行：

```bash
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
```

默认 `next` 是 L0 navigator，只返回当前任务、验收、proof、gate、Plan
Review 和 autonomy/heartbeat 决策；需要阶段级上下文时再运行
`bin/dev-flow next <project-name> --phase-brief`，维护或排障流程包时才用
`--full`。只读取所选 brief 层明确要求的上下文。

本地使用：

```bash
bin/dev-flow init <project-name> --type ui
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
bin/dev-flow next <project-name> --phase-brief
bin/dev-flow plan <project-name>
bin/dev-flow autonomy <project-name>
bin/dev-flow delegate <project-name>
bin/dev-flow ui-polish <project-name>
bin/dev-flow phase <project-name> spec "Write PRD and SPEC"
bin/dev-flow phase <project-name> build "Build the first slice"
```

### 安装与更新

```bash
git clone https://github.com/KevinKE93/Dev_Agent_OPC.git
cd Dev_Agent_OPC

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

支持的 host：`codex`、`claude-code`、`gemini`、`openclaw`、`opencode`。

更新：

```bash
cd "/path/to/Dev_Agent_OPC"
git pull --ff-only
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

### 流程管控

- **主阶段**：idea、spec、design、build、qa、ship。

6 大步骤能力索引：

| 步骤 | 作用 | 流程与角色能力 |
|---|---|---|
| [Idea](dev-agent/references/lifecycle-flow-capabilities.md#idea-flow) | 把模糊想法收敛成可进入 spec 的问题、方向、范围和归因。 | 查看触发方式、产物、结束 gate 和可用角色 |
| [Spec](dev-agent/references/lifecycle-flow-capabilities.md#spec-flow) | 输出 PRD 与 buildable SPEC，明确产品、技术、测试、风险和 UI/design 适用性。 | 查看触发方式、产物、结束 gate 和可用角色 |
| [Design](dev-agent/references/lifecycle-flow-capabilities.md#design-flow) | 为 UI、视觉、品牌、动效和高保真实现生成 build-ready 设计交付。 | 查看触发方式、产物、结束 gate 和可用角色 |
| [Build](dev-agent/references/lifecycle-flow-capabilities.md#build-flow) | 在项目根目录实现最小可验证 slice，并记录 proof 或 blocker。 | 查看触发方式、产物、结束 gate 和可用角色 |
| [QA](dev-agent/references/lifecycle-flow-capabilities.md#qa-flow) | 按需执行验收、monkey/exploratory、视觉对比和质量风险检查。 | 查看触发方式、产物、结束 gate 和可用角色 |
| [Ship](dev-agent/references/lifecycle-flow-capabilities.md#ship-flow) | 按需准备发布证据、回滚方案、监控风险和 GO/NO-GO 决策。 | 查看触发方式、产物、结束 gate 和可用角色 |

- **目录边界**：`.dev-agent/` 存放 spec、design、tasks、reviews 等过程文件；项目根目录存放真实代码、配置和开发产物。
- **精简职责**：产品/PRD 与 agent contract 归入 Spec；轻量计划和 proof-first 归入 Build；测试与 review 归入 QA/Ship。
- **Idea 归因**：idea brief 记录用户明确需求、agent 推断、产品决策和待确认项，避免后续 spec 混淆来源。
- **Spec 门禁**：UI 项目的 PRD 需覆盖 MVP、核心流程/IA、验收和非目标；SPEC 需覆盖技术栈、命令、数据/领域模型、测试、UI/design 适用性、隐私/安全和未决问题。
- **设计实现方式**：正式设计交付以 `design-artifacts` 中的“正式高保真视觉源 + HTML/CSS companion”合同为准；product-designer 的输出只作为方向和要求，不作为开发资源。
- **设计门禁**：customer-facing UI 在 build 前运行 `design-check`；没有参考时需用户委托视觉方向或提供参考；正式设计源必须来自 Image Gen/GPT Image、Figma、设计师上传、外部设计工具或设计系统导出，HTML/CSS 只能作为 companion handoff；logo、app icon、品牌 KV 和高质量位图素材必须有 Image Gen / GPT Image 来源。
- **环境边界**：宿主机 SDK、模拟器、MCP、凭证和系统服务记录在 `HOST_REQUIREMENTS.md`，不混入项目 runtime。
- **分层 Brief**：`bin/dev-flow next` 默认输出 L0 navigator；`--phase-brief` 展开 command/skill/load/outputs；`--full` 用于流程维护和导航器排障。
- **任务规划**：`bin/dev-flow next` 和 `bin/dev-flow plan` 会把 TODO 或阶段输出整理进 `TASKS.md` / `EXECUTION_PLAN.md`，先做 Plan Review 再执行。
- **自主循环**：`AUTONOMY_LOOP` 默认给出 heartbeat 建议；多项清晰任务会启用 1 分钟安全批次 heartbeat，遇到 blocker、高风险审批或最终阶段已验证时停止。
- **Subagent 并行**：`SUBAGENTS` 默认给出可并行任务包；host 支持时可把 explorer、worker、verifier 等侧线任务交给子 agent。
- **技术质量制衡**：`technical-steward` 作为独立技术质量负责人，在高风险方案、证据不足、QA 过顺或发布前挑战架构、实现和验收证据，不新增第 7 阶段。
- **UI 打磨预算**：runtime visual pass 默认一次；P0/P1 阻塞当前任务，P2/P3 记录到 `UI_DEBT.md` 后继续推进。
- **QA 开关**：`AUTOMATED_QA="required"` 开启验收/monkey QA，并产出 `ACCEPTANCE_QA.html`；`VISUAL_QA="required"` 开启视觉 QA。

### 发布日志

- `v0.11`：新增 Acceptance QA 方法，把模拟用户验收和 monkey 稳定性测试收进 QA 流程，并输出 `ACCEPTANCE_QA.html` 作为可打开的验收证据。
- `v0.10`：新增 `technical-steward` 技术质量负责人角色，用于高风险方案、证据不足、QA 过顺和发布前的独立技术质量把关；补充 6 大流程能力索引文档。
- `v0.9`：新增 HTML/CSS 设计稿实现方式作为正式设计交付标准，提升 UI 还原度、验收效率和代码生成效率；优化未初始化项目的目录创建，避免在项目根目录生成空的过程文件夹。
- `v0.8`：新项目默认把过程管理文件放在 `.dev-agent/`，开发产出的代码和项目文件保留在项目根目录；`migrate` 可迁移旧 `.dev-flow` / root-level 过程目录。
- `v0.7`：强化 idea/spec 工作流；idea brief 增加需求归因表；Spec 明确 PRD 与 SPEC 分工、产品域展开清单、外部参考吸收规则，并为 UI 项目增加最小 spec 覆盖门禁。
- `v0.6`：收敛为 `idea → spec → design → build → QA → ship`；Spec 合并 PRD 和 agent contract；Build 合并轻量计划与 proof-first；QA/Ship 默认可选；移除默认 PDCA 支流。
- `v0.5`：支持 native 安装，并可在对话中通过 `/dev agent` 直接调用 Dev Agent；稳定 ID 为 `dev-agent`，保留 `/dev-agent` 作为兼容别名。
- `v0.4`：增加 schema v4、可选 QA/Ship、正式设计资产按需门禁，以及 `AGENT_CONTRACT`。
- `v0.3`：增加宿主机环境合同、`env-check`、schema v3，以及 host SDK / project dependency / runtime artifact 的边界。

---

## English

Dev Agent OPC is a lean delivery workflow for AI coding agents. It moves rough ideas into verifiable output through `idea → spec → design → build → QA → ship`. QA and ship are optional by default, so the workflow can reach correct build output quickly before adding heavier validation or launch work.

### Positioning And Value

- **Lean lifecycle**: Spec folds in product/PRD scope, Build handles lightweight task slicing, and PDCA is no longer a default branch.
- **Escalate instead of forcing**: unclear requirements, weak design inputs, missing host permissions, unavailable SDKs, and high-risk decisions route back to the owning flow or the user.
- **Cleaner design path**: Design does not require sketches or prototypes. Ask for references first; if none exist, evaluate direction from the spec or ask for delegated visual direction.
- **Build first**: Build starts by checking requirement clarity, architecture, design readiness, and environment needs, then codes the smallest slice.
- **Optional QA**: acceptance, monkey, and visual QA run when the project or user requires them.

### Usage

Installed entrypoint:

```text
/dev agent
```

Examples:

```text
/dev agent Turn this product idea into PRD + SPEC, then continue to build.
/dev agent This is a UI project. Check whether design is enough for high-fidelity implementation.
/dev agent next my-project
/dev agent flow build my-project
/dev agent flow qa my-project
```

`bin/dev-flow` is the only execution navigator. For an existing project, do not
start by reading Markdown broadly. Run:

```bash
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
```

The default `next` output is an L0 navigator with the current task, acceptance,
proof command, gate, plan review, and autonomy/heartbeat decision. Expand with
`bin/dev-flow next <project-name> --phase-brief` for command/skill/load/output
details, and use `--full` only for workflow maintenance or navigator debugging.
Read only the context required by the selected brief layer.

Local commands:

```bash
bin/dev-flow init <project-name> --type ui
bin/dev-flow status <project-name>
bin/dev-flow next <project-name>
bin/dev-flow next <project-name> --phase-brief
bin/dev-flow autonomy <project-name>
bin/dev-flow delegate <project-name>
bin/dev-flow ui-polish <project-name>
bin/dev-flow phase <project-name> spec "Write PRD and SPEC"
bin/dev-flow phase <project-name> build "Build the first slice"
```

### Install And Update

```bash
git clone https://github.com/KevinKE93/Dev_Agent_OPC.git
cd Dev_Agent_OPC

bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

Supported hosts: `codex`, `claude-code`, `gemini`, `openclaw`, `opencode`.

Update:

```bash
cd "/path/to/Dev_Agent_OPC"
git pull --ff-only
bin/dev-flow install codex --scope user
bin/dev-flow install claude-code --scope user
```

### Process Controls

- **Primary phases**: idea, spec, design, build, qa, ship.

Six-step capability index:

| Step | Purpose | Flow And Role Capabilities |
|---|---|---|
| [Idea](dev-agent/references/lifecycle-flow-capabilities.md#idea-flow) | Turn a rough idea into a spec-ready problem, direction, scope, and attribution brief. | View triggers, outputs, completion gates, and available roles |
| [Spec](dev-agent/references/lifecycle-flow-capabilities.md#spec-flow) | Produce PRD and buildable SPEC across product, technical, test, risk, and UI/design applicability. | View triggers, outputs, completion gates, and available roles |
| [Design](dev-agent/references/lifecycle-flow-capabilities.md#design-flow) | Produce build-ready design handoff for UI, visual direction, brand, motion, and high-fidelity implementation. | View triggers, outputs, completion gates, and available roles |
| [Build](dev-agent/references/lifecycle-flow-capabilities.md#build-flow) | Implement the smallest verified source slice in the project root and record proof or blockers. | View triggers, outputs, completion gates, and available roles |
| [QA](dev-agent/references/lifecycle-flow-capabilities.md#qa-flow) | Run optional acceptance, monkey/exploratory, visual comparison, and quality-risk checks. | View triggers, outputs, completion gates, and available roles |
| [Ship](dev-agent/references/lifecycle-flow-capabilities.md#ship-flow) | Prepare optional release evidence, rollback, monitoring risk, and GO/NO-GO decision. | View triggers, outputs, completion gates, and available roles |

- **Directory boundary**: `.dev-agent/` stores process files such as specs, design, tasks, and reviews; the project root stores real code, config, and development output.
- **Lean responsibilities**: product/PRD and agent contracts live in Spec; micro-planning and proof-first checks live in Build; testing and review live in QA/Ship.
- **Idea attribution**: idea briefs record user-stated needs, agent inferences, product decisions, and open confirmations so later specs do not blur source boundaries.
- **Spec gate**: UI project PRDs must cover MVP, core flows/IA, acceptance, and non-goals; SPEC files must cover stack, commands, data/domain model, testing, UI/design applicability, privacy/security, and open questions.
- **Design implementation format**: formal design handoff follows the formal high-fidelity visual source plus HTML/CSS companion contract in `design-artifacts`; product-designer output is direction and requirements only, not a development resource.
- **Design gate**: customer-facing UI runs `design-check` before build; missing references require user input or delegated visual direction; formal sources must come from Image Gen/GPT Image, Figma, designer upload, external design tooling, or design-system export, while HTML/CSS is companion handoff only; logo, app icon, brand KV, and high-quality bitmap assets require Image Gen / GPT Image provenance.
- **Environment boundary**: host SDKs, simulators, MCP servers, credentials, and services are recorded in `HOST_REQUIREMENTS.md` instead of project runtime output.
- **Task planning**: `next` and `plan` normalize TODO lists or phase outputs into `TASKS.md` / `EXECUTION_PLAN.md`, then require plan review before execution.
- **Autonomy loop**: `AUTONOMY_LOOP` suggests heartbeat continuation by default; multiple clear pending tasks enable 1-minute safe-batch heartbeats, and the loop stops on blockers, high-risk approval, failed review, or verified final phases.
- **Subagent parallelism**: `SUBAGENTS` suggests optional task packets so host clients can delegate explorer, worker, and verifier work when supported.
- **Technical quality challenge**: `technical-steward` acts as an independent quality steward for high-risk plans, thin evidence, too-smooth QA, or release readiness; it challenges architecture, implementation, and evidence without adding a seventh phase.
- **UI polish budget**: runtime visual passes default to one; P0/P1 blocks the task, while P2/P3 goes to `UI_DEBT.md` and work advances.
- **QA switches**: `AUTOMATED_QA="required"` enables acceptance/monkey QA and produces `ACCEPTANCE_QA.html`; `VISUAL_QA="required"` enables visual QA.

### Release Notes

- `v0.11`: Adds Acceptance QA as a QA method, pairing simulated user-flow acceptance with monkey stability testing and a directly openable `ACCEPTANCE_QA.html` evidence report.
- `v0.10`: Adds the `technical-steward` role for independent technical quality sign-off on high-risk plans, thin evidence, too-smooth QA, and release readiness; adds the six-step flow capability index.
- `v0.9`: Adds formal visual source plus HTML/CSS companion handoff rules to improve UI fidelity, review efficiency, and code-generation efficiency; fixes directory creation for uninitialized projects so empty process folders are not created at the project root.
- `v0.8`: Defaults process-management files to `.dev-agent/` while keeping development output and source files at the project root; `migrate` can move old `.dev-flow` and root-level process directories.
- `v0.7`: Strengthens the idea/spec workflow; adds requirement attribution to idea briefs; clarifies PRD/SPEC ownership, product-domain expansion, external-reference absorption, and minimum UI spec coverage gates.
- `v0.6`: Collapses the lifecycle to `idea → spec → design → build → QA → ship`; folds PRD and agent contracts into Spec; folds micro-planning and proof-first checks into Build; makes QA/Ship optional by default; removes the default PDCA branch.
- `v0.5`: Adds native installation and conversation-level invocation through `/dev agent`; the stable ID is `dev-agent`, with `/dev-agent` kept as a compatibility alias.
- `v0.4`: Adds schema v4, optional QA/Ship gates, demand-driven formal design assets, and `AGENT_CONTRACT`.
- `v0.3`: Adds the host environment contract, `env-check`, schema v3, and clear boundaries between host SDKs, project dependencies, and runtime artifacts.

---

## License

MIT. See [`LICENSE`](LICENSE).

## Acknowledgements / 致谢

Based on and extending [@AddyOsmani Agent Skills](https://github.com/addyosmani/agent-skills).
