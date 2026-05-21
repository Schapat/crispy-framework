# US-001 Install Harness Into A Project

## Status

implemented

## Lane

normal

## Product Contract

A user can apply the Harness v0 operating files and folder structure to a
target project directory without introducing an application stack, package
scripts, CI, tests, or product implementation.

## Relevant Product Docs

- `README.md`
- `docs/HARNESS.md`
- `docs/WORK_INTAKE.md`
- `scripts/README.md`

## Acceptance Criteria

- The installer defaults to the current directory when no target is provided.
- The installer accepts a specific target path through a command-line option or
  positional argument.
- The installer does not prompt for a target directory.
- If `AGENTS.md`, `docs/`, or any harness file already exists in the target, the
  installer augments existing `AGENTS.md`, skips other existing files, and
  creates only missing files.
- Existing files are never overwritten by the installer.
- A dry-run mode reports planned file operations without writing files.
- The installer copies only Harness v0 operating files and does not scaffold
  application code, package scripts, CI, or validation commands.
- The installer script and this installer story are not copied into target
  projects.

## Design Notes

- Commands: `scripts/install-harness.sh [--directory path] [--yes] [--merge] [--dry-run]`
- Local install: `scripts/install-harness.sh`
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: preserve Harness v0 as a generic, spec-intake-first operating
  framework.
- UI surfaces: terminal summary output only.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Shell syntax check for `scripts/install-harness.sh`. |
| Integration | Dry-run into a temporary target reports expected file creation. |
| E2E | Install into a temporary target creates the harness file structure. |
| Platform | POSIX shell execution on the local macOS environment. |
| Release | Not applicable until packaging exists. |

## Harness Delta

Adds the first real harness automation script while keeping installer internals
out of target projects and preserving the Harness v0 rule that application
implementation surfaces are not scaffolded.

## Evidence

- `bash -n scripts/install-harness.sh`
- `scripts/install-harness.sh --directory "$LOCAL_TARGET" --yes`
- `scripts/install-harness.sh --directory "$README_TARGET" --yes` after adding a
  custom `README.md` in the target
- `scripts/install-harness.sh --directory "$AGENTS_CONFLICT" --yes`
- `scripts/install-harness.sh --directory "$DOCS_CONFLICT" --yes`
- `scripts/install-harness.sh --directory "$NONINTERACTIVE_MERGE" --merge --yes`
- `HARNESS_SOURCE_BASE_URL="file:///path/to/your/crisp-harness" bash -s -- --directory "$REMOTE_TARGET" --yes < scripts/install-harness.sh`
- `HARNESS_SOURCE_BASE_URL="file:///path/to/your/crisp-harness" bash -s -- --directory "$DRY_TARGET" --yes --dry-run < scripts/install-harness.sh`

Validated behaviors: dry-run writes no files, real install creates the harness
structure, no target prompt is shown, existing `AGENTS.md` is augmented, other
existing files are left untouched, missing files are created in existing
targets, and target projects do not receive `scripts/install-harness.sh` or this
installer story.
