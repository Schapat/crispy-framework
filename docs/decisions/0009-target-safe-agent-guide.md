# 0009 Target-Safe Agent Guide

Date: 2026-05-17

## Status

Accepted

## Context

The harness source repository has its own `AGENTS.md` that tells agents this
repository is Crisp Harness v0, has no product implementation yet, and should
preserve and grow the collaboration harness before writing application code.

Those instructions are correct for the source repository, but they are wrong
for many target projects. A target project may be an existing app with source
code, tests, local product truth, stack decisions, and validation commands.

## Decision

Do not install the source repository's `AGENTS.md` into target projects.

Target installs receive `docs/templates/seed/AGENTS.md` as a target-safe
canonical default. That guide says the project uses Crisp Harness, warns agents
not to assume the project has no implementation, and expects local adaptation
after install.

## Alternatives Considered

1. Copy source `AGENTS.md` directly. Rejected because it would make target
   projects inherit source-repository identity and no-implementation rules.
2. Omit `AGENTS.md` from target installs. Rejected because agents need a clear
   entrypoint immediately after install.
3. Generate `AGENTS.md` dynamically during install. Deferred because a static
   target-safe seed is enough for the current one-time framework copy model.

## Consequences

Positive:

- Target projects receive an agent entrypoint without inheriting source-specific
  instructions.
- Existing projects can adapt the canonical default instead of fighting a
  misleading source-repo guide.
- The installer preserves the distinction between reusable harness contract and
  source-repository history.

Tradeoffs:

- The source repository now maintains two agent guides: one for itself and one
  target-safe seed.
- Future changes to the operating model may need updates in both files when
  they apply to both contexts.

## Follow-Up

- When remote installer hardening begins, verify the published installer fetches
  the target-safe seed guide.
