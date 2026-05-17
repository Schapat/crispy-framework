# Documentation Map

This directory holds the project harness and any product contract derived from a
future user-provided spec.

## Main Files

- `HARNESS.md`: central governance model for human-agent work.
- `PROJECT_GOVERNANCE.md`: general governance rules before coding starts.
- `PROJECT_START.md`: how a new project becomes governed artifacts.
- `PROJECT_ADOPTION.md`: how an existing project adopts the harness safely.
- `WORK_INTAKE.md`: how prompts become tiny, normal, or high-risk work.
- `CONTINUITY.md`: how unfinished work is paused, resumed, or handed off.
- `AGENT_ONBOARDING.md`: how a new AI agent joins a project/session.
- `AGENT_ROLES.md`: role guidance for orchestrator, discovery, worker, and
  validator contexts.
- `ARCHITECTURE.md`: architecture discovery and boundary rules.
- `EVALUATION.md`: evaluator role, failure thresholds, and stub detection.
- `TEST_MATRIX.md`: living map of behavior to proof.
- `HARNESS_BACKLOG.md`: improvements discovered while working.
- `GLOSSARY.md`: shared terms.

## Folders

- `product/`: current product truth, empty until a spec is derived.
- `intake/`: input snapshots from user prompts, supplied specs, governance
  intake, or future TUI output. These are source material, not living product
  truth.
- `stories/`: feature packets and backlog.
- `handoffs/`: resume notes for unfinished or transferred work.
- `decisions/`: durable decisions and tradeoffs.
- `templates/`: reusable spec-intake, story, context, mission, handoff,
  decision, and validation formats.

## Current State

Crisp Harness v0 exists before implementation. These docs define how the
project will grow; they do not imply that app code, tests, CI, mission
automation, or deployment automation exist yet.
