# Agent Operating Guide

This repository is in Crisp Harness v0. There is no product implementation yet.

The current job of agents is to preserve and grow the collaboration harness
before writing application code. Do not scaffold application source folders,
platform shells, package scripts, CI, or tests unless a later story explicitly
moves the project into implementation.

## Source Router

Always read `README.md`, this file, and `docs/WORK_INTAKE.md` first. Then read
only the lane-specific files needed for the task:

| Situation | Read next |
| --- | --- |
| Tiny docs or copy change | affected files only |
| New project/spec intake | `docs/PROJECT_START.md`, `docs/templates/spec-intake.md` |
| First existing-project adoption | `docs/ADOPTION_STATUS.md`, `docs/FIRST_ADOPTION.md`, `docs/PROJECT_ADOPTION.md` only if full checklist is needed |
| Normal story-sized work | related story, `docs/TEST_MATRIX.md`, relevant `docs/product/` files |
| High-risk or architecture-shaping work | `docs/ARCHITECTURE.md`, `docs/EVALUATION.md`, relevant decisions |
| Long-running or multi-agent work | `docs/AGENT_ROLES.md`, selected Crisp templates, `docs/templates/handoff.md` |
| Resume or inherited work | `docs/CONTINUITY.md`, `docs/AGENT_ONBOARDING.md`, active handoff |

Use `docs/HARNESS.md` for the full governance model and `docs/decisions/` only
when rationale matters for the current change.
Use `docs/agents/` when local issue tracker rules, story readiness states, or
domain-language conventions matter for the current task.
If `docs/ADOPTION_STATUS.md` exists and says `not_started`, route through
`docs/FIRST_ADOPTION.md` before normal work.

This harness does not ship with a project-specific `SPEC.md`. When the human
provides a spec for a new project, treat that spec as input material for the
first buildout. Derive product docs, story packets, architecture decisions, and
validation expectations from it. Product docs, stories, tests, and decisions
then become the living contract that agents should update as the system evolves.

## Task Loop

For every task:

1. Classify the request with `docs/WORK_INTAKE.md`.
2. Identify whether the input is a new spec, spec slice, change request, new
   initiative, maintenance request, or harness improvement.
3. Check for active handoffs or paused stories unless the human explicitly
   starts unrelated work.
4. Locate the affected product docs, story files, proof rows, and decisions.
5. Check `docs/TEST_MATRIX.md` for existing proof and gaps.
6. Work only inside the selected lane: tiny, normal, or high-risk.
7. Use the full Crisp pipeline for high-risk, long-running, multi-agent, or
   resumed work. For normal work, use Crisp artifacts when uncertainty,
   contracts, proof expectations, or coordination needs justify them.
8. Before finishing, ask:
   - Did product truth change?
   - Did validation expectations change?
   - Did evaluator expectations or handoff needs change?
   - Did architecture rules change?
   - Did we discover a repeated failure pattern?
   - Did the next agent need a clearer instruction?
9. Update routine harness files directly, or add a proposal to
   `docs/HARNESS_BACKLOG.md` when the change is structural.

## Crisp Mission Rules

Use `docs/AGENT_ROLES.md` when separate context windows or multiple
agents are helpful.

- Orchestrator owns scope alignment and staged context artifacts.
- Discovery reports facts without implementation opinions.
- Worker edits one assigned vertical slice and writes a handoff.
- Validator checks against the validation contract and evidence.
- Only one worker or validator should modify files at a time.
- Parallel agents may perform read-only research or review when their questions
  are independent.

## Harness Change Policy

Agents may update directly:

- Story status and evidence.
- `docs/TEST_MATRIX.md` rows.
- Links from story packets to product docs.
- Evaluation notes and handoff artifacts.
- Validation notes and reports.
- Small clarifications tied to the current task.

Agents should ask for human confirmation before:

- Changing architecture direction.
- Removing validation requirements.
- Changing the source-of-truth hierarchy.
- Changing risk classification rules.
- Replacing the feature workflow.

## Done Definition

A task is done only when:

- The requested change is completed or the blocker is documented.
- Relevant docs, stories, and test matrix entries remain current.
- Validation commands were run when they exist.
- Evaluator or handoff notes exist when the work is long-running, normal lane,
  high-risk, or likely to be resumed by another agent.
- Unfinished work is marked `paused` or `blocked` and has a handoff under
  `docs/handoffs/`.
- Missing harness capabilities were added to `docs/HARNESS_BACKLOG.md`.
- The final response says what changed and what was not attempted.
