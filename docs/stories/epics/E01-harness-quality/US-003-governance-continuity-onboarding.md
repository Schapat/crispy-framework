# US-003 Governance Continuity And Agent Onboarding

## Status

implemented

## Lane

normal

## Product Contract

The harness presents itself as a general AI-agent project governance system.
It defines how a new project starts, how work intake is classified, how
unfinished work is paused and resumed, and how a new AI agent onboards into an
existing session or project.

## Relevant Product Docs

- `README.md`
- `AGENTS.md`
- `docs/HARNESS.md`
- `docs/PROJECT_GOVERNANCE.md`
- `docs/PROJECT_START.md`
- `docs/WORK_INTAKE.md`
- `docs/CONTINUITY.md`
- `docs/AGENT_ONBOARDING.md`
- `docs/handoffs/README.md`
- `docs/decisions/0004-governance-first-continuity.md`

## Acceptance Criteria

- The old feature-intake name is replaced with `docs/WORK_INTAKE.md`.
- The harness is described as governance-first rather than implementation-first.
- Project-start guidance defines what to capture before coding.
- Continuity guidance defines pause, resume, blocked, and handoff behavior.
- Agent onboarding guidance tells a new AI agent what to read and how to resume.
- Future TUI work is recorded as a backlog item, not scaffolded as a fake script.
- Installer allowlist includes the new reusable governance files.

## Evaluator Contract

Evaluator acceptance criteria:

- No stale operational references to the old feature-intake filename remain.
- New docs do not assume a specific product type or tech stack.
- Handoff and onboarding rules can be followed by a future agent without chat
  history.
- Installer dry-run and install probe include the new governance files.

Failure thresholds:

- New governance docs imply runnable TUI automation that does not exist.
- The installer omits core governance files.
- A resume flow still depends on chat memory rather than repository artifacts.

Expected proof level:

- document review
- platform shell syntax check for installer
- installer dry-run and temp-target install probe

Artifacts to inspect:

- `docs/PROJECT_GOVERNANCE.md`
- `docs/PROJECT_START.md`
- `docs/CONTINUITY.md`
- `docs/AGENT_ONBOARDING.md`
- `docs/handoffs/README.md`
- `scripts/install-harness.sh`

## Design Notes

- Commands: no new executable command.
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: governance artifacts are stack-neutral and should precede
  implementation.
- UI surfaces: future TUI proposed only in backlog.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Not applicable; documentation-only harness change. |
| Integration | Installer dry-run and temp-target install prove allowlist includes new files. |
| E2E | Not applicable until governance TUI exists. |
| Platform | `bash -n scripts/install-harness.sh`. |
| Release | Not applicable until release automation exists. |

## Harness Delta

Adds governance, project-start, continuity, handoff-index, and agent-onboarding
contracts. Renames feature intake to work intake.

## Evidence

- `bash -n scripts/install-harness.sh`
- `scripts/install-harness.sh --directory "$TMP" --yes --dry-run`
- `scripts/install-harness.sh --directory "$TMP" --yes`
- Search for operational references to the old feature-intake filename.
