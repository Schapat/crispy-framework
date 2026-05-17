# 0007 One-Time Framework Copy

Date: 2026-05-17

## Status

Accepted

## Context

Crisp Harness is still in its initial phase and has not been published to
GitHub. The repository acts as a reusable framework that can later be copied
into new or existing projects to make collaboration with AI agents safer and
more inspectable.

An installer exists for that purpose, but target projects may quickly develop
their own local product truth, agent instructions, proof expectations, and
decision history after installation.

## Decision

Treat installation as a one-time framework copy.

After install, a target project owns its local harness files and adaptations.
This source repository does not remain an ongoing upstream dependency for target
projects.

## Alternatives Considered

1. Keep target projects tied to this source repository for future updates.
   Rejected for now because the framework is still early and target projects
   need freedom to adapt their local harness to their own product, stack, and
   agent workflow.
2. Add an upgrade or sync mechanism now. Rejected until repeated target-project
   use proves which parts should stay standardized and which should be locally
   owned.

## Consequences

Positive:

- Target projects can adapt the harness without waiting for upstream changes.
- The source repository can evolve as a framework without implying automatic
  control over installed projects.
- The installer stays simple and easier to reason about during the initial
  phase.

Tradeoffs:

- Improvements made in this source repository will not automatically reach
  target projects.
- Future upgrade support will need an explicit story and conflict model if it
  becomes valuable.

## Follow-Up

- Add an upgrade story only after real target-project usage shows a repeated
  need.
