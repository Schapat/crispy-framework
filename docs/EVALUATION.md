# Evaluation

This document defines how the harness separates building from judging.

The goal is not to add ceremony. The goal is to make completion claims harder
to fake, especially in long-running or multi-agent work where a feature can look
finished while important behavior is still stubbed, shallow, or unproven.

## When Evaluation Is Required

Use an explicit evaluator pass when work is:

- normal lane and changes reusable harness contracts, product behavior, or proof
  expectations
- high-risk lane
- long-running enough that another session may need to continue it
- likely to produce impressive-looking but incomplete output
- missing executable tests and relying on document review
- multi-agent or mission-style work where a worker hands off to a validator

Tiny wording edits do not need a separate evaluator unless the edit changes
operating meaning.

## Evaluator Role

The evaluator is a skeptical reviewer. It should judge the result against the
story packet, product docs, and test matrix rather than against the builder's
confidence.

The evaluator should answer:

1. Did the work satisfy the accepted contract?
2. Is the proof level honest for the current repository state?
3. Are any surfaces only stubbed or cosmetically complete?
4. Are product docs, story packet, matrix row, decisions, and validation notes
   still linked?
5. Should the work be accepted, revised, or sent back to intake?

The builder and evaluator may be the same human or agent in small tasks, but the
evaluation section should still be written from the skeptical reviewer posture.

## Evaluation Contract

Before implementation or documentation changes begin, normal and high-risk
stories should define:

- evaluator acceptance criteria
- failure thresholds
- expected proof level
- artifacts the evaluator must inspect
- whether document review is enough for the current repo state
- validation contract assertions when correctness needs to be independent of the
  worker's implementation choices

If those criteria cannot be written yet, the story is not ready for execution.

## Validation Contracts

Use `docs/templates/validation-contract.md` when work is normal, high-risk,
long-running, multi-agent, or likely to rely on tests written after
implementation.

The validation contract defines what done means before code is written. It
should include positive assertions, negative assertions, proof methods, and
go/no-go rules. Workers may use it to guide implementation, but validators use
it to judge the result independently.

For mission-style work, validators should read the validation contract, story,
handoff, diff, and relevant matrix rows. They should not rely on the worker's
confidence or on tests that merely confirm the code the worker happened to
write.

## Failure Thresholds

Mark work as not ready when any of these are true:

- accepted behavior exists only in chat and was not moved into repository
  artifacts
- proof claims are stronger than the commands or review actually performed
- UI, API, script, or documentation surfaces exist but core behavior is still a
  stub
- story evidence cannot be traced to a matrix row or validation note
- a high-risk packet lacks rollback, go/no-go, or revalidation thinking
- the change leaves future agents with contradictory source-of-truth cues

## Stub Detection

A visible surface is not proof by itself.

Examples of incomplete proof:

- a button exists but does not trigger accepted behavior
- an API route exists but returns fixed sample data
- an installer prints planned operations but does not prove file effects
- a document names a process but no story, matrix, or validation surface can
  show when that process applies

Stub-only or surface-only work may be marked `planned` or `in_progress`, but it
must not be marked `implemented`.

## Evaluation Outcomes

Use these outcomes in story evidence, validation reports, or handoffs:

- `accepted`: contract is satisfied and proof is honest
- `accepted_with_gaps`: usable, but gaps are named and linked to follow-up
- `revise`: close, but must be corrected before completion
- `blocked`: cannot be judged honestly until missing truth, proof, or decision
  exists

## Harness Complexity Rule

Every harness component is a hypothesis about what agents need help remembering,
proving, or coordinating.

Add new harness process only when it removes real failure or repeated friction.
If a rule, template field, or handoff step stops carrying its weight, simplify
or remove it through the normal decision and backlog flow.
