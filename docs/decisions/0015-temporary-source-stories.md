# 0015 Temporary Source Traceability

Date: 2026-05-17

## Status

Accepted

## Context

The harness source repository contains story packets and filled test matrix rows
that track framework development during the initial phase. They capture
acceptance criteria, validation evidence, and traceability while the operating
model is still being shaped.

Target projects should not receive source-repository story history, and the
source repository may later be cleaned before public release.

## Decision

Treat source-repository story packets and filled source test matrix rows as
temporary framework-development traceability.

Keep them for now to track the initial phase. They are not target payload.
Source stories and filled source matrix rows may be pruned in future commits
after their useful rationale has landed in durable docs or decisions.

## Alternatives Considered

1. Remove all source stories and matrix rows immediately. Rejected because they
   still help track what changed and what proof was run while the framework is
   evolving.
2. Treat source stories and filled source matrix rows as permanent framework
   contract. Rejected because the durable contract should live in core docs,
   templates, decisions, and tests or validation evidence.

## Consequences

Positive:

- Initial framework work remains traceable while it is still changing quickly.
- Future cleanup is allowed without contradicting the harness model.
- Target projects stay free from source-repository story and matrix history.

Tradeoffs:

- The source repository temporarily contains development-history rows and files
  that may not belong in a polished public release.

## Follow-Up

- Before a public release or later cleanup commit, prune source stories and
  matrix rows whose useful rationale has been captured elsewhere.
