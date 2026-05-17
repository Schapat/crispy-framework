# Stories

Stories are work packets. They turn product intent into bounded implementation
and validation work.

In this source repository, story packets are temporary framework-development
history while Crisp Harness is still taking shape. They help track acceptance
criteria and proof during the initial phase, but they are not part of the target
install payload and may be pruned in future commits once durable rationale has
landed in docs and decisions.

Target projects receive a target-safe stories README from
`docs/templates/seed/stories-README.md`, where stories are the durable local
story system and canonical work record for future work. They also receive a
target-safe story backlog seed from `docs/templates/seed/stories-backlog.md`.

Story packets may be active when they are `in_progress`, `paused`, or `blocked`.

## Normal Story

Use `docs/templates/story.md` for normal feature work.

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
