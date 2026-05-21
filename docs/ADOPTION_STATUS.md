# Adoption Status

Status: not_started

Use this file to tell agents whether Crisp Harness has already been adapted to
this project.

## Status Values

- `not_started`: Crisp files are installed, but local project truth has not been
  inventoried or written into the harness yet.
- `in_progress`: adoption has started and should continue from the adoption
  story or handoff.
- `ready`: the harness has enough local context for governed work.
- `blocked`: adoption cannot continue until a specific missing input, decision,
  or access issue is resolved.

## First Adoption Route

When status is `not_started`, or when the human asks for first adoption, read
only:

- `README.md`
- `AGENTS.md`
- `docs/WORK_INTAKE.md`
- `docs/FIRST_ADOPTION.md`

Then follow `docs/FIRST_ADOPTION.md`.

## Ready Checklist

Mark status `ready` only when:

- `AGENTS.md` names local stack, commands, risks, and workflow expectations.
- `docs/agents/` reflects local tracker, readiness, and domain-language
  conventions, or explicitly says none are configured.
- `docs/TEST_MATRIX.md` lists known validation commands or the missing-command
  question.
- `docs/stories/backlog.md` names the first real story or blocker.
- An adoption story exists or has an explicit blocker.
- Product truth has a clear source in `docs/product/`, existing local docs, or
  an explicit gap.

## Current Blocker

- None recorded.
