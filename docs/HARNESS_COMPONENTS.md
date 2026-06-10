# Harness Components

This taxonomy names the responsibilities Crisp Harness is expected to cover.
Use it when diagnosing harness friction, deciding where a new rule belongs, or
turning repeated agent failures into backlog items.

Status values:

- **Covered**: explicit file, template, rule, or record exists.
- **Partial**: support exists but is manual, incomplete, or not measured.
- **Missing**: no meaningful support exists yet.

## Responsibility Map

| # | Responsibility | Status | Harness Surface | Gap |
| --- | --- | --- | --- | --- |
| 1 | Task specification | Covered | `AGENTS.md`, `docs/WORK_INTAKE.md`, `docs/templates/story.md`, `docs/templates/high-risk-story/*`, `docs/stories/*` | Keep story packets synchronized with product docs and proof rows. |
| 2 | Context selection | Covered | `AGENTS.md`, `docs/CONTEXT_RULES.md`, `docs/WORK_INTAKE.md`, `docs/ARCHITECTURE.md` | Future tooling could detect over-reading or missed required docs. |
| 3 | Project adoption | Covered | `docs/ADOPTION_STATUS.md`, `docs/FIRST_ADOPTION.md`, `docs/PROJECT_ADOPTION.md`, `docs/agents/*` | Adoption readiness is still manual. |
| 4 | Project memory | Covered | `docs/decisions/*`, `docs/GLOSSARY.md`, `docs/stories/*`, `docs/HARNESS_BACKLOG.md`, `docs/handoffs/*` | Future audits should find stale decisions and old handoffs. |
| 5 | Task state | Covered | `docs/stories/*`, `docs/TEST_MATRIX.md`, `docs/handoffs/*`, `scripts/bin/harness-cli query matrix`, `scripts/schema/*` | Keep markdown and durable records reconciled through import and story updates. |
| 6 | Observability | Covered | `docs/TRACE_SPEC.md`, story evidence, validation reports, handoffs, `scripts/bin/harness-cli trace`, `score-trace` | Trace quality can be scored, but agents still need to record honest fields. |
| 7 | Failure attribution | Partial | `docs/HARNESS_COMPONENTS.md`, `docs/TRACE_SPEC.md`, `docs/HARNESS_BACKLOG.md`, `docs/EVALUATION.md`, `scripts/bin/harness-cli query friction`, `query interventions` | CLI queries help surface patterns; human review still attributes root responsibility. |
| 8 | Verification | Partial | `docs/TEST_MATRIX.md`, `docs/EVALUATION.md`, `docs/templates/validation-contract.md`, `docs/templates/validation-report.md`, `scripts/bin/harness-cli story verify`, `decision verify` | Verification commands exist but cannot replace evaluator judgment about proof quality. |
| 9 | Permissions | Partial | `AGENTS.md`, `docs/HARNESS.md`, `docs/WORK_INTAKE.md`, `docs/ARCHITECTURE.md` | Rules are instruction-level, not enforced by tooling. |
| 10 | Entropy auditing | Covered | `docs/HARNESS_BACKLOG.md`, `docs/HARNESS_MATURITY.md`, trace friction rules, `scripts/bin/harness-cli audit`, `propose` | Humans still approve generated improvement proposals. |
| 11 | Intervention recording | Covered | `docs/TRACE_SPEC.md`, `docs/decisions/*`, `docs/handoffs/*`, `docs/EVALUATION.md`, `scripts/bin/harness-cli intervention add` | Intervention records are local to `harness.db` unless summarized into docs. |

## Agent Surface Map

