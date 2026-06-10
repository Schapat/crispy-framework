# US-014 Observable Harness Operations

## Status

implemented

## Lane

normal

## Execution Mode

AFK

Human needed for:

- Review before any future durable state or CLI implementation.

Ready for agent when:

- Scope stays docs-only and preserves Crisp's markdown-first operating model.

Blocked by:

- None.

## Product Contract

Crisp Harness should make harness maturity, context retrieval, trace evidence,
and friction attribution explicit without introducing a durable database or CLI
until a later accepted story chooses that implementation path.

## Relevant Product Docs

- `docs/HARNESS.md`
- `docs/WORK_INTAKE.md`
- `docs/CONTEXT_RULES.md`
- `docs/TRACE_SPEC.md`
- `docs/HARNESS_COMPONENTS.md`
- `docs/HARNESS_MATURITY.md`

## Acceptance Criteria

- A maturity ladder names current and future harness levels.
- A component taxonomy maps harness responsibilities to files and gaps.
- A trace specification defines evidence fields and quality tiers.
- Context rules explain what to read by phase and lane.
- Durable state remains a documented future investigation, not implemented
  tooling.
- The installer payload includes the new target-safe observability docs.

## Evaluator Contract

Evaluator acceptance criteria:

- The new docs are Crisp-specific and do not mention the experimental repo as
  an upstream dependency.
- The router points future agents to the new docs only when relevant.
- No application source, package scripts, CI, database, or CLI is scaffolded.

Failure thresholds:

- A durable state implementation appears without a separate accepted story.
- The source-of-truth hierarchy changes without a decision.
- Trace requirements contradict `docs/WORK_INTAKE.md`.

Expected proof level:

- document review | integration | platform

Artifacts to inspect:

- `docs/HARNESS_MATURITY.md`
- `docs/HARNESS_COMPONENTS.md`
- `docs/TRACE_SPEC.md`
- `docs/CONTEXT_RULES.md`
- `docs/TEST_MATRIX.md`
- `scripts/install-harness.sh`

## Design Notes

- Commands: `bash -n scripts/install-harness.sh`
- Queries: `rg` checks for linked docs and installer payload.
- API: none.
- Tables: none.
- Domain rules: docs-only observability precedes durable state.
- UI surfaces: none.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Not applicable; markdown-only change. |
| Integration | Installer syntax and payload reference checks. |
| E2E | Not applicable. |
| Platform | Dry-run installer probe can confirm new docs are copied. |
| Release | Not applicable. |

## Harness Delta

Adds docs-only observability and maturity contracts inspired by the comparison
with `harness-experimental`, adapted to Crisp's governance, adoption, and
multi-agent workflow.

## Evidence

Trace:

- Task summary: Added docs-only observability, maturity, context, and trace
  contracts before durable state tooling.
- Input type: Harness improvement.
- Lane: normal.
- Agent: codex.
- Files read: `README.md`, `AGENTS.md`, `docs/WORK_INTAKE.md`,
  `docs/ADOPTION_STATUS.md`, `docs/FIRST_ADOPTION.md`,
  `harness-experimental-main` comparison docs, installer docs, seed templates.
- Files changed: `AGENTS.md`, `README.md`, `docs/HARNESS.md`,
  `docs/WORK_INTAKE.md`, `docs/README.md`, `docs/TEST_MATRIX.md`,
  `docs/HARNESS_BACKLOG.md`, `docs/stories/backlog.md`,
  `docs/templates/seed/AGENTS.md`, `docs/templates/seed/README.md`,
  `scripts/README.md`, `scripts/install-harness.sh`,
  `docs/CONTEXT_RULES.md`, `docs/TRACE_SPEC.md`,
  `docs/HARNESS_COMPONENTS.md`, `docs/HARNESS_MATURITY.md`,
  `docs/decisions/0017-docs-only-observability-before-durable-state.md`,
  and this story.
- Decisions made: keep durable state as a future investigation; add
  observability as markdown-first contracts; include new docs in target installs.
- Harness friction: previous normal-lane harness work had evaluation and
  handoff guidance, but no explicit trace-quality or component-attribution
  contract.
- Outcome: completed.

Validation:

- `bash -n scripts/install-harness.sh`
- `rg -n "CONTEXT_RULES|TRACE_SPEC|HARNESS_COMPONENTS|HARNESS_MATURITY" ...`
- `scripts/install-harness.sh --directory "$tmpdir" --dry-run`
- `scripts/install-harness.sh --directory "$tmpdir" --yes`
- Temp-target file checks confirmed `docs/CONTEXT_RULES.md`,
  `docs/TRACE_SPEC.md`, `docs/HARNESS_COMPONENTS.md`, and
  `docs/HARNESS_MATURITY.md` were installed.
