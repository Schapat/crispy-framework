# Agent Onboarding

Use this guide when a new AI agent joins the project, especially when continuing
work from a previous session.

The goal is to make the new agent useful without relying on hidden chat history.

## First Five Minutes

Read `README.md`, `AGENTS.md`, and `docs/WORK_INTAKE.md`. Then follow the
source router in `AGENTS.md` instead of reading every harness file by default.

For resume work, also read `docs/CONTINUITY.md`, `docs/handoffs/README.md`, and
the relevant active handoff before editing.

## Onboarding Questions

The agent should answer these before acting:

1. What kind of repository is this right now?
2. Is there product implementation yet?
3. What is the current source of truth for the user's request?
4. Are there active handoffs, paused stories, or blockers?
5. What lane does the new request belong to?
6. What proof would make completion honest?
7. Is an evaluator pass or handoff required?
8. Does the work need Crisp context artifacts or role separation?

## Resume Existing Work

If active handoffs or paused stories exist:

1. Read the newest relevant handoff.
2. Check whether listed files still match current repo state.
3. Check story status and test matrix rows.
4. Run the cheapest relevant verification command if one exists.
5. Continue from the handoff's single next action.

If the human asks for unrelated new work, mention the active handoff briefly and
continue with the requested work unless the old state creates risk.

## Start New Work

If there is no active handoff or the human starts a new task:

1. Classify through `docs/WORK_INTAKE.md`.
2. Identify affected product or governance docs.
3. Snapshot user/spec/TUI input in `docs/intake/` when it should remain
   traceable, then create or update the right story, packet, or product doc.
4. Define proof expectations before implementation.
5. Use the full Crisp pipeline for high-risk, long-running, multi-agent, or
   resumed work. For normal work, create context questions, research facts,
   design concept, structure outline, validation contract, and mission plan
   artifacts when uncertainty, contracts, proof, or coordination justify them.
6. Keep continuity notes if the work may outlive the session.

## Before Final Response

The agent should verify:

- requested change is done or blocker is documented
- affected docs and stories are current
- test matrix or evidence notes are honest
- evaluator notes exist when required
- handoff exists if work is unfinished
- final response states what changed, what was checked, and what was not
  attempted
