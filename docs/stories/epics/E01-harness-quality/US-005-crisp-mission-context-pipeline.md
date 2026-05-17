# US-005 Crisp Mission Context Pipeline

## Status

implemented

## Lane

normal

## Product Contract

The harness defines a Crisp workflow that combines staged context artifacts with
mission-style agent roles. Humans and agents can move from intent to objective
research, design concept, structure outline, validation contract, mission plan,
worker handoff, and validator review without relying on chat memory or a single
monolithic implementation plan.

## Relevant Product Docs

- `AGENTS.md`
- `README.md`
- `docs/HARNESS.md`
- `docs/WORK_INTAKE.md`
- `docs/intake/README.md`
- `docs/EVALUATION.md`
- `docs/TEST_MATRIX.md`
- `docs/AGENT_ROLES.md`
- `docs/templates/seed/TEST_MATRIX.md`
- `docs/templates/seed/HARNESS_BACKLOG.md`
- `docs/decisions/0006-target-safe-installer-payload.md`
- `docs/templates/context-questions.md`
- `docs/templates/research-facts.md`
- `docs/templates/design-concept.md`
- `docs/templates/structure-outline.md`
- `docs/templates/validation-contract.md`
- `docs/templates/mission-plan.md`
- `docs/templates/handoff.md`

## Acceptance Criteria

- Core docs explain the Crisp workflow as staged context plus mission roles.
- Intake guidance routes normal and high-risk work through vertical slices when
  implementation exists.
- Evaluation guidance treats validation contracts as pre-implementation proof
  surfaces for normal, high-risk, long-running, or multi-agent work.
- Agent role guidance describes orchestrator, discovery, worker, and validator
  responsibilities without replacing `AGENTS.md` as the entrypoint.
- Template docs exist for questions, objective research, design concept,
  structure outline, validation contract, and mission plan.
- The installer allowlist includes reusable Crisp Harness files without copying
  this repository's historical decision records, matrix rows, or backlog items.
- Target installs receive seed `docs/TEST_MATRIX.md` and
  `docs/HARNESS_BACKLOG.md` files that do not reference source-repository
  stories or decisions.
- Core docs distinguish `docs/intake/` snapshots from living product truth.
- No app source, package scripts, CI, tests, or router automation are scaffolded.

## Evaluator Contract

Evaluator acceptance criteria:

- A new agent can understand the Crisp pipeline from repository artifacts.
- The workflow preserves the existing Harness v0 source hierarchy and
  governance-first stance.
- Multi-agent guidance requires serial writes and permits parallel read-only
  research or review.
- The validation contract is defined before implementation and is independent of
  worker-written code.

Failure thresholds:

- The docs imply `scripts/router.sh` or another mission runner exists when it
  does not.
- `AGENTS.md` stops being the single agent entrypoint.
- The change creates application implementation scaffolding.
- New templates duplicate existing handoff behavior instead of linking to it.

Expected proof level:

- document review
- shell syntax checks for harness scripts
- installer dry-run or install probe

Artifacts to inspect:

- `AGENTS.md`
- `README.md`
- `docs/HARNESS.md`
- `docs/WORK_INTAKE.md`
- `docs/EVALUATION.md`
- `docs/AGENT_ROLES.md`
- `docs/templates/`
- `scripts/install-harness.sh`

## Design Notes

- Commands: no new executable command.
- Queries: none.
- API: none.
- Tables: markdown tables only.
- Domain rules: Crisp Harness controls context, state transfer, and validation
  expectations before and during agent work.
- UI surfaces: none.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Not applicable; documentation-only harness change. |
| Integration | Installer dry-run and temp-target install prove allowlist includes new files. |
| E2E | Not applicable until mission orchestration exists. |
| Platform | `bash -n scripts/install-harness.sh`, `bash -n scripts/governance-intake`, `bash -n scripts/test-governance-intake.sh`. |
| Release | Not applicable until release automation exists. |

## Harness Delta

Adds lightweight Crisp context templates, compact mission role guidance,
serial-write guidance, and validation-contract guidance while keeping
orchestration automation in backlog until a selected story justifies it.

## Evidence

- `bash -n scripts/install-harness.sh`
- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- `scripts/install-harness.sh --directory "$TMP" --yes --dry-run`
- `scripts/install-harness.sh --directory "$TMP" --yes`
- Temp-target probe confirmed installer output includes:
  - `docs/templates/validation-contract.md`
  - `docs/templates/design-concept.md`
  - `docs/AGENT_ROLES.md`
  - `docs/decisions/README.md`
  - seed `docs/TEST_MATRIX.md` from `docs/templates/seed/TEST_MATRIX.md`
  - seed `docs/HARNESS_BACKLOG.md` from
    `docs/templates/seed/HARNESS_BACKLOG.md`
  - `docs/intake/README.md`
  - no copied `docs/decisions/000*.md` history files
- Installed payload creates 39 files after target-safe seed and intake README
  additions.
- Target `docs/TEST_MATRIX.md` does not reference `US-005` or
  `docs/decisions/0005...`.
- Target `docs/HARNESS_BACKLOG.md` is the blank seed template.
- Search for stale role-directory references returned no matches in the target
  install.
- Search for stale plan references to `FEATURE_INTAKE.md`, uppercase template
  paths, `HANDOFF_SUMMARY.md`, `Droid Whispering`, and `scripts/router.sh`
  found only intentional explanatory references in this story.
