# 0004 Governance-First Continuity

Date: 2026-05-17

## Status

Accepted

## Context

The harness was originally described as an agent-driven development harness.
That framing was useful, but too close to implementation. The intended use is
broader: prepare and govern AI-assisted software work before coding starts, and
preserve continuity when work spans sessions.

Without explicit continuity rules, unfinished work can be trapped in chat
history and future agents may restart, duplicate, or contradict prior work.

## Decision

Reframe the repository as a general AI-agent project governance harness.

Add first-class governance, project-start, continuity, and agent-onboarding
documents. Rename the former feature-intake document to `docs/WORK_INTAKE.md`
so intake applies to all work, not only features.

Unfinished work should be marked `paused` or `blocked` and resumed from
repository handoff artifacts under `docs/handoffs/`.

## Alternatives Considered

1. Keep the original feature-intake naming. Rejected because the harness governs
   specs, maintenance, evaluation, continuity, and onboarding, not only features.
2. Store continuity only inside story packets. Rejected because active handoffs
   need one obvious place for a new agent to scan.

## Consequences

Positive:

- The harness stays general across many project types.
- New AI agents have an onboarding path.
- Paused work can resume from files instead of chat memory.
- Future TUI work has a governance-first target.

Tradeoffs:

- More top-level governance docs exist.
- Agents must check handoffs before starting unrelated work unless the human
  explicitly redirects.

## Follow-Up

- Build a governance intake TUI only after a story defines prompts, generated
  files, and validation behavior.
