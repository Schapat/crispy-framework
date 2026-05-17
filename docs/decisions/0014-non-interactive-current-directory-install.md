# 0014 Non-Interactive Current-Directory Install

Date: 2026-05-17

## Status

Accepted

## Context

Crisp Harness is intended to be incorporated into a real project by running a
simple installer command from that project's directory. The installer is not
part of the target payload, and target projects are meant to be operated by AI
agents through markdown docs and templates.

The installer previously prompted for a target directory when `--yes` was not
provided. That prompt adds a human-facing interaction step to a flow that should
be simple and non-interactive.

## Decision

Remove the installer target-directory prompt.

The installer defaults to the current directory and never asks where to install.
Humans may still pass `--directory <path>` or a positional path when needed, but
the intended remote flow is a simple command run from the target project
directory:

```bash
curl -fsSL https://raw.githubusercontent.com/vietdzungdang/agent-harness/main/scripts/install-harness.sh | bash
```

The raw GitHub URL is provisional until the first GitHub publication and should
be checked during remote installer hardening.

## Alternatives Considered

1. Keep the prompt as a convenience. Rejected because the target install path
   should be obvious: the current project directory.
2. Require `--directory`. Rejected because the desired remote install is a
   simple command run from the target project.

## Consequences

Positive:

- The remote installer flow is simpler.
- The script is easier to reason about and automate.
- Humans do not need to answer installer prompts before asking an AI agent to
  adapt the harness.

Tradeoffs:

- A user who runs the command from the wrong directory must remove the created
  missing files manually.
- The provisional raw GitHub URL must be revisited after publication.

## Follow-Up

- During remote installer hardening, verify the published raw URL and decide
  whether to keep the default source base in the script or generate it from the
  published command.
