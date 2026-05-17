# Project Start

Use this guide when applying the harness to a new software project before AI
agents begin implementation.

The output of project start is not code. The output is enough governance context
for agents to work safely later.

## Project Start Flow

```text
human project idea or spec
  -> governance intake
  -> product truth draft
  -> risk and unknowns map
  -> architecture questions
  -> first story candidates
  -> proof expectations
  -> decisions or open decisions
  -> ready-for-implementation checkpoint
```

## Minimum Questions

Ask these before creating implementation work:

1. What is the project?
2. Who is it for?
3. What problem does it solve?
4. What are the main workflows?
5. What are the core domain concepts?
6. What surfaces might exist: browser, API, CLI, worker, mobile, desktop, or
   service?
7. What data is sensitive, regulated, or difficult to recover?
8. Are auth, payments, external providers, files, webhooks, or background jobs
   involved?
9. What stack choices are already decided?
10. What stack choices are still open?
11. What would count as proof for the first useful version?
12. What is the smallest useful first slice?

## Artifacts To Create

For a new project, create or update:

- spec-intake note using `docs/templates/spec-intake.md`
- `docs/product/overview.md` when product truth is stable enough
- additional `docs/product/*.md` only for durable domains
- `docs/stories/backlog.md`
- first story packet when one slice is clear enough
- `docs/TEST_MATRIX.md` rows for accepted behavior
- `docs/decisions/` records for meaningful stack, scope, or proof decisions

Do not create product docs for speculative domains just to fill folders.

## Ready For Implementation

Implementation is ready only when:

- source truth is identified
- first story scope is bounded
- key non-goals are visible
- risk lane is chosen
- expected proof is documented
- architecture blockers are named
- evaluator contract exists for normal, high-risk, or long-running work

If any item is missing, keep working in governance artifacts.

## Agent-First Intake

Target projects do not need a human-facing intake command to use the harness.
An AI agent can ask the minimum questions, draft the artifacts above, and keep
unknowns visible for human review.

The harness source repository may keep helper scripts for developing and
validating the framework itself, but target installs should stay focused on the
agent-facing markdown operating model.
