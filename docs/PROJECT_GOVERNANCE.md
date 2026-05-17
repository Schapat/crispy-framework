# Project Governance

This document defines the reusable governance layer this harness provides before
AI-assisted coding begins.

The harness is intentionally general. It should work for many project types
without assuming a web app, SaaS product, database, mobile shell, CLI, or any
specific stack.

## Governance Purpose

The harness helps humans and agents agree on:

- current source of truth
- accepted product or project intent
- unknowns and assumptions
- risk boundaries
- first safe work slice
- proof expectations
- evaluation and handoff rules
- decisions that should outlive chat history

The harness may prepare a project for implementation, but it does not choose or
scaffold implementation technology unless the human explicitly asks and the
selected story requires it.

## Governance Surfaces

Core governance files:

- `AGENTS.md`: operating guide for AI agents.
- `docs/HARNESS.md`: central governance model.
- `docs/WORK_INTAKE.md`: request classification and lane routing.
- `docs/PROJECT_START.md`: project-start intake flow.
- `docs/PROJECT_ADOPTION.md`: existing-project adoption flow.
- `docs/CONTINUITY.md`: pause, resume, and handoff rules.
- `docs/AGENT_ONBOARDING.md`: how a new AI agent joins an existing project.
- `docs/EVALUATION.md`: evaluator posture and failure thresholds.
- `docs/TEST_MATRIX.md`: behavior-to-proof control panel.
- `docs/decisions/`: durable rationale.

Project-specific truth should be derived into `docs/product/` only after a real
project spec or prompt exists.

## Governance Before Code

Before coding, a project should have enough governance to answer:

1. What are we building?
2. Who or what is it for?
3. What is explicitly in scope?
4. What is explicitly out of scope?
5. What is unknown?
6. What risks require careful handling?
7. What is the first safe slice?
8. What proof will count as done?
9. What should the next agent read first?

If those answers are missing, the correct next step is intake or project-start
work, not implementation.

## Stack Neutrality

Agents should not assume:

- frontend framework
- backend framework
- database
- hosting provider
- authentication provider
- test runner
- package manager
- CI system

Stack choices become governance decisions when they constrain future work. Record
them in `docs/decisions/` when they are accepted.

## Human Authority

The human owns goals, constraints, and tradeoffs. The harness can recommend
lanes, artifacts, and proof, but it should not silently convert ambiguous human
intent into implementation commitments.

When direction is unclear, preserve the ambiguity in intake notes, decisions, or
open questions instead of hiding it in code.

When a core file, product rule, validation command, or local convention is
missing, agents should ask the human a specific question instead of guessing.
Durable answers should be captured in the appropriate product doc, story,
decision, test matrix row, or harness backlog item.

## Agent-First Operation

Target projects should be usable by AI agents through the markdown operating
model alone. Helper scripts may exist in the harness source repository for
framework development and validation, but target installs should not require a
human-facing command to begin governance work.

Agents should:

- ask structured project-start questions
- preview the artifact plan before writing
- write markdown files using harness templates
- leave unknowns visible
- stop before implementation unless the human explicitly chooses a later
  implementation story
