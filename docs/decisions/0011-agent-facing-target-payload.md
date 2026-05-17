# 0011 Agent-Facing Target Payload

Date: 2026-05-17

## Status

Accepted

## Context

Crisp Harness is meant to help AI agents work inside real projects after the
framework is incorporated. Human-facing helper scripts can make the installed
surface feel heavier than necessary, especially during the initial phase.

The source repository may keep scripts for developing, installing, and
validating the framework itself. Target projects need the agent-facing operating
model: `AGENTS.md`, docs, templates, traceability surfaces, and decisions.

## Decision

Do not install source helper scripts into target projects.

The installer payload should contain the agent-facing markdown harness and
templates only. Source scripts remain in this framework repository for local
development and future remote installation work.

## Alternatives Considered

1. Install `scripts/governance-intake` into target projects. Rejected because
   the harness should be easy for humans to incorporate by asking an AI agent to
   adapt the markdown operating model, without learning extra commands.
2. Install `scripts/test-governance-intake.sh` as a target self-test. Rejected
   because it validates source-framework behavior and adds clutter to target
   projects.
3. Keep all scripts in target installs for completeness. Rejected because the
   target payload should stay focused on AI-agent collaboration surfaces.

## Consequences

Positive:

- Target projects receive a smaller, clearer harness.
- Humans can incorporate the framework without learning helper commands.
- Source-only validation scripts remain available where they belong: in the
  framework repository.

Tradeoffs:

- Target projects cannot run the source governance-intake helper unless they
  copy it deliberately later.
- Source docs and target-installed docs must avoid implying target helper
  scripts exist.

## Follow-Up

- If real target projects repeatedly need helper commands, add a new story that
  defines a target-safe command payload and validation model.
