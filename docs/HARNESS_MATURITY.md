# Harness Maturity Ladder

This ladder defines how Crisp Harness should grow from static instructions into
measurable collaboration infrastructure.

Levels are achieved only when their criteria can be inspected in repository
files, validation evidence, or future durable records. Do not claim a level
because the idea is documented; claim it when the repository can prove it.

## Levels

### H0 - Bare Environment

The model receives a prompt and may produce a patch, but the repository does not
tell agents how to classify, validate, or record work.

Criteria:

- No `AGENTS.md` harness section exists.
- No intake policy exists.
- No story, decision, validation, handoff, or trace artifact exists.

Current status:

- Passed. This repository is beyond H0.

### H1 - Scaffolding And Policy

The repository contains operating instructions, source-of-truth rules,
templates, risk lanes, and validation expectations. Agents can follow a
documented workflow, but most state is still maintained manually in markdown.

Criteria:

- `AGENTS.md` routes agents to the harness entrypoint docs.
- `docs/HARNESS.md`, `docs/WORK_INTAKE.md`, and `docs/ARCHITECTURE.md` exist.
- Story, decision, handoff, prototype, validation, and high-risk templates
  exist under `docs/templates/`.
- `docs/TEST_MATRIX.md` defines proof columns and status meanings.
- Existing-project adoption is explicitly supported.

Current status:

- Achieved. Crisp Harness v0 has the required policy, template, adoption, and
  validation files.

Activated responsibilities:

- Task specification.
- Context selection.
- Permissions.
- Project memory.
- Verification.

### H2 - Observable Operations

The repository has explicit observation rules. Agents can record what happened,
connect work to stories, name friction, and leave trace evidence with predictable
depth.

Criteria:

- `docs/TRACE_SPEC.md` defines per-task trace fields and quality tiers.
- `docs/HARNESS_COMPONENTS.md` maps files to harness responsibilities.
- `docs/CONTEXT_RULES.md` defines phase-by-lane retrieval rules.
- Normal and high-risk story work records trace-quality evidence in the story,
  handoff, validation report, or test matrix.
- Harness friction is either fixed directly or added to
  `docs/HARNESS_BACKLOG.md`.

Current status:

- Achieved. The markdown observation rules exist and are now complemented by the
  durable CLI adopted in H3.

Activated responsibilities:

- Task state.
- Observability.
- Failure attribution.
- Context selection.
- Entropy auditing.

### H3 - Durable State And Querying

Harness state can be queried without reading scattered markdown tables. Intake,
story, decision, backlog, and trace records have a structured durable
representation.

Criteria:

- A durable state design is accepted in a decision record before implementation.
- A local command or structured data store can query stories, proof status,
  decisions, backlog items, and traces.
- Existing markdown state can be imported or reconciled without losing
  target-project edits.
- The durable layer is optional for target projects until the installer and
  adoption story say otherwise.

Current status:

- Achieved locally. `crates/harness-cli/`, `scripts/schema/`, and
  `scripts/bin/harness-cli` provide a SQLite-backed durable layer. Markdown
  remains the policy and review surface, while `harness.db` stores local
  operational records.

Activated responsibilities:

- Task state.
- Project memory.
- Observability.
- Verification.

### H4 - Active Evaluation And Verification

The harness can consistently check whether selected work has the required proof
before it is marked implemented.

Criteria:

- A documented command or protocol selects the expected proof for a story and
  lane.
- Missing validation evidence is surfaced before the final response.
- Decision verification commands can be run or reviewed in batch.
- Evaluator reports connect findings to stories, proof rows, and trace evidence.

Current status:

- Partially achieved. `scripts/bin/harness-cli story verify`,
  `story verify-all`, and decision verification commands exist, but story proof
  expectations and evaluator reports still require human/agent judgment.

Activated responsibilities:

- Verification.
- Task state.
- Intervention recording.

### H5 - Self-Improving Harness

The harness uses traces, failure patterns, validation gaps, and backlog outcomes
to propose or apply safe improvements to itself.

Criteria:

- Repeated friction patterns are summarized into proposed harness changes.
- Proposed changes include predicted impact, risk, validation plan, and rollback
  criteria.
- Completed changes compare predicted impact with actual outcome.
- High-risk harness changes pause for human confirmation before changing source
  hierarchy, architecture direction, or validation requirements.

Current status:

- Partially achieved. `scripts/bin/harness-cli audit` and `propose` can surface
  drift and candidate improvements, but humans still review and accept
  structural harness changes.

Activated responsibilities:

- Entropy auditing.
- Failure attribution.
- Intervention recording.
- Permissions.

## Current Assessment

| Level | Status | Evidence |
| --- | --- | --- |
| H0 | Passed | Harness entrypoint docs, templates, and proof files exist. |
| H1 | Achieved | `AGENTS.md`, `docs/HARNESS.md`, `docs/WORK_INTAKE.md`, `docs/ARCHITECTURE.md`, `docs/templates/*`, and `docs/TEST_MATRIX.md`. |
| H2 | Achieved | `docs/TRACE_SPEC.md`, `docs/HARNESS_COMPONENTS.md`, `docs/CONTEXT_RULES.md`, and story/test-matrix trace expectations. |
| H3 | Achieved | `crates/harness-cli/`, `scripts/schema/`, `scripts/bin/harness-cli`, `harness.db`, and `docs/decisions/0018-local-durable-harness-cli.md`. |
| H4 | Partial | CLI story/decision verification commands exist; proof contracts still need evaluator judgment. |
| H5 | Partial | CLI audit/propose commands exist; human review remains required for accepted changes. |

## Review Checklist

Before claiming a maturity change:

- Name the level and the exact criteria met.
- Link the files or validation evidence that prove the claim.
- Update `docs/TEST_MATRIX.md` when the claim is an accepted harness behavior.
- Record any missing capability in `docs/HARNESS_BACKLOG.md`.
