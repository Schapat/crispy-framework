# 0013 Non-Overwriting Installer

Date: 2026-05-17

## Status

Accepted

## Context

Existing projects are first-class Crisp Harness targets. An installer override
mode could replace a target project's local `AGENTS.md` or `docs/` after moving
them to a backup folder. Even with backups, that mode increases risk and
complexity for humans incorporating the framework into real projects.

The desired installer behavior is simpler: create files that do not exist,
preserve existing local files, and make the harness discoverable when a target
already has local agent instructions.

## Decision

Remove installer override behavior.

The installer now uses merge behavior by default. It creates missing harness
files, appends a marked Crisp Harness section to an existing `AGENTS.md` once,
and skips other existing files. It does not overwrite, replace, move, or back up
target files.

## Alternatives Considered

1. Keep override mode with stronger warnings. Rejected because it still leaves a
   risky path for replacing existing project governance.
2. Stop when protected paths exist. Rejected because existing projects are
   first-class and should be able to receive missing harness files.
3. Add an interactive conflict resolver. Deferred because local adaptation
   should happen through human review and AI-agent edits after installation, not
   inside the installer.

## Consequences

Positive:

- Existing projects cannot be overwritten by the installer.
- Existing project agent instructions remain in place while receiving a compact
  pointer to Crisp Harness.
- The installer contract is easier to explain: create missing files, augment
  existing `AGENTS.md`, skip other existing files.
- Humans can ask an AI agent to adapt the harness manually after install.

Tradeoffs:

- The installer no longer provides a one-command way to replace existing
  governance files.
- A target project with conflicting old files still needs manual review and
  local adaptation.

## Follow-Up

- If repeated installs need structured adaptation help, add an agent-facing
  adaptation checklist instead of restoring overwrite behavior.
