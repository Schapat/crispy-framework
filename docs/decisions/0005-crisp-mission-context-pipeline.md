# 0005 Crisp Mission Context Pipeline

Date: 2026-05-17

## Status

Accepted

## Context

Harness v0 already defines work intake, story packets, evaluation posture,
handoffs, continuity, and governance-first project start. Two additional ideas
now shape the next iteration:

- staged context engineering: break research, design, structure, plan, work,
  and validation into smaller artifacts instead of one large prompt or plan
- mission-style multi-agent work: use orchestrator, discovery, worker, and
  validator roles with clean context, structured handoffs, validation contracts,
  and serial file writes

The repository still has no application implementation and no mission runner.

## Decision

Adopt Crisp Harness as the next operating model for this repository.

Crisp Harness combines the existing governance harness with:

- objective research questions and facts
- human-reviewable design concepts
- vertical structure outlines
- pre-implementation validation contracts
- mission plans for assigning slices
- role docs for orchestrator, discovery, worker, and validator agents
- serial writes with parallel read-only research or review

`AGENTS.md` remains the single agent entrypoint. Role docs are supporting
guidance, not replacements.

No router script, app scaffolding, CI, package scripts, or fake validation
commands are added by this decision.

## Consequences

Positive:

- Humans review shorter alignment artifacts before code exists.
- Agents can resume from files instead of chat memory.
- Validation expectations are defined before worker implementation.
- Multi-agent work has clear write boundaries and handoff expectations.

Tradeoffs:

- More templates exist, so agents must choose them only when the lane warrants
  the extra structure.
- Full mission automation remains future work.
- Historical harness evidence may still mention older repository names or
  commands that were true when the evidence was recorded.

## Follow-Up

- Add mission orchestration automation only after a selected story proves the
  command shape, state model, and validation behavior.
