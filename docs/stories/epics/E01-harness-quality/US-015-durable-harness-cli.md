# US-015 Durable Harness CLI

## Status

implemented

## Lane

normal

## Execution Mode

AFK

Human needed for:

- Review before publishing new CLI release assets under the Crisp repository.

Ready for agent when:

- Scope stays limited to harness tooling, durable state docs, installer support,
  and local CLI adoption.

Blocked by:

- Rust validation on this machine, because `cargo` is not installed.

## Product Contract

Crisp Harness should include a repository-local durable layer that lets agents
query intake, story proof state, decisions, backlog items, traces, tools, audit
findings, and interventions without replacing markdown as the reviewable
contract.

## Relevant Product Docs

- `docs/HARNESS.md`
- `docs/WORK_INTAKE.md`
- `docs/TRACE_SPEC.md`
- `docs/HARNESS_COMPONENTS.md`
- `docs/HARNESS_MATURITY.md`
- `docs/TOOL_REGISTRY.md`
- `docs/HARNESS_AUDIT.md`
- `docs/IMPROVEMENT_PROTOCOL.md`
- `scripts/README.md`

## Acceptance Criteria

- Rust CLI source and Cargo workspace are present in the source repository.
- SQLite schema migrations are present under `scripts/schema/`.
- The local CLI binary is installed at `scripts/bin/harness-cli`.
- The generated `harness.db` and CLI binary paths are ignored by git.
- CLI source and schema intake types align with `docs/WORK_INTAKE.md`; the
  installed prebuilt binary needs a future Crisp-owned rebuild before those
  source changes are available through `harness-cli intake`.
- Installer support remains non-overwriting and can install the CLI/schema into
  target projects.
- Harness docs describe the durable layer without removing markdown review
  surfaces.
- The local database can initialize, import brownfield markdown state, migrate,
  and query the matrix.

## Evaluator Contract

Evaluator acceptance criteria:

- The imported tooling is adapted to Crisp names, especially
  `docs/WORK_INTAKE.md`.
- Durable state does not become an application scaffold.
- Target installs still preserve existing project files.
- The old docs-only decision is superseded rather than silently contradicted.

Failure thresholds:

- The installer overwrites target project files.
- CLI docs point agents to missing upstream-only files.
- Crisp-specific intake types cannot be recorded.
- The final response claims Rust tests passed when `cargo` was unavailable.

Expected proof level:

- document review | integration | platform

Artifacts to inspect:

- `crates/harness-cli/`
- `scripts/schema/`
- `scripts/install-harness.sh`
- `docs/decisions/0018-local-durable-harness-cli.md`
- `docs/TEST_MATRIX.md`

## Design Notes

- Commands: `scripts/bin/harness-cli init`, `migrate`, `import brownfield`,
  `query matrix`, `query stats`
- Queries: durable matrix, backlog, decisions, traces, audit
- API: none
- Tables: intake, story, decision, backlog, trace, tool, intervention
- Domain rules: markdown policy remains authoritative; `harness.db` stores
  ignored local operational records
- UI surfaces: terminal CLI only

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Rust tests when `cargo` is available. |
| Integration | CLI init/migrate/import/query against local `harness.db`. |
| E2E | Installer dry-run or temp-target probe verifies schema and CLI install path. |
| Platform | macOS arm64 prebuilt binary checksum verification and version check. |
| Release | Deferred until Crisp-owned release assets are published. Current local binary is upstream `harness-cli 0.1.9`. |

## Harness Delta

Promotes Crisp from docs-only observability to local durable state and querying.
Adds Rust CLI source, schema migrations, command docs, audit/proposal docs,
installer binary support, and a decision superseding the previous docs-only
durable-state stance.

## Evidence

Trace:

- Task summary: Adopted Rust CLI durable-layer technology into Crisp Harness.
- Input type: Harness improvement.
- Lane: normal.
- Story: `US-015`.
- Agent: codex.
- Files read: `README.md`, `AGENTS.md`, `docs/WORK_INTAKE.md`,
  `docs/ARCHITECTURE.md`, `docs/EVALUATION.md`, `docs/CONTEXT_RULES.md`,
  `docs/HARNESS_COMPONENTS.md`, `docs/HARNESS_MATURITY.md`,
  upstream CLI docs, upstream installer, and Rust CLI source.
- Files changed: Rust workspace files, `crates/harness-cli/`, `scripts/schema/`,
  `scripts/install-harness.sh`, durable-layer docs, harness governance docs,
  story packet, decision records, and test matrix.
- Decisions made: adopt the durable layer locally; keep markdown as reviewable
  contract; keep target installer non-overwriting; widen CLI intake types for
  Crisp.
- Harness friction: the previous docs-only decision blocked durable state until
  the user explicitly approved this architecture change.
- Errors or blockers: `cargo` is not installed in this environment.
- Outcome: completed with Rust unit validation deferred.

Validation:

- `scripts/bin/harness-cli --version`
- `scripts/bin/harness-cli init`
- `scripts/bin/harness-cli import brownfield`
- `scripts/bin/harness-cli migrate`
- `scripts/bin/harness-cli query stats`
- `scripts/bin/harness-cli query matrix --numeric`
- `sqlite3 harness.db` transaction probe for
  `first_existing_project_adoption`
- `scripts/bin/harness-cli trace ...` recorded Trace #2 with detailed tier.
- `scripts/bin/harness-cli score-trace` confirmed Trace #2 meets the normal
  lane requirement.
- `scripts/bin/harness-cli audit` returned entropy score `0/100`.
- `bash -n scripts/install-harness.sh`
- Installer dry-run/temp-target probe
- Remote-style installer probe with an unavailable CLI release continued with
  docs and schema installed.
- Remote-style installer probe with `--require-cli` failed when the CLI release
  was unavailable.
- `cargo test` was not run because `cargo` is unavailable.
