# US-013 Agent Operating Loops

## Status

implemented

## Lane

normal

## Execution Mode

AFK

Human needed for:

- None after the approved improvement list.

Ready for agent when:

- The selected improvements are limited to reusable harness docs, templates,
  installer payload entries, and traceability rows.

Blocked by:

- Nothing.

## Product Contract

The harness incorporates practical agent operating loops inspired by external
engineering skills: local agent configuration, AFK/HITL story readiness,
domain-language separation, prototype policy, public-interface validation
quality, architecture review prompts, and explicit first-adoption routing.

## Relevant Product Docs

- `AGENTS.md`
- `README.md`
- `docs/HARNESS.md`
- `docs/demo/README.md`
- `docs/ADOPTION_STATUS.md`
- `docs/FIRST_ADOPTION.md`
- `docs/WORK_INTAKE.md`
- `docs/PROJECT_ADOPTION.md`
- `docs/ARCHITECTURE.md`
- `docs/agents/README.md`
- `docs/templates/story.md`
- `docs/templates/validation-contract.md`
- `docs/templates/prototype.md`
- `docs/templates/product-glossary.md`
- `scripts/install-harness.sh`

## Acceptance Criteria

- Target installs include `docs/agents/` docs for issue tracker, work states,
  and domain-doc conventions.
- Story templates include execution mode, human-needed, ready-for-agent, and
  blocker fields.
- Work intake includes prototype/spike routing and a prototype policy.
- Validation contracts include public-interface and refactor-resistant test
  quality guidance.
- Architecture guidance includes a lightweight boundary-review lens.
- Product docs document the split between domain glossary and harness glossary.
- The installer includes the new target-safe docs and templates.
- The demo walkthrough reflects the new agent configuration, story readiness,
  domain glossary, prototype, and validation-quality guidance.
- Target installs include an explicit adoption status marker and low-context
  first-adoption playbook that can back a `/first-adoption` style request.

## Evaluator Contract

Evaluator acceptance criteria:

- A target install includes the new `docs/agents/` files.
- A target install includes `docs/templates/prototype.md` and
  `docs/templates/product-glossary.md`.
- A target install includes `docs/ADOPTION_STATUS.md` with status
  `not_started` and `docs/FIRST_ADOPTION.md`.
- No new application source folders, package scripts, CI, or tests are
  scaffolded.
- Existing installer create-missing/skip-existing behavior remains unchanged.

Failure thresholds:

- New guidance only appears in source-repository docs and is not installed into
  target projects.
- The prototype policy treats temporary spike code as implementation proof.
- Domain-language guidance encourages fake product truth before a real spec
  exists.

Expected proof level:

- document review
- shell syntax
- source validation script
- installer dry-run and temp-target install probe

Artifacts to inspect:

- `docs/agents/`
- `docs/demo/README.md`
- `docs/ADOPTION_STATUS.md`
- `docs/FIRST_ADOPTION.md`
- `docs/templates/story.md`
- `docs/templates/validation-contract.md`
- `docs/templates/prototype.md`
- `docs/templates/product-glossary.md`
- `scripts/install-harness.sh`
- temp target docs

## Design Notes

- Commands: `scripts/install-harness.sh`.
- Queries: none.
- API: none.
- Tables: none.
- Domain rules: local agent configuration should be target-safe and editable
  after install; product glossary guidance must not create fake product truth;
  first adoption should have an explicit marker so agents do not infer status by
  reading the full harness.
- UI surfaces: none.

## Validation

| Layer | Expected proof |
| --- | --- |
| Unit | Shell syntax checks for harness scripts. |
| Integration | Temp-target install includes new docs and templates. |
| E2E | Not applicable; no app workflow exists. |
| Platform | Local Bash execution. |
| Release | Remote installer validation deferred until publication hardening. |

## Harness Delta

Adds target-safe agent configuration docs, story readiness fields, prototype and
product-glossary templates, validation quality guidance, architecture review
prompts, and explicit first-adoption status/routing docs.

## Evidence

- `bash -n scripts/install-harness.sh`
- `bash -n scripts/governance-intake`
- `bash -n scripts/test-governance-intake.sh`
- `scripts/test-governance-intake.sh`
- `scripts/install-harness.sh --directory "$tmpdir" --dry-run`
- `scripts/install-harness.sh --directory "$tmpdir"`
- Temp-target install confirmed `docs/agents/README.md`,
  `docs/agents/issue-tracker.md`, `docs/agents/work-states.md`,
  `docs/agents/domain-docs.md`, `docs/templates/prototype.md`, and
  `docs/templates/product-glossary.md` exist.
- Temp-target install confirmed `docs/ADOPTION_STATUS.md` starts at
  `not_started` and `docs/FIRST_ADOPTION.md` exists.
