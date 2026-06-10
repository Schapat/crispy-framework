# Trace Specification

A trace records what happened during a harness task. In Crisp Harness v0, traces
can live in both markdown evidence and the local durable layer. Use markdown
when the evidence must be reviewable in git, and use `scripts/bin/harness-cli
trace` when the work should be queryable later.

Markdown traces may live in a story's `Evidence` section, a validation report,
a handoff, or a dedicated note when the task is long-running. Durable traces
live in the ignored local `harness.db`.

The goal is not ceremony. The goal is to make future agents and reviewers able
to answer: what was attempted, what changed, what proof exists, what friction
appeared, and what remains uncertain?

## Fields

| Field | Required | Format | Example |
| --- | --- | --- | --- |
| Task summary | Yes | One sentence naming the outcome or attempted outcome. | Added durable trace recording for harness work. |
| Input type | Normal+ | One of the `docs/WORK_INTAKE.md` input types. | Harness improvement. |
| Lane | Normal+ | `tiny`, `normal`, or `high-risk`. | normal. |
| Story | Normal+ when a story exists | Story id or path. | `US-014`. |
| Agent | Standard+ | Short agent/tool name. | codex. |
| Files read | Standard+ | Paths or command names. | `README.md`, `docs/WORK_INTAKE.md`. |
| Files changed | Standard+ | Paths changed by the task. | `docs/TRACE_SPEC.md`. |
| Actions taken | Standard+ | Short list of important actions. | Added docs, updated router, ran syntax check. |
| Decisions made | Detailed | Scope or design decisions that matter later. | Kept durable state as a future investigation. |
| Validation | Yes before final response when checks exist | Commands, document-review proof, or reason not run. | `bash -n scripts/install-harness.sh`. |
| Outcome | Yes | `completed`, `blocked`, `partial`, or `failed`. | completed. |
| Harness friction | Standard+ when present | Concrete pain or `none` for Detailed traces. | Missing trace spec made final evidence inconsistent. |
| Errors or blockers | Standard+ if present | Concrete error, blocker, or `none` for Detailed traces. | none. |
| Follow-up | Optional | Backlog item, story, or decision needed later. | Investigate optional durable state. |

Durable trace command shape:

```bash
scripts/bin/harness-cli trace \
  --summary "Completed bounded harness task" \
  --story US-015 \
  --agent codex \
  --outcome completed \
  --actions "read,patched,validated" \
  --read "README.md,AGENTS.md,docs/WORK_INTAKE.md" \
  --changed "docs/TRACE_SPEC.md" \
  --friction "none"
```

## Quality Tiers

### Minimal

Use for tiny work with no meaningful coordination or proof risk.

Minimum fields:

- Task summary.
- Lane.
- Files changed, or `none`.
- Validation, or why no validation was available.
- Outcome.

### Standard

Use for normal-lane work, tiny work that changes harness policy, and any task
that discovers friction.

Minimum fields:

- All Minimal fields.
- Input type.
- Story path when one exists.
- Agent.
- Files read.
- Actions taken.
- Harness friction or errors when present.

### Detailed

Use for high-risk work, source-of-truth changes, validation requirement changes,
architecture-shaping work, long-running work, and resumed work.

Minimum fields:

- All Standard fields.
- Decisions made.
- Errors or `none`.
- Harness friction or `none`.
- Follow-up when unfinished work remains.
- Handoff path when another agent may resume the work.

## Lane Mapping

| Lane | Expected Tier | Minimum Behavior |
| --- | --- | --- |
| Tiny | Minimal | Record summary, files changed, validation, and outcome. |
| Normal | Standard | Connect to a story when one exists and name files read, changed, and friction. |
| High-risk | Detailed | Record decisions, blockers, friction, follow-up, and handoff needs. |

## Where To Put Traces

Prefer the smallest durable place that future agents will actually read:

- Tiny: final response plus `docs/TEST_MATRIX.md` only if accepted behavior
  changed.
- Normal: story `Evidence` section, `docs/TEST_MATRIX.md`, and durable trace
  when `scripts/bin/harness-cli` is available.
- High-risk: high-risk story folder, validation report, durable trace, and
  handoff when needed.
- Resumed or transferred work: `docs/handoffs/`.
- Structural harness friction: `docs/HARNESS_BACKLOG.md`.

Do not create a separate trace file for every tiny task unless the task needs
independent review.

Use `scripts/bin/harness-cli query traces`, `query friction`, and
`score-trace` when reviewing accumulated traces.

## Friction Capture

Populate harness friction when any of these occur:

- The agent had to infer a missing rule or source of truth.
- Required validation was unclear, unavailable, or too expensive to run.
- A document, proof row, story packet, or handoff was stale or contradictory.
- The task revealed a repeated manual step that should become a template,
  command, checklist, or future tool.
- A requested change was out of scope but likely important later.
- A review failure could not be attributed to a harness component.

Good friction:

```text
No trace contract existed for normal-lane harness work, so evidence depth varied
between stories and final responses.
```

Weak friction:

```text
docs confusing
```

## Review Checklist

Before the final response:

- The trace tier matches the lane.
- Files read and files changed are accurate enough for a future agent.
- Validation evidence is named honestly.
- Friction is either fixed, added to `docs/HARNESS_BACKLOG.md`, or explicitly
  accepted as none for Detailed traces.
- Unfinished work has a handoff or story status of `paused` or `blocked`.
