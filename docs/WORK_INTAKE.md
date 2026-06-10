# Work Intake

Every work request enters the intake gate before code changes. A new project
spec also enters through this gate before it becomes product docs, stories, or
implementation work.

The human does not need to classify risk. The harness does.

## Intake Flow

```text
User prompt
    |
    v
Check continuity state
    |
    v
Classify input type
    |
    v
Restate as work item
    |
    v
Find affected product docs and stories
    |
    v
Run risk checklist
    |
    v
Choose lane: tiny, normal, or high-risk
```

If `docs/ADOPTION_STATUS.md` exists and says `not_started`, classify the next
project-context task as first existing-project adoption unless the human
explicitly asks for unrelated work.

## Input Types

Use the input type to decide where the work should land before choosing the risk
lane. Store user/spec/TUI input in `docs/intake/` when it needs to remain
traceable, then derive living product truth into product docs, stories, test
matrix rows, and decisions.

| Type | Use when | Typical artifact |
| --- | --- | --- |
| New spec | Turning a user-provided project spec into harness-ready docs | Product docs, candidate epics, decisions |
| Spec slice | Implementing selected behavior from an accepted spec | Story packet |
| Change request | Changing, fixing, or refining accepted behavior | Story packet or direct patch |
| New initiative | Adding a larger product area that needs multiple stories | Initiative notes plus story packets |
| Maintenance request | Changing technical, operational, or dependency behavior | Story packet, validation report, or decision |
| Existing-project adoption | Incorporating the harness into a project that already has local code, docs, tests, commands, or conventions | `docs/PROJECT_ADOPTION.md`, adapted `AGENTS.md`, story backlog and packet, product docs, matrix rows, decisions |
| First existing-project adoption | First run after Crisp Harness is installed into an existing project | `docs/ADOPTION_STATUS.md`, `docs/FIRST_ADOPTION.md`, adoption story or blocker |
| Harness improvement | Improving how humans and agents collaborate | Direct docs update or `docs/HARNESS_BACKLOG.md` |
| Prototype or spike | Answering one narrow implementation, provider, feasibility, or design question before committing to production work | `docs/templates/prototype.md`, story note, decision, or backlog item |
| Resume request | Continuing paused, blocked, or handed-off work | Handoff review plus story or matrix update |

Do not create or extend a monolithic spec by default after intake. Use product
docs, stories, decisions, and initiative notes as the living surface.

## Durable Layer

When `scripts/bin/harness-cli` exists, use it as the queryable operational layer
alongside markdown:

- `scripts/bin/harness-cli intake ...` records work classification.
- `scripts/bin/harness-cli query matrix` shows durable story proof state.
- `scripts/bin/harness-cli story add/update` records story status and proof
  flags.
- `scripts/bin/harness-cli trace ...` records execution evidence.
- `scripts/bin/harness-cli audit` and `propose` surface drift and improvement
  candidates.

Markdown docs, story packets, decisions, and `docs/TEST_MATRIX.md` remain the
reviewable source of accepted contract changes. The local `harness.db` is
ignored by git and stores operational records that help agents query history.

## Lanes

### Tiny

Use for low-risk docs, copy, names, or narrow edits.

Requirements:

- Patch directly.
- Keep affected docs current.
- Run available quick checks.
- Update the harness only if friction was found.
- Leave Minimal trace evidence when the task changes accepted harness behavior
  or discovers friction.

### Normal

Use for story-sized behavior with bounded blast radius.

Requirements:

- Create or update one story file from `docs/templates/story.md`.
- Link relevant product docs.
- Add or update validation expectations.
- Use Crisp context artifacts when the work changes reusable contracts, has
  uncertainty, requires implementation planning, may span sessions, or benefits
  from multiple agents:
  `context-questions`, `research-facts`, `design-concept`,
  `structure-outline`, `validation-contract`, and `mission-plan`.
- Prefer vertical slices with proof checkpoints over horizontal plans that do
  all data, then all services, then all interfaces at once.
- Implement the smallest vertical slice when implementation exists.
- Update `docs/TEST_MATRIX.md` and durable story state when the CLI is
  available.
