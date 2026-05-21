# Scripts

This directory is reserved for harness automation.

## Installer

The installer applies the Crisp Harness v0 operating files and folder structure
to a target project directory. It is intended to become the remote installer
after this framework is published, while still working from a local checkout
during the initial phase. It defaults to the current directory, accepts a target
path, creates missing harness files, and skips files that already exist.
Existing files are never overwritten.

Target installs receive a target-safe `AGENTS.md` from
`docs/templates/seed/AGENTS.md`, not this source repository's own
source-specific agent guide.
They also receive a target-safe `README.md` from
`docs/templates/seed/README.md`, not this source repository's framework README.

Target installs do not receive this source repository's helper scripts. The
installed harness is agent-facing markdown plus templates, so humans do not need
extra commands to understand before asking an AI agent to adapt the harness.

Installation is a one-time framework copy. Target projects own their local
harness after install; this source repository does not provide an ongoing
upstream update relationship yet.

Merge behavior is cautious and is now the default: it copies missing harness
files and leaves existing project instructions, docs, and scripts untouched.
Treat merge as a bootstrap step, not automatic reconciliation. A human should
review conflicts and ask an AI agent to adapt the harness manually for the
target project.

```bash
curl -fsSL https://raw.githubusercontent.com/dzungbk156/crispy-framework/main/scripts/install-harness.sh | bash
```

```bash
scripts/install-harness.sh
```

The installer must stay limited to harness files. Do not use it to scaffold
application source folders, package scripts, CI, tests, platform shells, or fake
validation commands. The installer script is not part of the installed project
payload. This repository's historical decision records are also not installed;
target projects start with `docs/decisions/README.md` and the decision template.

The remote installer defaults to
`https://raw.githubusercontent.com/dzungbk156/crispy-framework/main`. If the
published repository path changes, update the script default or set
`HARNESS_SOURCE_BASE_URL` to the raw file base URL for that repository.

## Future Command Contract

Expected future checks:

```text
validate:quick
  format, lint, typecheck, unit tests, architecture check

test:integration
  backend contract and integration checks

test:e2e
  user-visible end-to-end flows

test:platform
  platform shell smoke checks, if the project has a native shell

test:release
  full suite, log checks, and performance smoke
```
