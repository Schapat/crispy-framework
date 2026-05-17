# crisp-harness

Crisp Harness v0 for AI-agent project governance.

This is not an app template. It is a repository-level governance harness for
turning human intent or a product spec into agent-ready work: project context,
product contracts, story packets, validation expectations, continuity notes,
architecture decisions, and eventually implementation.

Crisp Harness is meant for both new projects and existing projects with code,
docs, tests, scripts, and local conventions. Existing-project installs are
first-class and should be handled through cautious merge plus local adaptation.

The app is what users touch. The harness is what agents touch. Crisp Harness
adds a staged context and mission workflow so agents can work from smaller
reviewable artifacts instead of one large prompt, chat thread, or implementation
plan.

## Why This Exists

Coding agents are becoming useful enough to participate in real software work,
but the model alone is not the whole system. A repository also needs clear
instructions, shared product truth, validation loops, internal tools, and
decision records so an agent can understand what matters before it changes
code.

Harness Engineering is the practice of designing that operating environment.
The goal is not simply to make AI write code faster. The goal is to make
AI-assisted software development more reliable, inspectable, and easier for
humans to steer.

OpenAI describes this shift as an agent-first world where humans steer and
agents execute:

https://openai.com/index/harness-engineering/

## Current State

This repository is in Crisp Harness v0.

There is no application implementation and no baked-in product specification
yet. The current work is the reusable project harness: the file structure,
agent operating model, work intake process, story templates, and validation
expectations that help humans and agents turn a future user-provided spec into
implementation work.

## What Counts As A Harness

A repository starts to have a harness when it helps an agent answer practical
engineering questions without relying only on chat history:

- What should I read first?
- What type of work is this?
- Which product contract does it affect?
- How risky is the change?
- What proof will show the work is done?
- What decision or lesson should future agents inherit?

In this repo, those answers live in `AGENTS.md`, `docs/HARNESS.md`,
`docs/PROJECT_GOVERNANCE.md`, `docs/PROJECT_START.md`,
`docs/WORK_INTAKE.md`, `docs/CONTINUITY.md`,
`docs/AGENT_ONBOARDING.md`, `docs/ARCHITECTURE.md`,
`docs/EVALUATION.md`, `docs/TEST_MATRIX.md`, `docs/stories/`,
`docs/intake/`, `docs/handoffs/`, `docs/AGENT_ROLES.md`,
`docs/decisions/`, and `docs/templates/`.

## Crisp Workflow

Crisp Harness combines staged context engineering with mission-style
multi-agent work:

```text
intent
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

Humans stay in the loop as project managers and code owners. They argue with
the orchestrator about scope, review the short design and structure artifacts,
approve validation expectations, and still own the final code. The harness
exists to make that review smaller, earlier, and more honest.

## Product Sources

No product contract is currently defined.

When a user provides a project specification, add or reference it as the input
spec for the first buildout, then derive smaller living artifacts from it:

- `docs/product/`: current product contract files, created from the spec.
- `docs/intake/`: input snapshots of supplied specs, prompts, or intake output;
  these are source material, not living product truth.
- `docs/stories/`: story packets and backlog created from selected work.
- `docs/TEST_MATRIX.md`: behavior-to-proof control panel.
- `docs/decisions/`: durable decisions and tradeoffs created by the target
  project.

Do not keep a project-specific spec or product breakdown in this harness until
a real project supplies one.

## Harness Sources

- `AGENTS.md`: agent entrypoint and operating rules.
- `docs/HARNESS.md`: central governance model.
- `docs/PROJECT_GOVERNANCE.md`: general governance rules before coding.
- `docs/PROJECT_START.md`: project-start intake flow.
- `docs/PROJECT_ADOPTION.md`: existing-project adoption flow.
- `docs/WORK_INTAKE.md`: tiny, normal, and high-risk work classification.
- `docs/CONTINUITY.md`: pause, resume, and handoff rules.
- `docs/AGENT_ONBOARDING.md`: how a new AI agent joins or resumes work.
- `docs/AGENT_ROLES.md`: orchestrator, discovery, worker, and validator role
  guidance.
- `docs/ARCHITECTURE.md`: generic architecture discovery and boundary rules.
- `docs/EVALUATION.md`: evaluator contract, failure thresholds, and stub
  detection.
- `docs/HARNESS_BACKLOG.md`: proposed harness improvements.
- `docs/intake/`: input snapshots from specs, prompts, governance intake, or
  future TUI output.
- `docs/templates/`: reusable spec-intake, story, context, mission, handoff,
  decision, and validation templates.

## Repository Structure

```text
project/
  AGENTS.md
  README.md
  docs/
    HARNESS.md
    PROJECT_GOVERNANCE.md
    PROJECT_START.md
    PROJECT_ADOPTION.md
    WORK_INTAKE.md
    CONTINUITY.md
    AGENT_ONBOARDING.md
    ARCHITECTURE.md
    EVALUATION.md
    TEST_MATRIX.md
    HARNESS_BACKLOG.md
    AGENT_ROLES.md
    product/
    intake/
    stories/
    handoffs/
    decisions/
    templates/
  scripts/
    README.md
```

## Working Rule

Implementation prompts do not go straight to code. They first pass through
work intake, become story-sized work when needed, and then carry both
product validation and harness maintenance expectations.

## Install Harness Into A Project

After publishing this repository, run the installer from the target project
directory:

```bash
curl -fsSL https://raw.githubusercontent.com/vietdzungdang/agent-harness/main/scripts/install-harness.sh | bash
```

During local development, run:

```bash
scripts/install-harness.sh
```

Installation is a one-time framework copy. After install, the target project
owns its local harness files, decisions, test matrix, backlog, and adaptations.
This source repository does not act as an ongoing upstream dependency for target
projects.

The installed harness is a canonical default, not sacred text. Target projects
should adapt it once their product, stack, proof commands, risk boundaries, and
team habits are known.

If the target already has `AGENTS.md`, `docs/`, or any harness file, the
installer keeps existing files and creates only missing files:

```bash
scripts/install-harness.sh --merge
```

Or preview the install:

```bash
scripts/install-harness.sh --directory /path/to/project --dry-run
```

Existing files are never overwritten by the installer. Use `--dry-run` to
preview changes. The installer itself and this repository's helper scripts and
installer story are not copied into the target project. Target installs receive
blank seed `docs/TEST_MATRIX.md` and `docs/HARNESS_BACKLOG.md` files rather than
this source repository's historical traceability rows.

The installer script is kept as a local reference utility. If you later publish
this project from a different repository path, update the installer default raw
source URL or set `HARNESS_SOURCE_BASE_URL` explicitly during remote install.
