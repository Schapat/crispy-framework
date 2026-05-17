# 0008 Remote Installer Distribution

Date: 2026-05-17

## Status

Accepted

## Context

Crisp Harness is still in its initial local phase and has not been committed to
GitHub yet. The installer currently works from a local checkout and is intended
to support a simple remote `curl | bash` install after publication.

The intended use is that a human can later apply the framework to a new or
existing target project from a published repository.

## Decision

Treat `scripts/install-harness.sh` as the future remote installer for Crisp
Harness.

Do not focus on full remote installer hardening during the initial local phase.
After the first GitHub commit, revisit the script, documentation, and validation
for remote installation.

The remote installer still follows the one-time framework copy model. It should
not create an ongoing upstream dependency between the harness source repository
and target projects.

## Alternatives Considered

1. Treat the installer primarily as a local checkout utility. Rejected because
   the intended framework distribution path is remote installation after
   publication.
2. Fully harden remote installation before the initial GitHub commit. Rejected
   because the repository is still early and the remote URL, branch, and
   publication contract are not settled yet.

## Consequences

Positive:

- The script keeps its intended distribution role visible.
- Initial work can stay focused on the framework architecture instead of
  publication polish.
- Remote hardening has a clear follow-up trigger: after the initial GitHub
  commit.

Tradeoffs:

- Remote install documentation remains provisional until the repository is
  published.
- The current validation is enough for local behavior, but not yet a full
  release-quality remote installer proof.

## Follow-Up

- After the initial GitHub commit, add or select a story for remote installer
  hardening and validation.
