# US-012 Existing-Project Adoption Guide

## Status

implemented

## Lane

normal

## Product Contract

The harness provides an agent-facing `docs/PROJECT_ADOPTION.md` guide for
incorporating Crisp Harness into existing projects without overwriting local
truth or assuming a blank slate.

## Relevant Product Docs

- `docs/PROJECT_ADOPTION.md`
- `docs/PROJECT_GOVERNANCE.md`
- `docs/HARNESS.md`
- `docs/templates/seed/AGENTS.md`
- `scripts/install-harness.sh`
- `docs/decisions/0016-existing-project-adoption-guide.md`

## Acceptance Criteria

- Existing-project adoption has a dedicated target-safe guide.
- The guide tells agents to inventory local README, docs, source folders,
  commands, tests, risks, and conventions.
- The guide tells agents to ask specific human questions when core context is
  missing.
- The guide tells agents to create or update the story backlog and create an
  adoption story packet.
- The guide tells agents to name the first real product, maintenance, or
  harness-adaptation story after adoption.
- The guide tells agents to use repository story packets for future accepted
  work instead of relying only on scattered external tickets.
- The guide treats repository story packets as the canonical work record and
  external tickets as optional links.
- The target-safe `AGENTS.md` source router links existing-project adoption to
  `docs/PROJECT_ADOPTION.md`.
- The installer includes `docs/PROJECT_ADOPTION.md`.
- Target installs receive target-safe `docs/stories/README.md` and
  `docs/stories/backlog.md` seeds.
- The guide does not scaffold app code, package scripts, CI, tests, or platform
  shells.

## Evaluator Contract

Evaluator acceptance criteria:

- A target install includes `docs/PROJECT_ADOPTION.md`.
- Target `AGENTS.md` points existing-project adoption work to the adoption
  guide.
- Target `docs/stories/README.md` presents stories as the local durable story
  system, canonical work record, and does not contain source-repository
  temporary-history language.
- Target `docs/stories/backlog.md` does not include source-repository epics such
  as `E01-harness-quality`.
- Existing-target install behavior remains create-missing, AGENTS augmentation,
  and skip-existing for other files.

Failure thresholds:

- Existing-project support remains only a principle with no operational guide.
- The guide tells agents to overwrite local truth or invent missing context.
- The installer omits the guide.

Expected proof level:

- document review
- shell syntax
- source validation script
- installer dry-run and temp-target install probe

Artifacts to inspect:

- `docs/PROJECT_ADOPTION.md`
- `docs/templates/seed/stories-README.md`
- `docs/templates/seed/stories-backlog.md`
- `docs/templates/seed/AGENTS.md`
- `scripts/install-harness.sh`
- temp target docs

## Design Notes

- Commands: `scripts/install-harness.sh`.
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: existing projects are first-class and local truth must be
  preserved.
- UI surfaces: none.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Shell syntax checks for harness scripts. |
| Integration | Temp-target install includes `docs/PROJECT_ADOPTION.md`. |
| E2E | Not applicable; no app workflow exists. |
| Platform | Local Bash execution. |
| Release | Remote installer validation deferred until publication hardening. |

## Harness Delta

Adds existing-project adoption guidance, routes target agents to it, and gives
target projects target-safe story README and backlog seeds.

## Evidence

- `bash -n scripts/install-harness.sh`
- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- Temp-target install confirmed `docs/PROJECT_ADOPTION.md` exists and target
  `AGENTS.md` links existing-project adoption to it.
- Temp-target install confirmed `docs/stories/README.md` comes from the
  target-safe seed and describes repository stories as the local durable story
  system.
- Temp-target install confirmed `docs/stories/backlog.md` comes from the
  target-safe seed and does not include source-repository epics.
