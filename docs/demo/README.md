# Harness Demo Walkthrough

This walkthrough shows the kind of transformation Crisp Harness is designed to
support. It is an example only. It is not an accepted product contract for this
repository, and it is not part of the target install payload.

Target projects should derive their own product truth, stories, decisions, and
proof from their local context. Existing projects should preserve their local
code, docs, tests, scripts, and conventions, then adapt the harness around that
truth. When local tracker rules, readiness states, or domain-language
conventions matter, record them under `docs/agents/` so future agents do not
need to rediscover them from chat.

For the first run after installing Crisp Harness into an existing project,
`docs/ADOPTION_STATUS.md` starts as `not_started`. The agent should follow
`docs/FIRST_ADOPTION.md` before normal feature work so it can adapt the harness
without loading every governance document.

## Input

A human brings a small product idea:

```text
Build a simple team task tracker where people can create tasks, assign them to
teammates, change status, and see what is overdue.
```

Without a harness, an agent might jump directly into framework selection,
database schema, UI scaffolding, and tests all at once.

Crisp Harness asks the agent to slow the work down just enough to make it
inspectable.

## Intake

The input is classified as a new spec because it introduces a new product idea
with no existing product contract.

The first output should not be app code. It should be a spec-intake note using
`docs/templates/spec-intake.md`.

If required context is missing, the agent should ask the human a specific
question instead of guessing, then capture durable answers in the right product
doc, story, decision, matrix row, or backlog item.

Example intake shape:

```text
Type: new spec
Lane: normal
Reason: creates a new product surface but does not yet touch auth, payments,
data migration, or external provider behavior.
Candidate product docs:
- docs/product/overview.md
- docs/product/glossary.md
- docs/product/tasks.md
- docs/product/assignment.md
Candidate epics:
- E01 Task capture and status tracking
- E02 Assignment and ownership
- E03 Overdue visibility
Validation shape:
- Unit proof for task status rules
- Integration proof for task persistence
- E2E proof for create, assign, and complete task flow
```

## Product Contract

After intake, the agent derives small product docs instead of treating the
original prompt as permanent truth.

When product-specific language becomes accepted, the agent can create
`docs/product/glossary.md` from `docs/templates/product-glossary.md`. That file
should define product terms such as "task", "assignee", "team backlog", or
"overdue" while `docs/GLOSSARY.md` remains reserved for harness and process
terms.

Example product contract fragments:

```text
docs/product/tasks.md

A task has a title, status, assignee, due date, and timestamps.
Supported statuses are todo, in_progress, done, and canceled.
Only open tasks can become overdue.
```

```text
docs/product/assignment.md

A task may be assigned to one teammate.
Unassigned tasks remain visible in the team backlog.
Changing assignee does not change task status.
```

## Story Packet

Once the product contract is clear enough, the agent creates a story packet from
`docs/templates/story.md`.

Tiny work can stay lightweight. Normal work should add Crisp context artifacts
only when uncertainty, contracts, proof expectations, or coordination justify
them. High-risk, long-running, resumed, or multi-agent work should use the full
pipeline: context questions, research facts, design concept, structure outline,
validation contract, mission plan, handoff, and validation.

Example story:

```text
Story: US-001 Create a task
Lane: normal
Execution Mode: AFK
Human needed for: none after product terms and validation expectations are clear
Ready for agent when: task fields, validation boundaries, and proof layers are
named in the story
Blocked by: no known blockers
Product contract: A teammate can create a task with title, optional assignee,
optional due date, and default status todo.
Acceptance criteria:
- Creating a task with a title succeeds.
- Creating a task without a title fails with a clear validation error.
- A new task starts in todo status.
- A created task appears in the team backlog.
Validation:
- Unit: task creation rules
- Integration: persistence and validation boundary
- E2E: create task from the visible task surface
```

If the story needs human decisions, credentials, design judgment, or external
access before completion, mark it `Execution Mode: HITL` and state the specific
human need instead of letting the blocker hide inside implementation.

## Test Matrix

The story then appears in `docs/TEST_MATRIX.md` so behavior and proof stay
linked.

Example row:

```text
| US-001 Create a task | docs/product/tasks.md | yes | yes | yes | no | planned | none |
```

The row should not be marked implemented until proof exists.
Proof should prefer public interfaces, user-visible behavior, API contracts,
command behavior, or durable module boundaries. Tests that only prove private
helper details are weak proof unless that private boundary is the accepted
contract for the slice.

In target projects, this proof history starts from the blank seed matrix. The
filled matrix rows in the harness source repository are temporary source
traceability, not target-project history.

## Decision Record

If the team chooses a stack, data model direction, or important product rule,
the agent records that decision under `docs/decisions/`.

Example decision:

```text
Decision: Tasks use a small explicit status set instead of free-form labels.

Reason: status drives overdue behavior, filtering, and validation, so the first
version needs a predictable state model.
```

## Prototype

If the team has one narrow unknown before implementation, use
`docs/templates/prototype.md` instead of quietly turning a spike into production
code.

Example prototype question:

```text
Can the selected browser storage option preserve task due dates accurately
across reloads in the chosen stack?
```

A prototype should have one run command, a timebox, allowed write scope,
forbidden changes, expected signal, and cleanup plan. It becomes implementation
proof only after the useful part is absorbed into a story and validated through
that story's contract.

## Implementation

Only after the contract, story, and proof shape are clear should implementation
begin.

For Crisp Harness, that distinction matters. The framework deliberately does not
install application folders, package scripts, CI, test commands, or source
helper scripts. Those should arrive only when a real target-project story
selects a real stack and needs them.

## Harness Delta

Every task also asks whether the harness itself should improve.

If this demo revealed that many projects need the same intake example, the
right follow-up might be:

```text
Add a reusable example-spec walkthrough or starter fixture.
```

Small improvements can be made directly. Larger process changes should be
proposed in `docs/HARNESS_BACKLOG.md`.
