# Test Matrix

This file maps product and harness behavior to proof.

No product behavior has been defined or implemented yet. Harness behavior may
appear here when a workflow rule becomes accepted contract. Do not mark a row
implemented until tests, validation evidence, or honest document-review evidence
exist.

In this source repository, filled harness rows are temporary
framework-development traceability while Crisp Harness is still taking shape.
They help track what changed and what proof was run during the initial phase.
Target projects receive the blank seed matrix from
`docs/templates/seed/TEST_MATRIX.md` and build their own local proof history.

## Status Values

| Status | Meaning |
| --- | --- |
| planned | Accepted as intended behavior, not implemented |
| in_progress | Actively being built |
| implemented | Implemented and proof exists |
| changed | Contract changed after earlier implementation |
| retired | No longer part of the product contract |

## Matrix

| Story | Contract | Unit | Integration | E2E | Platform | Status | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| TBD | Add rows when story packets are created | no | no | no | no | planned | none |

## Evidence Rules

- Unit proof covers pure domain and application rules.
- Integration proof covers backend enforcement, data integrity, provider
  behavior, jobs, or service contracts.
- E2E proof covers user-visible browser flows.
- Platform proof covers only shell, deployment, mobile, desktop, or runtime
  behavior that cannot be proven in lower layers.
- A story can be implemented without every proof column if the story packet
  explains why.
- Stub-only or surface-only work is not implemented proof. If behavior is only
  named, mocked, hard-coded, or cosmetically present, keep the row `planned` or
  `in_progress` and document the missing proof.
- Normal, high-risk, or long-running work should include evaluator notes using
  `docs/EVALUATION.md` when executable proof is absent or incomplete.

## Harness Rows

| Story | Contract | Unit | Integration | E2E | Platform | Status | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| US-002 | Evaluation and handoff contracts guide long-running agent work | no | yes | no | yes | implemented | `docs/EVALUATION.md`, `docs/templates/handoff.md`, `docs/stories/epics/E01-harness-quality/US-002-agent-evaluation-contracts.md`, `bash -n scripts/install-harness.sh`, dry-run install probe, temp-target install probe |
| US-003 | Governance, continuity, and agent onboarding guide project-start and resumed work | no | yes | no | yes | implemented | `docs/PROJECT_GOVERNANCE.md`, `docs/PROJECT_START.md`, `docs/CONTINUITY.md`, `docs/AGENT_ONBOARDING.md`, `docs/handoffs/README.md`, `docs/decisions/0004-governance-first-continuity.md`, installer syntax/dry-run/install probes |
| US-004 | Governance intake TUI writes project-start markdown artifacts without app scaffolding | no | no | no | no | retired | Retired 2026-05-21; source helper files were removed from `scripts/` |
| US-005 | Crisp staged context and mission role contracts guide normal, high-risk, long-running, and multi-agent work | no | yes | no | yes | implemented | Lightweight Crisp templates, `docs/AGENT_ROLES.md`, `docs/decisions/0005-crisp-mission-context-pipeline.md`, `docs/decisions/0006-target-safe-installer-payload.md`, installer syntax/dry-run/install probes, target install with seed matrix/backlog, no historical decision records, and no stale role-directory references |
| US-006 | Target installs receive a target-safe agent guide instead of source repository `AGENTS.md` | no | yes | no | yes | implemented | `docs/templates/seed/AGENTS.md`, `docs/decisions/0009-target-safe-agent-guide.md`, installer syntax/dry-run/install probes, temp-target `AGENTS.md` inspection |
| US-007 | Target installs receive a target-safe root README instead of source repository `README.md` | no | yes | no | yes | implemented | `docs/templates/seed/README.md`, `docs/decisions/0010-target-safe-readme.md`, installer syntax/dry-run/install probes, temp-target `README.md` inspection |
| US-008 | Target installs receive the agent-facing markdown harness without source helper scripts | no | yes | no | yes | implemented | `docs/decisions/0011-agent-facing-target-payload.md`, installer syntax/dry-run/install probes, temp-target no-`scripts/` inspection |
| US-009 | Existing projects with local code, docs, tests, scripts, and conventions are first-class target projects | no | yes | no | yes | implemented | `docs/decisions/0012-existing-projects-first-class.md`, target-safe seed docs, installer cautious merge behavior |
| US-010 | Installer creates missing harness files, augments existing `AGENTS.md`, and never overwrites target files | no | yes | no | yes | implemented | `docs/decisions/0013-non-overwriting-installer.md`, installer syntax and existing-target probes |
| US-011 | Installer runs without prompts and target agents ask specific questions when core context is missing | no | yes | no | yes | implemented | `docs/decisions/0014-non-interactive-current-directory-install.md`, target-safe `AGENTS.md`, installer syntax and no-prompt probes |
| US-012 | Existing-project adoption has an agent-facing guide, canonical story packet expectations, and target router entry | no | yes | no | yes | implemented | `docs/PROJECT_ADOPTION.md`, `docs/templates/seed/stories-README.md`, `docs/templates/seed/stories-backlog.md`, `docs/decisions/0016-existing-project-adoption-guide.md`, installer syntax and temp-target guide probe |
| US-013 | Agent operating loops make target installs clearer about local tracker rules, readiness, domain language, prototypes, validation quality, architecture review, and first-adoption routing | no | yes | no | yes | implemented | `docs/agents/`, `docs/ADOPTION_STATUS.md`, `docs/FIRST_ADOPTION.md`, `docs/templates/story.md`, `docs/templates/prototype.md`, `docs/templates/product-glossary.md`, `docs/templates/validation-contract.md`, `docs/ARCHITECTURE.md`, installer syntax and temp-target guide probe |
| US-014 | Docs-only observability defines context rules, trace evidence, component attribution, and maturity levels before durable state tooling | no | yes | no | yes | implemented | `docs/CONTEXT_RULES.md`, `docs/TRACE_SPEC.md`, `docs/HARNESS_COMPONENTS.md`, `docs/HARNESS_MATURITY.md`, `docs/decisions/0017-docs-only-observability-before-durable-state.md`, installer syntax and payload probes |
| US-015 | Durable Harness CLI provides local queryable state for intake, stories, decisions, backlog, traces, tools, audit, and interventions | no | yes | no | yes | implemented | `crates/harness-cli/`, `scripts/schema/`, `scripts/bin/harness-cli --version`, `scripts/bin/harness-cli init`, `import brownfield`, `migrate`, `query stats`, `query matrix --numeric`, SQLite Crisp intake-type schema probe, Trace #2 detailed tier, `audit` entropy `0/100`, `bash -n scripts/install-harness.sh`, installer dry-run/temp-target probe, missing-CLI remote install continues, `--require-cli` missing-CLI install fails; Rust unit tests deferred because `cargo` is unavailable |
