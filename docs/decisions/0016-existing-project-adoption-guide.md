# 0016 Existing-Project Adoption Guide

Date: 2026-05-17

## Status

Accepted

## Context

Existing projects are first-class Crisp Harness targets. The harness already
has `docs/PROJECT_START.md` for new project or spec intake, but existing
projects need a different path: discover local truth, preserve existing code and
conventions, adapt agent guidance, and avoid overwriting or inventing product
truth.

Without a dedicated adoption guide, existing-project support is described in
principle but not operationalized for agents.

## Decision

Add `docs/PROJECT_ADOPTION.md` as the existing-project counterpart to
`docs/PROJECT_START.md`.

The guide is agent-facing and target-safe. It tells agents to inspect local
README, docs, source folders, commands, tests, risks, and conventions before
adapting the harness. It also tells agents to ask specific human questions when
core context is missing, and to create a local story backlog plus a first
adoption story packet so accepted work is not scattered only in external ticket
systems. The adoption story names the first real product, maintenance, or
harness-adaptation story after adoption. Repository story packets are the
canonical work record; external tickets may be linked from them, but should not
be the only source of accepted scope, validation expectations, decisions, or
evidence.

## Alternatives Considered

1. Fold existing-project guidance into `docs/PROJECT_START.md`. Rejected because
   new/spec intake and existing-project adoption have different first moves.
2. Leave existing-project adoption implicit in `AGENTS.md`. Rejected because
   first-class support needs a concrete guide agents can read.

## Consequences

Positive:

- Existing-project support is concrete and easier for agents to follow.
- New-project and existing-project paths are separated without creating a
  human-facing helper command.
- Target projects receive adoption guidance as part of the markdown harness.

Tradeoffs:

- One more core governance document exists.
- The installer payload and docs map must keep this guide current.

## Follow-Up

- After real existing-project adoption, refine the inventory checklist if
  repeated gaps appear.
