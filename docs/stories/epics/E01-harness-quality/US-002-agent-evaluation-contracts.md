# US-002 Agent Evaluation Contracts

## Status

implemented

## Lane

normal

## Product Contract

The harness provides an explicit evaluator contract for long-running or
multi-agent work. Stories can define evaluator acceptance criteria before work
begins, handoffs can carry evaluation state between sessions, and the test
matrix rejects stub-only proof as implemented behavior.

## Relevant Product Docs

- `docs/HARNESS.md`
- `docs/EVALUATION.md`
- `docs/TEST_MATRIX.md`
- `docs/templates/story.md`
- `docs/templates/handoff.md`

## Acceptance Criteria

- Evaluation guidance defines when an evaluator pass is required.
- Evaluation guidance distinguishes honest proof from surface-only or stub-only
  completion.
- Story template includes evaluator acceptance criteria and failure thresholds.
- Handoff template captures current state, next action, commands, touched files,
  evaluation notes, and remaining gaps.
- Test matrix evidence rules state that stub-only work cannot be marked
  implemented.
- Future multi-agent orchestration is recorded as a backlog item rather than
  scaffolded prematurely.

## Design Notes

- Commands: none.
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: builder and evaluator roles can be separate people, separate
  agents, or one session deliberately switching posture.
- UI surfaces: none.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Not applicable; documentation-only harness change. |
| Integration | Installer syntax check proves updated allowlist still parses. |
| E2E | Not applicable; no app or executable harness workflow exists. |
| Platform | Shell syntax check for installer script. |
| Release | Not applicable until package/release automation exists. |

## Evaluator Contract

Evaluator acceptance criteria:

- New evaluation guidance can be read independently of the source article.
- The story template makes evaluator expectations visible before execution.
- The handoff template is generic and does not assume a specific agent runtime.
- No app scaffolding, CI, package scripts, or fake tests are introduced.

Failure thresholds:

- Any new document implies runnable automation that does not exist.
- Test matrix rules allow surface-only work to count as implemented.
- Installer allowlist omits new reusable harness files.

## Harness Delta

Adds evaluator and handoff surfaces inspired by long-running application
development harness design. Defers actual multi-agent orchestration until a
real project or repeated harness work proves the need.

## Evidence

- `bash -n scripts/install-harness.sh`
- `scripts/install-harness.sh --directory "$TMP" --yes --dry-run`
- `scripts/install-harness.sh --directory "$TMP" --yes`
- Manual document review against acceptance criteria.
