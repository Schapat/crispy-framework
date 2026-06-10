# 0018 Local Durable Harness CLI

## Status

accepted

## Context

Crisp Harness previously stopped at docs-only observability. That protected the
framework from accidental implementation tooling before the operating model was
stable, but it also left story status, proof rows, decisions, backlog items, and
trace evidence scattered across markdown.

The user explicitly asked to apply a Rust CLI and SQLite durable-layer approach
to make Crisp Harness more refined. That changes the accepted architecture
direction for this source repository.

## Decision

Adopt a repository-local Rust CLI and SQLite durable layer:

- Rust source lives under `crates/harness-cli/`.
- Schema migrations live under `scripts/schema/`.
- The stable command path is `scripts/bin/harness-cli`.
- The generated database is `harness.db` and remains ignored by git.
- Markdown policy docs remain authoritative for rules; the database stores
  operational records produced by agents.

Adapt the tooling to Crisp vocabulary:

- Use `docs/WORK_INTAKE.md`, not legacy feature-intake naming.
- Support Crisp input types, including existing-project adoption, first
  adoption, prototypes, and resume requests.
- Keep installer behavior non-overwriting for target projects.

## Consequences

- Crisp reaches H3 locally: harness state can be queried without reading every
  markdown table.
- Target installs can receive the CLI binary and schema files while still
  preserving existing project instructions and docs.
- The source repository now has a Rust workspace, release helper, schema
  migrations, and CLI operational docs.
- Rust validation requires a local Rust toolchain; this machine did not have
  `cargo` available during adoption, so Rust tests must be run later.
- The release workflow publishes Crisp-owned binary assets from `harness-cli-v*`
  tags so remote installs can receive the repository-local CLI.

## Verification

- CLI binary installed from release `harness-cli-v0.1.9` and checksum verified.
- `scripts/bin/harness-cli init`
- `scripts/bin/harness-cli import brownfield`
- `scripts/bin/harness-cli query stats`
- `scripts/bin/harness-cli query matrix --numeric`
- `scripts/bin/harness-cli migrate`
- SQLite transaction probe confirmed schema support for
  `first_existing_project_adoption`.
