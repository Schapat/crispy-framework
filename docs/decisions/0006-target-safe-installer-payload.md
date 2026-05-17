# 0006 Target-Safe Installer Payload

## Status

accepted

## Context

The harness source repository has historical proof rows, backlog items, and
decision records that explain this repository's evolution. Target projects need
the reusable harness contract, but they should not inherit traceability rows or
decisions for work that never happened in that target.

## Decision

The installer copies reusable harness files plus target-safe seed files for
`AGENTS.md`, `README.md`, `docs/stories/README.md`,
`docs/stories/backlog.md`, `docs/TEST_MATRIX.md`, and
`docs/HARNESS_BACKLOG.md`. Historical decision records under
`docs/decisions/000*.md` remain source-repo history and are not part of target
installs.

## Consequences

- Target installs start with blank local traceability surfaces.
- This source repository keeps its real matrix, backlog, and decisions.
- Installer payload changes must preserve the distinction between reusable
  harness contract and source-repository history.
- Source helper scripts remain in the source repository and are not installed
  into target projects.
