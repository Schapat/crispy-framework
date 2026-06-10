# Context Rules

Context rules help agents decide what to read, when to read it, and when to stop
reading. They are additive to `AGENTS.md` and `docs/WORK_INTAKE.md`.

The goal is not maximum context. The goal is enough relevant context to protect
the contract, make the change, and leave honest proof.

## Intake Phase

Read to classify the request, find the affected surface, and choose a lane.

| Document Or Source | Tiny | Normal | High-Risk |
| --- | --- | --- | --- |
| `README.md` | Must | Must | Must |
| `AGENTS.md` | Must | Must | Must |
| `docs/WORK_INTAKE.md` | Must | Must | Must |
| `docs/ADOPTION_STATUS.md` | Should | Must | Must |
| `docs/FIRST_ADOPTION.md` | Must when adoption is `not_started` | Must when adoption is `not_started` | Must when adoption is `not_started` |
| `docs/HARNESS.md` | Should | Must | Must |
| `docs/CONTEXT_RULES.md` | Skip unless routing is unclear | Should | Must |
| `docs/ARCHITECTURE.md` | Skip | Should for structural work | Must |
| Relevant product docs | Skip if unrelated | Must if product behavior changes | Must |
| Relevant stories or handoffs | Skip if unrelated | Must when work maps to them | Must |
| Relevant decisions | Skip | Should when rationale matters | Must |

## Planning Phase

Read to decide the smallest safe approach and expected proof.

| Document Or Source | Tiny | Normal | High-Risk |
| --- | --- | --- | --- |
| Files to edit | Must | Must | Must |
| Adjacent files with same pattern | Should | Must | Must |
| `docs/templates/story.md` | Skip | Must when creating/updating a story | Should |
| `docs/templates/high-risk-story/*` | Skip | Skip unless risk escalates | Must |
| `docs/TEST_MATRIX.md` | Should | Must | Must |
| `docs/HARNESS_COMPONENTS.md` | Skip | Should for harness improvements | Must for observability or policy changes |
| `docs/HARNESS_MATURITY.md` | Skip | Should for maturity claims | Must for maturity or process changes |
| `docs/HARNESS_BACKLOG.md` | Skip | Should if friction repeats | Must if changing harness behavior |
| `docs/TOOL_REGISTRY.md` | Skip | Should when CLI/tooling behavior changes | Must when tool access changes |

## Implementation Phase

Read while making the change. Keep this phase scoped to files that directly
affect the selected story or artifact.

| Document Or Source | Tiny | Normal | High-Risk |
| --- | --- | --- | --- |
| Files being changed | Must | Must | Must |
| Adjacent local patterns | Should | Must | Must |
| Relevant product docs | Skip for copy-only work | Must if behavior changes | Must |
| Relevant story packet | Skip if no story needed | Must | Must |
| Relevant templates | Skip | Should when adding docs | Must |
| `docs/ARCHITECTURE.md` | Skip | Should for structural changes | Must |
| Provider, API, or security docs | Skip | Should if touched | Must |
| Unrelated historical docs | Skip | Skip | Should only if they affect decisions |

## Validation Phase

Read to prove the change and avoid unsupported completion claims.

| Document Or Source | Tiny | Normal | High-Risk |
| --- | --- | --- | --- |
| Story acceptance criteria | Should | Must | Must |
| `docs/TEST_MATRIX.md` | Should | Must | Must |
| Validation section of story packet | Skip if no story | Must | Must |
| `docs/templates/validation-report.md` | Skip | Should for notable proof | Must |
| Relevant commands from README or scripts docs | Should | Must | Must |
| `docs/TRACE_SPEC.md` | Should | Must | Must |

## Trace Phase

Read to leave useful evidence for the next agent and reviewer.

| Document Or Source | Tiny | Normal | High-Risk |
| --- | --- | --- | --- |
| `docs/TRACE_SPEC.md` | Should | Must | Must |
| `docs/TEST_MATRIX.md` | Should | Must | Must |
| `docs/HARNESS_BACKLOG.md` | Skip | Should if friction occurred | Must |
| `docs/HARNESS_AUDIT.md` | Skip | Should when audit output informs the task | Must when entropy score changes |
| `docs/IMPROVEMENT_PROTOCOL.md` | Skip | Should when proposals are generated | Must when proposal workflow changes |
| Changed-file list from `git status --short` | Must | Must | Must |
| Validation command output | Should | Must | Must |
| Story packet or progress log | Skip if no story | Must | Must |
| `docs/HARNESS_COMPONENTS.md` | Skip | Should if attributing friction | Must if failure attribution is needed |

## Retrieval Triggers

| Trigger Condition | Action |
| --- | --- |
| Task changes harness policy, source hierarchy, risk classification, or validation requirements | Read `docs/HARNESS.md`, `docs/WORK_INTAKE.md`, `docs/ARCHITECTURE.md`, and relevant decisions; pause if direction is ambiguous. |
| Task makes a maturity, observability, trace quality, or component-coverage claim | Read `docs/HARNESS_COMPONENTS.md`, `docs/HARNESS_MATURITY.md`, and `docs/TRACE_SPEC.md`. |
| Task touches the durable CLI, schema, audit, tool registry, or proposal workflow | Read `docs/TOOL_REGISTRY.md`, `docs/HARNESS_AUDIT.md`, `docs/IMPROVEMENT_PROTOCOL.md`, `scripts/README.md`, and relevant schema or Rust files. |
| Task touches first adoption or existing-project setup | Read `docs/ADOPTION_STATUS.md`, `docs/FIRST_ADOPTION.md`, `docs/PROJECT_ADOPTION.md`, and `docs/agents/*` as needed. |
| Task touches installer payload | Read `scripts/install-harness.sh`, seed templates, target-safe decisions, and installer story evidence. |
| Task discovers repeated confusion, stale docs, or missing proof | Read `docs/HARNESS_BACKLOG.md`, record trace friction, and add a backlog item when the fix is out of scope. |
| Task touches auth, authorization, audit/security, data loss, or external providers | Treat as high-risk unless the human explicitly narrows scope. |
| Task is normal or high-risk and spans sessions | Create or update a story and leave a handoff under `docs/handoffs/`. |

## Token Budget Guidance

| Lane | Target Read Shape |
| --- | --- |
| Tiny | Entry docs plus the exact file being changed. |
| Normal | Entry docs, relevant product/story docs, proof expectations, and trace spec. |
| High-risk | Entry docs, architecture, relevant decisions, high-risk templates, validation docs, trace spec, and component/maturity docs when harness behavior changes. |

Budget rules:

- Prefer targeted `rg` searches over bulk reading.
- Read the smallest section that answers the current phase question.
- Escalate context when a retrieval trigger fires.
- Stop reading unrelated history once lane, affected files, and validation path
  are clear.
