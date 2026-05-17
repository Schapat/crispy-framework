# 0012 Existing Projects Are First-Class Targets

Date: 2026-05-17

## Status

Accepted

## Context

Crisp Harness can be incorporated into new or existing projects. Several
decisions already support existing projects: cautious merge, target-safe
`AGENTS.md`, target-safe `README.md`, one-time framework copy, and local
adaptation.

If existing projects are not first-class, agents may treat the harness as a
greenfield-only scaffold and ignore local code, tests, docs, scripts, or team
workflow that already exist.

## Decision

Treat existing projects with code, docs, tests, scripts, and local conventions
as first-class target projects.

The harness should install cautiously, preserve existing project identity, and
guide agents to discover and adapt to local truth instead of assuming a blank
slate.

## Alternatives Considered

1. Optimize v0 only for empty new projects. Rejected because the framework is
   intended to improve AI-agent collaboration in real projects, including ones
   that already exist.
2. Provide a separate existing-project mode now. Deferred because cautious merge
   and target-safe seeds are enough for the current framework phase.

## Consequences

Positive:

- The framework can be incorporated into real projects without erasing local
  identity.
- Agents are instructed to treat existing code, docs, tests, and validation
  commands as local truth.
- Installer safety remains central.

Tradeoffs:

- Existing-project installs require human review and agent adaptation.
- The framework must avoid greenfield-only language in target-installed docs.

## Follow-Up

- After real existing-project installs, add a story if a dedicated adaptation
  checklist or template proves necessary.
