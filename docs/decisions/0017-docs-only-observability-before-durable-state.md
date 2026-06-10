# 0017 Docs-Only Observability Before Durable State

## Status

superseded by `0018-local-durable-harness-cli.md`

## Context

The comparison with `harness-experimental` showed useful patterns for maturity
tracking, component taxonomy, trace evidence, context retrieval, and optional
durable state. Crisp Harness already has strong governance, adoption,
continuity, and multi-agent workflow docs, but it lacked a concise observability
layer that tells agents how to record what happened.

The experimental repository also includes a Rust CLI, SQLite schema, release
packaging, and installer binary handling. Those are valuable implementation
ideas, but Crisp Harness v0 explicitly avoids scaffolding implementation
tooling until a story accepts that commitment.

## Decision

Add docs-only observability first:

- `docs/HARNESS_MATURITY.md`
- `docs/HARNESS_COMPONENTS.md`
- `docs/TRACE_SPEC.md`
- `docs/CONTEXT_RULES.md`

Keep durable state as a future investigation rather than implementing a CLI,
database, migrations, release workflow, or binary installer in this change.

## Consequences

- Agents get clearer trace, maturity, and context-selection expectations now.
- The harness remains target-safe and markdown-first.
- A future story can evaluate durable state with an explicit design, migration
  plan, installer impact, and rollback path.
- Trace quality remains manually reviewed until automation exists.

## Supersession

On 2026-06-10, the human explicitly asked to apply a Rust CLI and SQLite
durable-layer approach into Crisp Harness to make this repository more refined.
Decision `0018` accepts that follow-up implementation while preserving this
decision as the historical reason Crisp added docs-only observability first.

## Verification

- New docs are referenced from the entrypoint and documentation map.
- The installer copies the new docs into target projects.
- No Rust, database, release, CI, or application scaffolding is added.
