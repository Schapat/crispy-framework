# US-010 Non-Overwriting Installer

## Status

implemented

## Lane

normal

## Product Contract

The installer creates missing harness files, appends a marked Crisp Harness
section to an existing `AGENTS.md` once, and skips other existing target files.
It does not overwrite, replace, move, or back up target project files.

## Relevant Product Docs

- `README.md`
- `scripts/README.md`
- `scripts/install-harness.sh`
- `docs/decisions/0013-non-overwriting-installer.md`
- `docs/stories/US-001-install-harness.md`

## Acceptance Criteria

- `--override` is not supported.
- `--force` is not supported by the installer.
- Existing `AGENTS.md` keeps its original content and receives one marked Crisp
  Harness section.
- Existing `README.md` is left untouched.
- Existing files under `docs/` are left untouched.
- Missing harness files are created in targets that already contain `AGENTS.md`
  or `docs/`.
- Installer documentation describes create-missing, AGENTS augmentation, and
  skip-existing behavior.

## Evaluator Contract

Evaluator acceptance criteria:

- A target with existing `AGENTS.md`, `README.md`, and `docs/` keeps README and
  docs unchanged after install, and keeps original AGENTS content with an
  appended Crisp Harness section.
- The same target receives missing harness files.
- Passing `--override` or `--force` fails as an unknown option.

Failure thresholds:

- The installer overwrites, moves, or duplicates the Crisp section in an
  existing target file.
- Documentation still presents override as a supported path.
- Existing projects are told to stop instead of receiving missing files.

Expected proof level:

- shell syntax
- temp-target install probe
- document review

Artifacts to inspect:

- `scripts/install-harness.sh`
- target install files
- `README.md`
- `scripts/README.md`

## Design Notes

- Commands: `scripts/install-harness.sh`.
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: install is create-missing, AGENTS augmentation, and
  skip-existing for other files.
- UI surfaces: terminal installer output only.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Shell syntax checks for harness scripts. |
| Integration | Temp-target install preserves existing files and creates missing files. |
| E2E | Not applicable; no app workflow exists. |
| Platform | Local Bash execution. |
| Release | Remote installer validation deferred until publication hardening. |

## Harness Delta

Removes installer override and force behavior, and updates install docs to make
merge behavior the only target-project path.

## Evidence

- `bash -n scripts/install-harness.sh`
- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- Existing-target probe confirmed existing `AGENTS.md` content was preserved
  with one appended Crisp section, and existing `README.md` and
  `docs/HARNESS.md` were preserved while missing harness files were created.
- Unsupported option probes confirmed `--override` and `--force` fail.
