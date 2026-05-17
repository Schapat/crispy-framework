# Glossary

## Accepted Behavior

Behavior that repository artifacts define as expected. It may come from product
docs, story packets, decisions, or validation contracts.

## Agent

An AI coding collaborator operating inside the repository.

## Agent-Facing Target Payload

The installed harness surface intended for target projects: `AGENTS.md`, docs,
templates, and traceability files that an AI agent can use directly. It excludes
source-repository helper scripts unless a later target-safe command story proves
they are needed.

## Continuity

The ability to pause and resume work from repository artifacts instead of
conversation memory.

## Cautious Merge

An installer mode for existing projects that copies missing harness files while
leaving existing `AGENTS.md` and `docs/` content untouched. A cautious merge is
a bootstrap step, not automatic reconciliation; a human should review conflicts
and ask an agent to adapt the harness manually when project instructions already
exist.

## Create-Missing Install

The installer behavior for target projects: create harness files that do not
exist and skip files that already exist. The installer does not overwrite, move,
or back up target project files.

## Canonical Default

The reusable starting operating model that Crisp Harness installs into target
projects. It should be strong enough for agents to follow immediately, but it is
not sacred text; target projects are expected to adapt it once their product,
stack, risks, proof commands, and team habits are known.

## Crisp

The staged context and mission workflow used by this harness: intent becomes
questions, research, design, structure, validation, mission work, handoff, and
review.

## Discovery

A role or phase that gathers objective facts and unknowns without implementation
opinions.

## Evaluator

A skeptical reviewer posture or role that judges whether completed work matches
the accepted contract and whether proof is honest.

## Existing Project

A target project that already has code, docs, tests, scripts, validation
commands, team conventions, or product truth before Crisp Harness is
incorporated. Existing projects are first-class targets and require cautious
merge plus local adaptation.

## Evidence

The concrete artifact, command output, review note, or file link that supports a
proof claim.

## Governance

The rules, artifacts, and review habits that keep humans and agents aligned on
truth, risk, proof, continuity, and authority before code changes.

## Handoff

A durable note that lets another human or agent resume work without relying on
chat history alone.

## Harness

The repo-level operating system that tells humans and agents how to turn intent
into safe product changes.

## Harness Source Repository

The reusable framework repository that contains the Crisp Harness operating
model, installer, templates, source history, proof rows, backlog items, and
decision records. Its history explains this harness's evolution and should not
be copied wholesale into a target project.

## Harness Delta

A documentation, template, validation, backlog, or decision update that makes
future agent work safer or easier.

## Input Material

User prompts, supplied specs, attached files, or intake output used to derive
living product truth.

## Local Adaptation

The target project's deliberate modification of the canonical default harness to
match its own product, stack, validation commands, risk boundaries, and team
workflow.

## Intake Snapshot

An immutable-ish record under `docs/intake/` that preserves input material as it
was supplied at a point in time.

## Initiative

A larger product or harness effort that may contain multiple story packets and
needs scoped notes before slicing.

## Mission

A coordinated Crisp work unit with role boundaries, validation expectations,
serial write ownership, and handoff or validator checkpoints.

## One-Time Framework Copy

The current installation model for Crisp Harness. A target project receives a
copy of reusable harness files and then owns its local harness evolution. The
harness source repository does not remain an upstream dependency for installed
target projects.

## Orchestrator

The role that aligns scope, stages context artifacts, defines validation, and
assigns worker or validator slices.

## Product Contract

The current expected behavior of the product. Product docs plus executable tests
become the living contract once implementation exists.

## Project Adoption

The process of incorporating Crisp Harness into an existing project by
discovering local truth, preserving existing code and conventions, adapting
agent guidance, mapping validation commands, and naming the first safe governed
work.

## Product Delta

A product-facing change such as code, tests, API shape, data model, or product
documentation.

## Product Truth

The current accepted product understanding in living repository artifacts, not
raw chat history or old input snapshots.

## Remote Installer

The intended distribution shape for the source repository's installer after
this framework is published. The installer should support applying Crisp Harness
from a remote source into a target project, while still preserving the one-time
framework copy model.

## Proof

The validation method that makes a completion claim honest, such as a passing
command, document review, screenshot, or explicit evaluator note.

## Source Of Truth

The artifact or artifact set that currently has authority for a claim. In this
harness, living product truth belongs in product docs, stories, tests, matrix
rows, and decisions rather than in chat alone.

## Specific Question Rule

When a core file, product rule, validation command, or local convention is
missing or unclear, an agent asks the human a specific question instead of
guessing and records durable answers in repository artifacts when future agents
need them.

## Spec Intake

The process of turning a user-provided project specification into intake
snapshots, product docs, candidate stories, decisions, and proof expectations.

## Story Packet

A story-sized work file or folder that describes the product contract, affected
docs, design notes, and validation expectations for a feature.

## Canonical Work Record

The repository story packet that holds accepted scope, validation expectations,
decisions, and evidence for a unit of work. External tools such as Jira, Linear,
or GitHub Issues may be linked from the story, but they should not be the only
source of truth for agent work.

## Temporary Source Traceability

Story packets and filled test matrix rows kept in the harness source repository
to track framework development during the initial phase. Temporary source
traceability is not target payload and may be pruned after its useful rationale
is captured in durable docs or decisions.

## Target Project

A new or existing project that receives the reusable harness files so humans and
agents can collaborate with clearer intake, proof, continuity, and decision
records. Target projects start their own local product truth, test matrix,
backlog, and decisions.

## Stub-Only Proof

A surface that exists without proving accepted behavior. Stub-only work may be
planned or in progress, but should not be marked implemented.

## Validation Contract

Pre-implementation correctness criteria that define positive assertions,
negative assertions, proof methods, and go/no-go rules.

## Validator

The role that checks completed work against the validation contract, story,
handoff, evidence, and relevant product truth.

## Work Intake

The classification step that turns a prompt into tiny, normal, or high-risk
work before implementation begins.

## Worker

The role that edits one assigned vertical slice, records evidence, and leaves a
handoff when another context may need to continue or validate the work.
