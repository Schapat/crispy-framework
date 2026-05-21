# US-004 Governance Intake TUI

## Status

retired

## Retirement Note

Retired on 2026-05-21. The source repository no longer carries the
`scripts/governance-intake` helper or its validation wrapper because they are no
longer needed.

## Lane

normal

## Product Contract

The harness provides a terminal governance intake wizard that collects
project-start answers and writes markdown governance artifacts. The wizard helps
start a new governed project without scaffolding application code, package
scripts, CI, platform shells, or fake validation commands.

## Relevant Product Docs

- `docs/PROJECT_GOVERNANCE.md`
- `docs/PROJECT_START.md`
- `docs/WORK_INTAKE.md`
- `docs/TEST_MATRIX.md`
- `scripts/README.md`

## Acceptance Criteria

- `scripts/governance-intake --help` documents usage.
- The command defaults to the current directory and accepts `--directory`.
- The command can run interactively in a terminal.
- The command can run from an answers file for repeatable validation.
- Dry-run mode previews planned artifacts without writing files.
- Real run writes governance markdown artifacts only.
- Generated artifacts include spec intake, product overview, story backlog, test
  matrix, and first decision stub.
- Existing files are not overwritten unless `--force` is used.
- The command does not create application source folders, package scripts, CI,
  tests, platform shells, or implementation code.

## Evaluator Contract

Evaluator acceptance criteria:

- Output files are readable markdown and reflect supplied answers.
- Dry-run produces no files.
- Real run creates only the documented governance artifacts.
- Re-running without `--force` refuses to overwrite generated files.
- The validation script proves the command in a temporary target.

Failure thresholds:

- The command scaffolds app implementation.
- The command silently overwrites existing governance files.
- The command cannot be validated without manual typing.

Expected proof level:

- shell syntax
- integration-style temp-target validation
- document review

Artifacts to inspect:

- `scripts/governance-intake`
- `scripts/test-governance-intake.sh`
- generated temp-target artifacts during validation

## Design Notes

- Commands: `scripts/governance-intake`, `scripts/test-governance-intake.sh`.
- Queries: none.
- API: none.
- Tables: markdown tables only.
- Domain rules: the wizard captures governance context, not implementation.
- UI surfaces: terminal prompts and preview output.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Shell syntax checks for new scripts. |
| Integration | Temp-target dry-run and real run through `scripts/test-governance-intake.sh`. |
| E2E | Manual interactive run can be performed later. |
| Platform | Local Bash execution. |
| Release | Not applicable until packaging exists. |

## Harness Delta

Promotes the proposed governance intake TUI backlog item into a real first
slice while preserving the governance-first rule.

## Evidence

- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- PTY prompt smoke test: Enter advances from `Project name` to the next prompt.
- PTY interrupt smoke test: Ctrl-C exits with code 130 and prints `Aborted.`
