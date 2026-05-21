# Work States

Use this file for local story states and readiness conventions.

## Story Status

- `planned`: accepted or candidate work exists but has not started.
- `in_progress`: actively being worked.
- `paused`: started but intentionally stopped with a handoff.
- `blocked`: cannot continue until missing input, decision, or external event
  is resolved.
- `implemented`: completed with honest evidence.
- `changed`: contract changed after prior work or proof.
- `retired`: no longer part of accepted work.

## Execution Mode

- `AFK`: an agent can proceed without ongoing human input after intake.
- `HITL`: human review, decision-making, credentials, design judgment, or
  external access is expected before completion.

## Readiness

- `needs-triage`: scope, lane, or owner is not clear.
- `needs-info`: a specific missing answer blocks useful work.
- `ready-for-agent`: scope, files, validation, and stop conditions are clear.
- `ready-for-human`: a human decision or review is the next useful action.

## Escalation Rule

If a story is marked `AFK` but an agent discovers a missing decision, credential,
external access need, or unclear validation expectation, change it to `HITL` or
`blocked`, write the specific question, and leave a handoff if work has started.
