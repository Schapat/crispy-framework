# Project Adoption

Use this guide when incorporating Crisp Harness into an existing software
project that may already have code, docs, tests, scripts, validation commands,
deployment notes, or team conventions.

The output of adoption is not a rewrite of the project. The output is enough
local context and story structure for AI agents to work safely inside the
existing project.

For a first run after installation, start with `docs/FIRST_ADOPTION.md`. Use
this document when the agent needs the full adoption checklist or deeper
guidance.

## Adoption Flow

```text
existing project
  -> local truth inventory
  -> current workflow and command map
  -> risk and unknowns map
  -> harness fit check
  -> local adaptation plan
  -> adoption story packet
  -> first real story or blocker
  -> ready-for-governed-work checkpoint
```

Adoption normally starts in the normal lane because it changes governance docs,
source-truth routing, and validation expectations. Follow-up work should still
use the regular `docs/WORK_INTAKE.md` risk checklist: architecture changes,
auth, authorization, data loss, audit/security, external providers, validation
weakening, or existing behavior changes may make a specific follow-up high-risk.

## Local Truth Inventory

Inspect existing files before proposing changes:

1. What does `README.md` say the project is?
2. Is there already an `AGENTS.md`, agent guide, contributor guide, or local
   development guide?
3. What source folders, apps, packages, or services exist?
4. What product docs, API docs, design docs, or decision records already exist?
5. What commands run setup, lint, typecheck, tests, build, dev server, or deploy?
6. What package manager, language, framework, database, providers, and hosting
   clues are present?
7. What tests or validation reports already prove behavior?
8. What data, auth, authorization, payment, provider, file, webhook, or
   deployment risks exist?
9. What conventions should agents preserve?
10. What important context is missing or unclear?

If a core file, command, product rule, or convention is missing or unclear, ask
the human a specific question instead of guessing.

## Artifacts To Create Or Update

Adopt only the harness files that help agents work with the existing project:

- adapt `AGENTS.md` to mention local stack, commands, docs, risks, and team
  workflow
- add or update `docs/product/overview.md` only when stable product truth can be
  derived from local artifacts or human answers
- add targeted `docs/product/*.md` files only for durable domains that already
  exist or have been accepted
- update `docs/TEST_MATRIX.md` with existing validation commands and proof
  expectations
- adapt `docs/agents/` so agents know the local issue tracker, readiness
  states, and domain-language sources
- add `docs/decisions/` records for meaningful stack, architecture, scope, or
  proof decisions that are not already documented
- create or update `docs/stories/backlog.md` as the durable local story index
- create an adoption story packet from `docs/templates/story.md`
- name the first real product, maintenance, or harness-adaptation story after
  adoption, even if it remains planned or blocked
- use story packets for future accepted work so scope, proof, and evidence do
  not live only in scattered external tickets
- treat repository story packets as the canonical work record; external tickets
  may be linked from stories but should not be the only source of accepted
  scope, validation expectations, decisions, or evidence
- add `docs/HARNESS_BACKLOG.md` items when adoption exposes missing harness
  capabilities

Do not overwrite or reinterpret local project truth just to fit the harness.
Do not retroactively write stories for every historical feature unless the human
explicitly asks for that cleanup.

## Adaptation Rules

- Preserve existing code, docs, tests, scripts, and conventions.
- Treat local artifacts as source truth until a human changes them.
- Prefer links to existing docs over duplicating large bodies of text.
- Keep unknowns visible instead of hiding them in generated docs.
- Do not create application scaffolding, package scripts, CI, migrations, tests,
  or platform shells unless a later story explicitly requires them.
- Do not mark existing behavior as implemented in the test matrix unless proof
  exists and has been inspected or run.

## Ready For Governed Work

Adoption is ready when:

- `docs/ADOPTION_STATUS.md` is `ready`
- local project identity is understood
- existing agent, contributor, setup, and validation guidance has been located
- `docs/agents/` either reflects local tracker/domain/state conventions or
  explicitly says none are configured yet
- important commands are listed or the missing-command question is explicit
- key risks and unknowns are visible
- `AGENTS.md` reflects local adaptation needs
- `docs/stories/backlog.md` exists or has an explicit blocker
- the adoption story packet exists or has an explicit blocker
- the first real product, maintenance, or harness-adaptation story is named or
  has an explicit blocker
- product truth has a clear source or an explicit gap
- the next selected story, maintenance task, or blocker is named

If any item is missing, keep working in adoption notes or ask the human a
specific question.