- Leave Standard trace evidence using `docs/TRACE_SPEC.md`.
- Mark `Execution Mode: AFK` only when an agent can continue without hidden
  human decisions, credentials, or external access. Otherwise use `HITL` and
  state the specific human need.

### High-Risk

Use when the work can affect security, data, scope, contracts, or multiple
roles/platforms.

Requirements:

- Create a story folder using `docs/templates/high-risk-story/`.
- Fill in `execplan.md`, `overview.md`, `design.md`, and `validation.md`.
- Add a validation contract before implementation.
- Use a structure outline that names serial write boundaries and milestone
  validation checkpoints.
- Ask for human confirmation before implementation if direction is ambiguous.
- Record a decision when behavior or architecture changes meaningfully.
- Leave Detailed trace evidence using `docs/TRACE_SPEC.md`.

## Crisp Mission Routing

Use the full pipeline for high-risk, long-running, multi-agent, or resumed work.
For normal work, route through these artifacts when uncertainty, reusable
contracts, validation expectations, or coordination needs justify it:

| Stage | Template | Purpose |
| --- | --- | --- |
| Questions | `docs/templates/context-questions.md` | Turn intent into focused research questions and unknowns. |
| Research | `docs/templates/research-facts.md` | Capture objective facts without implementation opinions. |
| Design | `docs/templates/design-concept.md` | Align on current state, desired state, patterns, and decisions. |
| Structure | `docs/templates/structure-outline.md` | Define vertical slices, order, and proof checkpoints. |
| Validation | `docs/templates/validation-contract.md` | Define correctness before implementation. |
| Mission | `docs/templates/mission-plan.md` | Assign slices, handoffs, validators, and stop conditions. |

Use `docs/CONTEXT_RULES.md` when a task needs more precise guidance about what
to read during intake, planning, implementation, validation, or trace phases.
Use `docs/HARNESS_COMPONENTS.md` and `docs/HARNESS_MATURITY.md` when a task
makes observability, maturity, or harness-friction claims.

`AGENTS.md` remains the first entrypoint. Use `docs/AGENT_ROLES.md` only when role
separation helps the work.

Serial writes are the default for mission work: one worker or validator modifies
files at a time. Parallel read-only discovery and review are allowed when the
questions are independent.

## Risk Checklist

Mark one flag for each item that applies:

| Risk flag | Applies when the work touches |
| --- | --- |
| Auth | login, logout, sessions, JWT, password, refresh token |
| Authorization | roles, permissions, tenant or company scope |
| Data model | schema, migrations, uniqueness, deletion, retention |
| Audit/security | audit logs, privacy, sensitive data, access logs |
| External systems | email, payments, cloud services, provider SDKs, queues, webhooks |
| Public contracts | API shape, response envelope, client-visible behavior |
| Cross-platform | desktop/mobile/browser split, native shell behavior, deep links |
| Existing behavior | already implemented or test-covered behavior changes |
| Weak proof | unclear or missing tests around the affected area |
| Multi-domain | more than one product domain changes at once |

## Classification

```text
0-1 flags:
  tiny or normal, based on code impact

2-3 flags:
  normal with stronger validation

4+ flags:
  high-risk

Any hard gate:
  high-risk unless the human explicitly narrows scope
```

Hard gates:

- Auth.
- Authorization.
- Data loss or migration.
- Audit/security.
- External provider behavior.
- Removing or weakening validation requirements.

## Prototype Policy

Use a prototype only to answer one named question. Give it one run command, a
timebox, allowed write scope, forbidden changes, expected signal, and cleanup
plan. Prototype code is not implementation proof until it is absorbed into a
story and validated through the story's contract.

Delete the prototype or record the decision it informed before marking related
work implemented.

## Output

At the end of intake, the agent should be able to say:

```text
Lane: normal
Reason: touches authorization, API contract, and audit behavior.
Docs: permissions, account-settings, audit-log.
Story: docs/stories/epics/E02-access-control/ST-014-manager-updates-role.md.
Validation: unit, integration, E2E.
Trace: Standard evidence in story and test matrix.
```

For resume requests, include:

```text
Handoff: docs/handoffs/HANDOFF-YYYYMMDD-topic.md.
Status: paused.
Next action: update the story packet before editing code.
```
