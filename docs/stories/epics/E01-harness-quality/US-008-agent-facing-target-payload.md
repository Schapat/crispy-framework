# US-008 Agent-Facing Target Payload

## Status

implemented

## Lane

normal

## Product Contract

Target installs receive the AI-agent-facing markdown harness and templates, not
this source repository's helper scripts. The source repository keeps scripts for
framework development, validation, and future remote installer work.

## Relevant Product Docs

- `README.md`
- `docs/PROJECT_GOVERNANCE.md`
- `docs/PROJECT_START.md`
- `docs/intake/README.md`
- `docs/decisions/0011-agent-facing-target-payload.md`
- `scripts/install-harness.sh`
- `scripts/README.md`

## Acceptance Criteria

- Installer payload does not include `scripts/README.md`.
- Installer payload does not include `scripts/governance-intake`.
- Installer payload does not include `scripts/test-governance-intake.sh`.
- Target-installed docs do not imply `scripts/governance-intake` exists in the
  target project.
- Source repository scripts remain available for framework development and
  validation.
- Installer dry-run and real install still complete successfully.

## Evaluator Contract

Evaluator acceptance criteria:

- A target install creates no `scripts/` directory.
- Target-installed governance docs are agent-first and do not require a human
  command to begin project intake.
- Source validation scripts still pass in this repository.

Failure thresholds:

- The installer creates target helper scripts.
- Target docs tell humans to run a command that was not installed.
- Source validation scripts are removed or broken.

Expected proof level:

- document review
- shell syntax
- source validation script
- installer dry-run and temp-target install probe

Artifacts to inspect:

- `scripts/install-harness.sh`
- target install file tree
- `docs/PROJECT_START.md`
- `docs/PROJECT_GOVERNANCE.md`

## Design Notes

- Commands: `scripts/install-harness.sh`.
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: target payload is agent-facing; source helper scripts are
  source-repository tooling.
- UI surfaces: terminal installer output only.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Shell syntax checks for harness scripts. |
| Integration | Temp-target install creates no `scripts/` directory. |
| E2E | Not applicable; no app workflow exists. |
| Platform | Local Bash execution. |
| Release | Remote installer validation deferred until publication hardening. |

## Harness Delta

Removes source helper scripts from the target installer payload and updates
target-installed governance docs to describe agent-first intake.

## Evidence

- `bash -n scripts/install-harness.sh`
- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- `scripts/install-harness.sh --directory "$TMP" --yes --dry-run`
- `scripts/install-harness.sh --directory "$TMP" --yes`
- Temp-target inspection confirmed no `scripts/` directory is created and
  target-installed docs do not reference `scripts/governance-intake`.
