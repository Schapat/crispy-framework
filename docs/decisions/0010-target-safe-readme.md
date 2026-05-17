# 0010 Target-Safe Root README

Date: 2026-05-17

## Status

Accepted

## Context

The harness source repository's root `README.md` describes `crisp-harness` as a
framework repository. That is correct for this repository, but wrong for target
projects that receive the harness. A target project's root README should
eventually describe the target product, stack, setup commands, validation
commands, and local workflow.

The installer previously copied the source README into target projects when no
target README existed.

## Decision

Do not install the source repository's root `README.md` into target projects.

Target installs receive `docs/templates/seed/README.md` as a target-safe
canonical default. The seed README explains that the project uses Crisp Harness
and should be adapted into the target project's real README as local product
truth appears.

## Alternatives Considered

1. Copy source `README.md` directly. Rejected because it would make target
   projects inherit the framework repository's identity.
2. Omit root `README.md` from target installs. Rejected because new empty
   target projects benefit from a simple starting point and agent navigation
   surface.
3. Generate a project-specific README during install. Deferred because the
   one-time framework copy model can start with a static target-safe seed.

## Consequences

Positive:

- Target projects get a useful root README without source-repository identity
  leakage.
- Existing projects can keep their README untouched in cautious merge mode.
- New projects have a clear place to document local setup and validation later.

Tradeoffs:

- The source repository now maintains a source README and a target-safe seed
  README.
- Future operating model changes may need updates in both files when they apply
  to both contexts.

## Follow-Up

- When remote installer hardening begins, verify the published installer fetches
  the target-safe README seed.
