# US-006 Target-Safe Agent Guide

## Status

implemented

## Lane

normal

## Product Contract

The installer provides target projects with a target-safe `AGENTS.md` canonical
default instead of copying this source repository's source-specific agent guide.
The installed guide must support local adaptation and must not tell target
projects that they have no product implementation.

## Relevant Product Docs

- `AGENTS.md`
- `docs/HARNESS.md`
- `docs/GLOSSARY.md`
- `docs/decisions/0009-target-safe-agent-guide.md`
- `docs/templates/seed/AGENTS.md`
- `scripts/install-harness.sh`
- `scripts/README.md`

## Acceptance Criteria

- Source repository `AGENTS.md` remains specific to this framework repository.
- Target installs use `docs/templates/seed/AGENTS.md` for target `AGENTS.md`.
- The target-safe guide says installed projects use Crisp Harness.
- The target-safe guide does not claim the target project has no implementation.
- The target-safe guide expects local adaptation after install.
- Installer dry-run and real install still complete successfully.

## Evaluator Contract

Evaluator acceptance criteria:

- A target install creates `AGENTS.md` from the seed template.
- Target `AGENTS.md` does not include source-only claims about preserving the
  harness before writing application code.
- Installer documentation explains the seed guide behavior.

Failure thresholds:

- The installer copies source `AGENTS.md` into target projects.
- Target `AGENTS.md` tells existing projects to avoid implementation work
  because the source repository is still in Harness v0.
- The installer omits an agent entrypoint entirely.

Expected proof level:

- document review
- shell syntax
- installer dry-run and temp-target install probe

Artifacts to inspect:

- `docs/templates/seed/AGENTS.md`
- `scripts/install-harness.sh`
- temp target `AGENTS.md`

## Design Notes

- Commands: `scripts/install-harness.sh`.
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: source repository identity and target project identity are
  separate.
- UI surfaces: terminal installer output only.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Shell syntax checks for harness scripts. |
| Integration | Temp-target install creates target-safe `AGENTS.md`. |
| E2E | Not applicable; no app workflow exists. |
| Platform | Local Bash execution. |
| Release | Remote installer validation deferred until publication hardening. |

## Harness Delta

Adds a target-safe agent guide seed and routes installer `AGENTS.md` through it.

## Evidence

- `bash -n scripts/install-harness.sh`
- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- `scripts/install-harness.sh --directory "$TMP" --yes --dry-run`
- `scripts/install-harness.sh --directory "$TMP" --yes`
- Temp-target inspection confirmed `AGENTS.md` comes from
  `docs/templates/seed/AGENTS.md` and does not contain source-only
  no-implementation instructions.
