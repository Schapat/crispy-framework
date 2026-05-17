# Agent Roles

Use this only when separate context windows or multiple agents help the task.
Tiny work can stay in one session.

`AGENTS.md` remains the entrypoint.

## Shared Rules

- Prefer static artifacts over chat memory.
- Define correctness before implementation when the lane requires it.
- Run only one file-writing worker or validator at a time.
- Parallelize read-only research or review only when questions are independent.
- Pick models by capability, not vendor: reasoning for orchestration, objective
  search for discovery, code fluency for workers, skepticism for validators.

## Roles

| Role | Job | Writes |
| --- | --- | --- |
| Orchestrator | Classify lane, align scope, create questions, design, structure, validation contract, and mission plan. | Governance artifacts |
| Discovery | Answer focused research questions with facts and evidence, without implementation opinions. | Research artifacts |
| Worker | Execute one assigned vertical slice with clean context and leave a handoff. | Assigned slice |
| Validator | Judge against the validation contract, story, handoff, diff, and evidence. | Validation notes or handoff updates |

## Boundaries

- Orchestrators must not hide unresolved decisions inside worker tasks.
- Discovery agents must not choose implementation architecture.
- Workers must not widen scope or mark work complete without evidence.
- Validators must not rely on worker confidence or post-hoc tests alone.
