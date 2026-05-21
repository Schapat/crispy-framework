# First Adoption

Use this when Crisp Harness has just been installed into an existing project or
`docs/ADOPTION_STATUS.md` says `not_started`.

Goal: adapt the harness to local project truth without reading the whole
governance folder or rewriting the project.

## Minimal Read Set

Read:

- `README.md`
- `AGENTS.md`
- `docs/WORK_INTAKE.md`
- `docs/ADOPTION_STATUS.md`
- this file

Then inspect local project files with targeted searches. Read
`docs/PROJECT_ADOPTION.md` only when you need the full adoption checklist.

## Do Not

- Do not scaffold app folders, package scripts, tests, CI, migrations, or
  platform shells.
- Do not overwrite existing project docs or conventions.
- Do not mark behavior implemented without inspected or executed proof.
- Do not read every file under `docs/` by default.

## Flow

1. Set `docs/ADOPTION_STATUS.md` to `in_progress`.
2. Inventory local truth:
   - project purpose from README or existing docs
   - source folders, packages, services, and runtimes
   - setup, lint, typecheck, test, build, dev, and deploy commands
   - existing agent, contributor, architecture, API, or product docs
   - auth, authorization, data, provider, payment, webhook, file, or deploy risks
3. Ask one specific human question if a core command, product rule, or
   convention is missing and cannot be inferred safely.
4. Adapt only useful harness files:
   - `AGENTS.md`
   - `docs/agents/`
   - `docs/TEST_MATRIX.md`
   - `docs/stories/backlog.md`
   - `docs/product/` only when stable product truth exists
5. Create an adoption story from `docs/templates/story.md`, or record the
   blocker that prevents creating one.
6. Name the first real product, maintenance, or harness-adaptation story.
7. Set `docs/ADOPTION_STATUS.md` to `ready` or `blocked`.

## Output Shape

End with:

```text
Adoption status: ready | blocked
Local stack:
Commands:
Risks:
First story or blocker:
Files updated:
Validation run:
```
