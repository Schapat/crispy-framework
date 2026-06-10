# Harness

The project goal is to provide a reusable governance harness that lets humans
and agents turn a future product spec into safe, validated work.

The app is what users touch. The harness is what agents touch.

Crisp Harness can be incorporated into new projects or existing projects with
code, docs, tests, scripts, and local conventions. Existing projects are
first-class target projects; agents should discover and adapt to local truth
rather than assuming a blank slate.

Crisp Harness adds staged context artifacts and mission-style role boundaries so
work can move through objective research, human alignment, vertical slices,
structured handoffs, and independent validation without depending on chat
memory.

## Mental Model

```text
------------------+
| Human intent    |
+------------------+
         |
         v
+------------------+
| Work intake      |
+------------------+
         |
         v
+------------------+
| Context artifacts |
+------------------+
         |
         v
+------------------+
| Story or mission |
+------------------+
         |
         v
+------------------+
| Product delta    |
+------------------+
         |
         v
+------------------+
| Validation proof |
+------------------+
         |
         v
+------------------+
| Harness delta    |
+------------------+
         |
         v
+------------------+
| Next intent      |
+------------------+
```

Every task has two possible outputs:

1. Product delta: app code, tests, API shape, data model, or product docs.
2. Harness delta: docs, templates, validation expectations, backlog items, or
   decision records that make the next task easier.

## Harness v0 Scope

Crisp Harness v0 includes:

- Agent entrypoint.
- General project governance rules.
- Project-start guidance.
- Existing-project adoption guidance.
- First-adoption status marker and low-context adoption playbook.
- Local agent configuration docs for tracker, work-state, and domain-language
  conventions.
- Empty product documentation structure.
- Intake snapshot structure for supplied specs, prompts, governance intake, and
  future TUI output.
- Work intake and risk lanes.
- Context retrieval rules by phase and risk lane.
- Trace evidence fields and quality tiers.
- Harness component taxonomy for failure attribution and friction routing.
- Harness maturity ladder for measurable improvement.
- Staged context templates for questions, research, design, structure, validation,
  and mission planning.
- Agent role guidance for orchestrator, discovery, worker, and validator work.
- Continuity and agent onboarding guidance.
- Evaluation guidance for long-running or multi-agent work.
- Story templates.
- Prototype template for temporary one-question spikes.
- Handoff template.
- Decision log template.
- Validation report template.
- Test matrix placeholder.
- Harness growth backlog.
- Repository-local Rust CLI for durable harness records.
- SQLite schema migrations for intake, stories, decisions, backlog, traces,
  tool registry, and interventions.

The installed harness is a canonical default. It should give target projects a
strong starting operating model, then be adapted locally as the target project's
product, stack, validation commands, risk boundaries, and team workflow become
known.

Target installs receive a target-safe `AGENTS.md` seed. The source repository's
own `AGENTS.md` remains specific to maintaining this framework repository.
Target installs also receive a target-safe `README.md` seed. The source
repository's own README remains specific to explaining Crisp Harness as a
framework repository.

Harness v0 deliberately excludes:

- A project-specific `SPEC.md`.
- Pre-sliced product domains.
- A locked application stack.
- App source scaffolding.
- Package scripts.
- Test runner config.
- CI workflows.
- Mission runner or router automation.

Those should arrive only when a selected story needs them.

## Observable Operations

Crisp Harness keeps policy in markdown and operational state in a local durable
layer. Normal and high-risk work should leave structured evidence in both the
story-oriented docs and, when available, the CLI records.

- Use `docs/CONTEXT_RULES.md` when a task needs more precise read-scope guidance
  than `AGENTS.md` provides.
- Use `docs/TRACE_SPEC.md` to decide how much trace evidence to leave.
- Use `docs/HARNESS_COMPONENTS.md` to attribute repeated friction to a harness
  responsibility.
- Use `docs/HARNESS_MATURITY.md` when making maturity or process-improvement
  claims.
- Use `scripts/bin/harness-cli query matrix` for the durable story proof view.
- Use `scripts/bin/harness-cli query backlog`, `query decisions`, `query
  traces`, and `query friction` when the task needs queryable operational
  history.
- Use `scripts/bin/harness-cli audit` and `propose` when drift or repeated
  friction should be turned into follow-up work.

The generated `harness.db` is local operational data and is ignored by git.
Markdown docs, stories, decisions, and the test matrix remain the reviewable
contract that agents update when accepted behavior changes.

## Crisp Context Pipeline

Use the full pipeline when work is high-risk, long-running, multi-agent, or
resumed from a handoff. For normal work, use the pipeline when uncertainty,
contract changes, proof expectations, or coordination needs justify it. Tiny
documentation changes can use the lighter intake loop.

```text
human intent
  -> context questions
  -> objective research facts
  -> design concept
  -> structure outline
  -> validation contract
  -> mission plan
  -> worker slice
  -> handoff
  -> validator pass
```