| Surface | Crisp Equivalent | Status | Notes |
| --- | --- | --- | --- |
| System instructions | `AGENTS.md` plus governance docs | Covered | `AGENTS.md` stays the entrypoint; detailed policy lives under `docs/`. |
| Skills and procedures | `docs/templates/*`, `docs/WORK_INTAKE.md`, `docs/CONTEXT_RULES.md`, `docs/TRACE_SPEC.md` | Covered | Procedures are markdown-first and agent-readable. |
| Tool descriptions | `scripts/README.md`, installer docs, `docs/TOOL_REGISTRY.md` | Covered | The CLI exposes compiled and registered tools through `query tools`. |
| Tool implementations | `scripts/install-harness.sh`, `scripts/bin/harness-cli`, `crates/harness-cli/` | Covered | The installer and durable CLI are source utilities. |
| Middleware or enforcement | Intake workflow, risk lanes, source router | Partial | Policy guides behavior but does not enforce it at runtime. |
| Sub-agent coordination | `docs/AGENT_ROLES.md`, `docs/templates/mission-plan.md`, `docs/templates/handoff.md` | Covered | Crisp supports role separation without requiring a runner. |
| Long-term memory | Decisions, stories, handoffs, backlog, test matrix, `harness.db` | Covered | Markdown stays reviewable; the CLI provides queryable local state. |

## File Inventory

| File Or Folder | Primary Responsibility | Secondary Responsibilities |
| --- | --- | --- |
| `AGENTS.md` | Context selection | Task specification, permissions |
| `README.md` | Task specification | Project memory |
| `docs/HARNESS.md` | Task specification | Project memory, permissions |
| `docs/WORK_INTAKE.md` | Task specification | Context selection, permissions |
| `docs/CONTEXT_RULES.md` | Context selection | Task specification, observability |
| `docs/HARNESS_COMPONENTS.md` | Failure attribution | Entropy auditing, observability |
| `docs/HARNESS_MATURITY.md` | Entropy auditing | Verification, observability |
| `docs/TRACE_SPEC.md` | Observability | Failure attribution, intervention recording |
| `docs/PROJECT_START.md` | Task specification | Project adoption |
| `docs/PROJECT_ADOPTION.md` | Project adoption | Context selection |
| `docs/FIRST_ADOPTION.md` | Project adoption | Context selection |
| `docs/ADOPTION_STATUS.md` | Project adoption | Task state |
| `docs/agents/*` | Project adoption | Context selection |
| `docs/ARCHITECTURE.md` | Permissions | Context selection, verification |
| `docs/EVALUATION.md` | Verification | Failure attribution |
| `docs/TEST_MATRIX.md` | Verification | Task state |
| `docs/CONTINUITY.md` | Task state | Intervention recording |
| `docs/AGENT_ONBOARDING.md` | Context selection | Project memory |
| `docs/AGENT_ROLES.md` | Task specification | Context selection |
| `docs/decisions/*` | Project memory | Permissions |
| `docs/stories/*` | Task state | Verification, project memory |
| `docs/handoffs/*` | Intervention recording | Task state |
| `docs/HARNESS_BACKLOG.md` | Entropy auditing | Failure attribution |
| `docs/templates/*` | Task specification | Verification, intervention recording |
| `docs/TOOL_REGISTRY.md` | Tool access | Verification, task state |
| `docs/HARNESS_AUDIT.md` | Entropy auditing | Failure attribution |
| `docs/IMPROVEMENT_PROTOCOL.md` | Entropy auditing | Harness improvement workflow |
| `scripts/install-harness.sh` | Tool access | Permissions |
| `scripts/schema/*` | Task state | Project memory, observability |
| `scripts/bin/harness-cli` | Tool access | Task state, observability, verification |
| `crates/harness-cli/*` | Tool implementation | Durable state, query surfaces |

## Coverage Summary

| Status | Count |
| --- | --- |
| Covered | 8 |
| Partial | 3 |
| Missing | 0 |

Covered responsibilities:

- Task specification.
- Context selection.
- Project adoption.
- Project memory.
- Task state.
- Observability.
- Entropy auditing.
- Intervention recording.

Partial responsibilities:

- Failure attribution.
- Verification.
- Permissions.

## Use In Reviews

When a task exposes friction:

1. Name the affected responsibility.
2. Decide whether the fix is a small clarification, a story, or a backlog item.
3. Update `docs/HARNESS_BACKLOG.md` when the improvement is structural or out of
   scope for the current task.
4. Mention the component in trace evidence for normal and high-risk work.
