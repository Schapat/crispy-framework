# Continuity

Continuity means unfinished work can resume from repository artifacts instead of
chat memory.

Every paused task should leave a clear resume point.

## When A Handoff Is Required

Create a handoff when:

- work started but is not complete
- a new session or another agent may continue
- context may expire before completion
- the task is normal or high-risk and has partial changes
- validation or evaluation found gaps that need later follow-up

Tiny untouched planning questions do not need a handoff. Once files change or a
story moves to `in_progress`, a handoff is expected if the task stops.

## Handoff Location

Use `docs/handoffs/` for active and historical handoffs.

Suggested path:

```text
docs/handoffs/HANDOFF-YYYYMMDD-story-or-topic.md
```

Use `docs/templates/handoff.md` as the template.

## Story Status For Continuity

Use these statuses:

- `planned`: accepted or candidate work exists but has not started
- `in_progress`: actively being worked
- `paused`: started but intentionally stopped with a handoff
- `blocked`: cannot continue until missing input, decision, or external event
  is resolved
- `implemented`: completed with honest evidence
- `changed`: contract changed after prior work or proof
- `retired`: no longer part of accepted work

`paused` means the next agent should look for a handoff. `blocked` means the
next agent should resolve or escalate the blocker before continuing.

## Pause Protocol

Before stopping unfinished work:

1. Update story status to `paused` or `blocked`.
2. Write a handoff under `docs/handoffs/`.
3. List files touched.
4. List commands run.
5. State the single next action.
6. Note proof that exists and proof still missing.
7. Update `docs/TEST_MATRIX.md` if behavior or proof status changed.
8. Add backlog or decision notes if the pause exposed harness friction.

## Resume Protocol

When continuing in a new session:

1. Read `README.md`, `AGENTS.md`, `docs/HARNESS.md`, and `docs/WORK_INTAKE.md`.
2. Read `docs/AGENT_ONBOARDING.md`.
3. Check `docs/handoffs/README.md` and active handoff files.
4. Check stories with `paused`, `blocked`, or `in_progress` status.
5. Check `docs/TEST_MATRIX.md` for `in_progress`, `changed`, stale, or missing
   evidence.
6. Inspect current repository status and files touched by the handoff.
7. Continue from the handoff's single next action, or route back through intake
   if reality has diverged.

## Divergence Rule

If the repository no longer matches the handoff, do not blindly continue.

First update the handoff, story, or test matrix to explain the divergence. If
the next step is unclear, classify the situation through `docs/WORK_INTAKE.md`
as a maintenance request or harness improvement.

## Closing A Handoff

Close a handoff when:

- the story reaches `implemented`, `retired`, or a new accepted state
- evidence is updated
- remaining gaps are moved into a story, backlog item, or decision record

Do not delete historical handoffs unless the repository adopts an explicit
archival policy later.
