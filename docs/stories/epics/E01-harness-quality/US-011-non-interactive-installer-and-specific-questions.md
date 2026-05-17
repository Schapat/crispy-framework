# US-011 Non-Interactive Installer And Specific Questions

## Status

implemented

## Lane

normal

## Product Contract

The installer runs non-interactively from the current directory by default, and
the target-safe agent guide tells agents to ask specific human questions when
core project context is missing instead of guessing.

## Relevant Product Docs

- `README.md`
- `scripts/install-harness.sh`
- `scripts/README.md`
- `docs/templates/seed/AGENTS.md`
- `docs/PROJECT_GOVERNANCE.md`
- `docs/GLOSSARY.md`
- `docs/decisions/0014-non-interactive-current-directory-install.md`

## Acceptance Criteria

- The installer does not prompt for a target directory.
- The installer still defaults to the current directory.
- The installer still accepts `--directory` and positional target paths.
- Documentation shows the intended simple remote `curl | bash` shape.
- The target-safe agent guide tells agents to ask a specific question when core
  files, commands, product rules, or conventions are missing or unclear.

## Evaluator Contract

Evaluator acceptance criteria:

- Running the installer without `--yes` does not wait for user input.
- A target install still creates missing files and skips existing files.
- Target-installed `AGENTS.md` includes the specific-question instruction.

Failure thresholds:

- The installer waits for a target prompt.
- Docs imply humans must use a helper script after install before an agent can
  adapt the harness.
- Agents are encouraged to guess missing project context.

Expected proof level:

- shell syntax
- source validation script
- temp-target install probe
- document review

Artifacts to inspect:

- `scripts/install-harness.sh`
- target `AGENTS.md`
- `README.md`
- `scripts/README.md`

## Design Notes

- Commands: `scripts/install-harness.sh`.
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: install into current directory by default; ask specific human
  questions when core context is missing.
- UI surfaces: terminal installer output only.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Shell syntax checks for harness scripts. |
| Integration | Temp-target install without `--yes` completes without prompting. |
| E2E | Not applicable; no app workflow exists. |
| Platform | Local Bash execution. |
| Release | Remote installer validation deferred until publication hardening. |

## Harness Delta

Removes the remaining installer prompt and adds the specific-question rule to
target-safe agent guidance.

## Evidence

- `bash -n scripts/install-harness.sh`
- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- Temp-target install without `--yes` completed without waiting for input.
- Temp-target inspection confirmed `AGENTS.md` includes the
  specific-question rule.
