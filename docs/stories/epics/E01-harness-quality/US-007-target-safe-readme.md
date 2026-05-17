# US-007 Target-Safe Root README

## Status

implemented

## Lane

normal

## Product Contract

The installer provides target projects with a target-safe root `README.md`
canonical default instead of copying this source repository's framework README.
The installed README must support local adaptation and must not present the
target project as the Crisp Harness source repository.

## Relevant Product Docs

- `README.md`
- `docs/HARNESS.md`
- `docs/decisions/0010-target-safe-readme.md`
- `docs/templates/seed/README.md`
- `scripts/install-harness.sh`
- `scripts/README.md`

## Acceptance Criteria

- Source repository `README.md` remains specific to this framework repository.
- Target installs use `docs/templates/seed/README.md` for target `README.md`.
- The target-safe README says installed projects use Crisp Harness.
- The target-safe README expects local adaptation after install.
- The target-safe README does not present the target project as
  `crisp-harness`.
- Installer dry-run and real install still complete successfully.

## Evaluator Contract

Evaluator acceptance criteria:

- A target install creates `README.md` from the seed template.
- Target `README.md` does not include source-only framework repository sections
  such as `Install Harness Into A Project`.
- Installer documentation explains the seed README behavior.

Failure thresholds:

- The installer copies source `README.md` into target projects.
- Target `README.md` tells readers the target project is the Crisp Harness
  source repository.
- The installer omits a root README for empty target projects without an
  intentional decision.

Expected proof level:

- document review
- shell syntax
- installer dry-run and temp-target install probe

Artifacts to inspect:

- `docs/templates/seed/README.md`
- `scripts/install-harness.sh`
- temp target `README.md`

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
| Integration | Temp-target install creates target-safe `README.md`. |
| E2E | Not applicable; no app workflow exists. |
| Platform | Local Bash execution. |
| Release | Remote installer validation deferred until publication hardening. |

## Harness Delta

Adds a target-safe root README seed and routes installer `README.md` through it.

## Evidence

- `bash -n scripts/install-harness.sh`
- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- `scripts/install-harness.sh --directory "$TMP" --yes --dry-run`
- `scripts/install-harness.sh --directory "$TMP" --yes`
- Temp-target inspection confirmed `README.md` comes from
  `docs/templates/seed/README.md` and does not contain source-only framework
  README sections.
