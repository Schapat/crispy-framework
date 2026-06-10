# Scripts

This directory is reserved for harness automation.

## Installer

The installer applies the Crisp Harness v0 operating files and folder structure
to a target project directory. It is intended to become the remote installer
after this framework is published, while still working from a local checkout
during the initial phase. It defaults to the current directory, accepts a target
path, creates missing harness files, and skips files that already exist.
Existing files are never overwritten. Existing `AGENTS.md` files receive a
marked Crisp Harness section once so future agents can discover the installed
harness without losing local project instructions.

Target installs receive a target-safe `AGENTS.md` from
`docs/templates/seed/AGENTS.md`, not this source repository's own
source-specific agent guide, when the target does not already have `AGENTS.md`.
When `AGENTS.md` already exists, the installer appends a compact Crisp Harness
section instead of replacing the file.
They also receive a target-safe `README.md` from
`docs/templates/seed/README.md`, not this source repository's framework README.

Target installs do not receive this source repository's source helper scripts or
Rust source tree. They receive agent-facing markdown plus templates, schema
migrations, and the repository-local Harness CLI binary at
`scripts/bin/harness-cli` when the platform is supported.

The installed docs include observability files for context selection, trace
evidence, component attribution, and maturity review. The CLI adds a local
durable layer for queryable intake, story, decision, backlog, trace, tool, and
intervention records. The generated `harness.db` remains local to the target
project and is ignored by git.

Installation is a one-time framework copy. Target projects own their local
harness after install; this source repository does not provide an ongoing
upstream update relationship yet.

Merge behavior is cautious and is now the default: it copies missing harness
files, appends a marked Crisp Harness section to existing `AGENTS.md`, and
leaves other existing project docs and scripts untouched. Treat merge as a
bootstrap step, not automatic reconciliation. A human should review conflicts
and ask an AI agent to adapt the harness manually for the target project.

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

Pass `--no-cli` to skip binary installation when a target project wants the
markdown harness only. Pass `--require-cli` when a missing CLI binary should
fail installation.

The remote installer defaults to
`https://raw.githubusercontent.com/dzungbk156/crispy-framework/main`. If the
published repository path changes, update the script default or set
`HARNESS_SOURCE_BASE_URL` to the raw file base URL for that repository.

The CLI installer reads `scripts/harness-cli-release-tag` and downloads release
assets from `https://github.com/dzungbk156/crispy-framework/releases`. Set
`HARNESS_CLI_BASE_URL` to use another release asset location. Remote installs
continue without the CLI when release assets are not available yet, unless
`--require-cli` is provided.

## Harness CLI

The stable local command path is:

```bash
scripts/bin/harness-cli <command>
```

Common commands:

```bash
scripts/bin/harness-cli init
scripts/bin/harness-cli import brownfield
scripts/bin/harness-cli query matrix
scripts/bin/harness-cli trace --summary "..." --outcome completed
scripts/bin/harness-cli audit
```

The Rust source for the CLI lives in `crates/harness-cli/`. Build release
artifacts with `scripts/build-harness-cli-release.sh` on machines with a Rust
toolchain.

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
