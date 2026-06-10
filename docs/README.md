# Documentation Map

This directory holds the project harness and any product contract derived from a
future user-provided spec.

## Main Files

- `HARNESS.md`: central governance model for human-agent work.
- `PROJECT_GOVERNANCE.md`: general governance rules before coding starts.
- `PROJECT_START.md`: how a new project becomes governed artifacts.
- `PROJECT_ADOPTION.md`: how an existing project adopts the harness safely.
- `ADOPTION_STATUS.md`: first-adoption marker and readiness checklist.
- `FIRST_ADOPTION.md`: low-context first adoption workflow.
- `WORK_INTAKE.md`: how prompts become tiny, normal, or high-risk work.
- `CONTEXT_RULES.md`: what to read by phase, lane, and retrieval trigger.
- `TRACE_SPEC.md`: trace evidence fields, quality tiers, and friction capture.
- `HARNESS_COMPONENTS.md`: responsibility map for diagnosing harness gaps.
- `HARNESS_MATURITY.md`: measurable maturity ladder for harness growth.
- `CONTINUITY.md`: how unfinished work is paused, resumed, or handed off.
- `AGENT_ONBOARDING.md`: how a new AI agent joins a project/session.
- `agents/`: local agent configuration for issue trackers, work states, and
  domain-doc conventions.
- `AGENT_ROLES.md`: role guidance for orchestrator, discovery, worker, and
  validator contexts.
- `ARCHITECTURE.md`: architecture discovery and boundary rules.
- `EVALUATION.md`: evaluator role, failure thresholds, and stub detection.
- `TEST_MATRIX.md`: living map of behavior to proof.
- `TOOL_REGISTRY.md`: repository-local CLI command and tool registry contract.
- `HARNESS_AUDIT.md`: durable-state drift checks and entropy score.
- `IMPROVEMENT_PROTOCOL.md`: audit/friction-to-improvement proposal loop.
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

## Tooling

- `../scripts/schema/`: SQLite migrations for the local durable harness layer.
- `../scripts/bin/harness-cli`: ignored local CLI binary installed from release
  assets.
- `../crates/harness-cli/`: Rust source for the Harness CLI.

## Current State

Crisp Harness v0 exists before application implementation. These docs and the
local Harness CLI define how the project will grow; they do not imply that app
code, product tests, CI, mission automation, deployment automation, or a product
stack exist yet.
