# Crisp Harness Demo

This demo explains how a team should expect to work after adding Crisp Harness
to a repository.

Crisp Harness is not an app template. It does not install a frontend, backend,
package scripts, CI, or fake tests. It installs a collaboration layer for humans
and coding agents: entrypoint instructions, work intake, product docs, story
packets, validation expectations, decisions, handoffs, trace evidence, and an
optional local CLI-backed durable layer.

Use this demo to understand the workflow. Do not copy its sample product
details into a real target project. Target projects should derive their own
truth from their existing README, docs, source code, tests, scripts, and human
intent.

## What A User Should Expect

After installing Crisp Harness into a project, the first useful result is not
application code. The first result is a repository that tells an agent:

- what to read first
- whether the current request is tiny, normal, high-risk, adoption, or a new
  spec
- where accepted product truth lives
- what story or proof row owns the work
- which validation command should prove the change
- what decision, trace, or handoff future agents should inherit

Existing projects keep their local conventions. The installer creates missing
harness files, preserves existing project files, appends to an existing
`AGENTS.md` only when needed, and skips files that already exist. The target
project owns its harness after installation.

## Install Into A Project

From the target project directory:

```bash
curl -fsSL https://raw.githubusercontent.com/dzungbk156/crispy-framework/main/scripts/install-harness.sh | bash
```

Strict install that fails if the CLI binary cannot be downloaded:

```bash
curl -fsSL https://raw.githubusercontent.com/dzungbk156/crispy-framework/main/scripts/install-harness.sh | bash -s -- --require-cli
```

Install into another directory:

```bash
curl -fsSL https://raw.githubusercontent.com/dzungbk156/crispy-framework/main/scripts/install-harness.sh | bash -s -- --directory /path/to/project
```

Markdown-only install:

```bash
curl -fsSL https://raw.githubusercontent.com/dzungbk156/crispy-framework/main/scripts/install-harness.sh | bash -s -- --no-cli
```

The installer tries to place a verified CLI binary at
`scripts/bin/harness-cli`. The binary is ignored by git in target projects.

## First Adoption In An Existing Project

Fresh installs start with `docs/ADOPTION_STATUS.md` set to `not_started`.

Before normal feature work, an agent should follow `docs/FIRST_ADOPTION.md` and
adapt the harness to local truth:

1. Read only the minimal entrypoint set:
   - `README.md`
   - `AGENTS.md`
   - `docs/WORK_INTAKE.md`
   - `docs/ADOPTION_STATUS.md`
   - `docs/FIRST_ADOPTION.md`
2. Inventory the project purpose, source folders, runtimes, commands, docs,
   tests, scripts, and risky areas.
3. Update only useful harness files, usually:
   - `AGENTS.md`
   - `docs/agents/`
   - `docs/TEST_MATRIX.md`
   - `docs/stories/backlog.md`
   - `docs/product/` when stable product truth exists
4. Create an adoption story or record the blocker.
5. Set adoption status to `ready` or `blocked`.

The goal is not to rewrite the project. The goal is to make future agent work
safe, scoped, and reviewable.

## Normal Work Loop

Once adoption is ready, a typical request follows this loop:

```text
human request
  -> classify with docs/WORK_INTAKE.md
  -> find the affected product doc, story, matrix row, and decisions
  -> choose tiny, normal, or high-risk lane
  -> update or create the smallest useful story packet
  -> define validation before implementation
  -> make the change
  -> run the agreed proof
  -> update story, matrix, trace, and handoff state
```

Tiny work can be a direct patch with quick evidence. Normal work should have a
story packet when behavior, validation, or coordination needs to be durable.
High-risk work should use the full Crisp pipeline: context questions, research
facts, design concept, structure outline, validation contract, mission plan,
handoff, and validation.

## CLI Workflow

When `scripts/bin/harness-cli` exists, it gives agents a queryable local state
layer alongside the markdown docs:

```bash
scripts/bin/harness-cli init
scripts/bin/harness-cli migrate
scripts/bin/harness-cli import brownfield
scripts/bin/harness-cli query matrix
```

Useful task commands:

```bash
scripts/bin/harness-cli story add --id US-001 --title "Create task" --lane normal
scripts/bin/harness-cli story update --id US-001 --status implemented --unit 1 --platform 0
scripts/bin/harness-cli story verify US-001
scripts/bin/harness-cli trace --summary "Implemented US-001" --outcome completed
```

Markdown remains the reviewable source of product contracts and story details.
The local `harness.db` is ignored by git and stores operational records that
help agents query history.

## Example: New Product Spec

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

The row should not be marked implemented until proof exists. Proof should prefer
public interfaces, user-visible behavior, API contracts, command behavior, or
durable module boundaries. Tests that only prove private helper details are weak
proof unless that private boundary is the accepted contract for the slice.

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

## What Good Looks Like

A well-adopted target repo should eventually answer these questions without
requiring old chat history:

- What is the project?
- What local commands are safe and expected?
- Which product docs define accepted behavior?
- Which story owns the current change?
- What proof will make the work done?
- What decisions should future agents preserve?
- What unfinished work has a handoff?

If the harness cannot answer one of those questions, update the local harness or
add a proposal to `docs/HARNESS_BACKLOG.md`.
