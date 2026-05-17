# Harness Backlog

Use this file when an agent discovers a missing harness capability but should
not change the operating model immediately.

## Template

```md
## Missing Harness Capability

### Title

Short name.

### Discovered While

Task or story that exposed the gap.

### Current Pain

What was hard, repeated, ambiguous, or unsafe?

### Suggested Improvement

What should be added or changed?

### Risk

Tiny, normal, or high-risk.

### Status

proposed | accepted | implemented | rejected
```

## Items

## Missing Harness Capability

### Title

Governance intake TUI.

### Discovered While

Project governance and continuity refinement.

### Current Pain

The harness can describe project-start questions and generated artifacts, but a
human still has to fill the markdown files manually.

### Suggested Improvement

Add a future `scripts/governance-intake` or `scripts/start-project` TUI that
collects project-start answers, previews the artifact plan, and writes markdown
files from existing templates without scaffolding application code.

### Risk

normal

### Status

implemented

## Missing Harness Capability

### Title

Multi-agent orchestration runner.

### Discovered While

US-002 Agent Evaluation Contracts.

### Current Pain

The harness now defines builder, evaluator, and handoff contracts, but it does
not automate planner/generator/evaluator orchestration.

### Suggested Improvement

After a real project or repeated harness work proves the need, add a story for
an orchestration command or workflow that can run separate builder and
evaluator passes and write handoff/evaluation artifacts.

### Risk

normal

### Status

proposed

## Missing Harness Capability

### Title

Target-safe glossary split.

### Discovered While

Architecture grilling with `grill-with-docs`.

### Current Pain

`docs/GLOSSARY.md` is useful for target projects, but it currently mixes
target-safe collaboration terms with source-repository terms such as temporary
source traceability and remote installer details.

### Suggested Improvement

Before a public release, split source-only glossary terms from target-safe
glossary terms, or add a target-safe glossary seed for installer output.

### Risk

tiny

### Status

proposed

## Missing Harness Capability

### Title

Remote installer publication hardening.

### Discovered While

Architecture grilling with `grill-with-docs`.

### Current Pain

The installer is intended to be a remote installer, but the repository has not
been initially committed to GitHub yet. A provisional raw GitHub URL exists in
the script, but publication guidance, release expectations, and remote-install
validation should wait until the repository has a real remote source.

### Suggested Improvement

After the initial GitHub commit, review and harden the remote installer path,
including the documented raw source URL, simple `curl | bash` flow, dry-run
validation, conflict behavior, and the expected way humans inspect the script
before running it.

### Risk

normal

### Status

proposed