The shorter alignment artifacts are the primary human review surface before
implementation. Tactical plans are worker guidance, not a replacement for human
design review or final code ownership.

## Mission Roles

`AGENTS.md` remains the entrypoint. `docs/AGENT_ROLES.md` explains how to split
work when separate context windows or separate agents are useful:

- Orchestrator: scope, questions, design, structure, validation contract, and
  mission plan.
- Discovery: objective facts without implementation opinions.
- Worker: one vertical slice with clean context and a structured handoff.
- Validator: independent scrutiny and behavior validation against the contract.

Run only one file-writing worker or validator at a time. Parallelize read-only
research, search, and review when the questions are independent.

## Source Hierarchy

```text
User-provided spec or prompt
  input material for first buildout or future changes

docs/intake/*
  immutable-ish snapshots of supplied specs, prompts, governance intake, or TUI output

docs/product/*
  current product contract derived from accepted input

docs/ADOPTION_STATUS.md and docs/FIRST_ADOPTION.md
  first-run adoption marker and low-context adoption route

docs/stories/*
  story-sized work packets and historical evidence

docs/agents/*
  local agent configuration for issue tracker, readiness states, and domain docs

docs/TEST_MATRIX.md
  behavior-to-proof control panel

docs/decisions/*
  why the contract changed
```

Before implementation, product docs describe intent. After implementation,
product docs plus executable tests become the living contract.

## Spec Lifecycle

Harness v0 starts without a tracked project spec. When the human provides a
specification, treat it as input material, not as a permanent operating manual.
Store or reference the original input in `docs/intake/` when it needs to remain
available, then use it to populate product docs, story packets, architecture
decisions, and validation expectations during the first buildout.

After the specification has been decomposed, do not keep extending it as the
living product plan. Ongoing work should update the smaller product docs,
stories, test matrix, and decision records.

Ongoing work should enter the harness as one of these input types:

- New spec: a project specification that needs to become product docs and
  initial story candidates.
- Spec slice: a selected behavior from the provided spec.
- Change request: a bounded behavior change, bug fix, or product refinement.
- New initiative: a larger product area that needs multiple stories.
- Maintenance request: dependency, architecture, performance, security, or
  operational work.
- Harness improvement: a process, template, proof, or agent-instruction change.

The spec-to-work loop is:

```text
human intent or supplied spec
  -> classify input type
  -> check active handoffs or paused work
  -> snapshot input material when it should remain traceable
  -> update or create product contract
  -> create story packet or initiative notes when needed
  -> define validation proof
  -> implement or document the blocker
  -> update product docs, stories, test matrix, and decisions
  -> capture trace evidence and harness friction
```

## Evaluation Loop

Long-running work needs a builder posture and an evaluator posture.

The builder creates the product or harness delta. The evaluator judges whether
the result satisfies the accepted contract, whether proof is honest, and whether
any visible surface is only stubbed or cosmetically complete.

Use `docs/EVALUATION.md` when a task is normal lane, high-risk lane,
long-running, multi-agent, or dependent on document review instead of executable
tests. Story packets should define evaluator acceptance criteria before work
begins when evaluation is required.

Use `docs/templates/handoff.md` when work may continue in another session or
needs a clear reviewer handoff.

## Continuity Loop

Unfinished work must leave a durable resume point in the repository.

Use `docs/CONTINUITY.md` for pause and resume rules. Use `docs/handoffs/` for
handoff files. Use `docs/AGENT_ONBOARDING.md` when a new agent joins the
project or continues old work.

Before starting new work, agents should check for active handoffs and paused or
blocked stories unless the human explicitly asks to ignore previous work.

Large product areas should use scoped initiative notes instead of a second
monolithic specification. An initiative should explain the goal, affected
product docs, candidate stories, validation shape, open decisions, and exit
criteria. If initiative work becomes a repeated pattern, add a template or
proposal to `docs/HARNESS_BACKLOG.md`.

## Growth Rule

The harness grows from friction.

When an agent is confused, repeats manual reasoning, needs a new validation
command, discovers a missing rule, or sees a recurring failure pattern, it must
either improve the harness directly or add a proposal to `HARNESS_BACKLOG.md`.
For normal and high-risk work, also record the friction in the trace evidence
expected by `docs/TRACE_SPEC.md`.

Every harness component is a hypothesis about what agents need help
remembering, proving, or coordinating. Add process when it removes real failure
or repeated friction; simplify it later if it stops carrying its weight.

## Future Validation Ladder

No validation scripts exist yet. When implementation begins, the expected ladder
is:

```text
validate:quick
  format, lint, typecheck, unit tests, architecture check

test:integration
  backend, database, provider, or service checks as the stack requires

test:e2e
  user-visible end-to-end flows

test:platform
  shell, mobile, desktop, or deployment smoke checks as the stack requires

test:release
  full suite, log checks, and performance smoke
```

Agents must not claim these commands pass until they exist and have been run.
