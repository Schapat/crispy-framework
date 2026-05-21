# Stories

Stories are local work packets. They turn product intent, maintenance work, and
adoption tasks into bounded implementation and validation work that future
humans and agents can find again.

Use repository story packets as the durable local story system, even if work is
also discussed in external tools. External tickets can link back here, but the
accepted scope, proof expectations, and evidence should not live only in a
place agents may not find later.

The repository story packet is the canonical work record. Jira, Linear, GitHub
Issues, or other external tools may be linked from the story when they exist,
but they should not be the only place accepted scope, validation expectations,
decisions, or evidence live.

Story packets may be active when they are `in_progress`, `paused`, or `blocked`.
Stories may also declare `Execution Mode: AFK` when agents can proceed after
intake, or `Execution Mode: HITL` when human review, decisions, credentials, or
external access are expected before completion.

## Normal Story

Use `docs/templates/story.md` for normal feature, maintenance, adoption, or
governance work.

Suggested path:

```text
docs/stories/epics/E01-domain-name/ST-001-short-story-title.md
```

## High-Risk Story

Use `docs/templates/high-risk-story/` when the work intake classifies work as
high-risk.

Suggested path:

```text
docs/stories/epics/E02-risky-domain/ST-012-risky-story-title/
  execplan.md
  overview.md
  design.md
  validation.md
```

## Existing Project Adoption

When adopting Crisp Harness into an existing project, create or update
`docs/stories/backlog.md` and create an adoption story packet. The adoption
story should cover local truth inventory, harness adaptation, validation
mapping, and naming the first real product, maintenance, or harness-adaptation
story. Do not retroactively write a story for every historical feature unless
the human explicitly asks for that cleanup.

## Status Flow

```text
planned -> in_progress -> implemented -> changed -> retired
              |
              v
           paused
              |
              v
           in_progress

in_progress -> blocked -> in_progress
```

Use `paused` when work started but stopped with a handoff. Use `blocked` when
work cannot continue until missing input, a decision, or an external condition
is resolved.

## Readiness

Use `ready-for-agent` when scope, affected files, validation expectations, and
stop conditions are clear. Use `ready-for-human` when the next useful action is
a human decision, review, or external access step.
