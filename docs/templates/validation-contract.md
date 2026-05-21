# Validation Contract

Define correctness before implementation.

## Scope

- Story or packet:
- Contract:
- Structure outline:

## Assertions

| ID | Assertion | Proof method | Slice |
| --- | --- | --- | --- |
| VC-001 | | document \| unit \| integration \| E2E \| platform | |

## Test Quality

- Prefer proof through public interfaces, user-visible behavior, API contracts,
  command behavior, or durable module boundaries.
- Avoid tests that only prove private implementation details unless the private
  boundary is the accepted contract for this slice.
- Tests should survive reasonable refactors. If a test would fail because an
  internal helper was renamed without changing behavior, move the proof to a
  higher-value boundary.
- Negative assertions should prove forbidden outcomes, not only happy-path
  presence.

## Negative Assertions

| ID | Forbidden outcome | Check |
| --- | --- | --- |
| NVC-001 | | |

## Validators

| Validator | Scope | Inputs |
| --- | --- | --- |
| scrutiny | static review, commands, tests, traceability | contract, story, handoff, diff |
| user-testing | user-visible or workflow behavior | contract, running app when one exists |

## Go / No-Go

- Go:
- No-go:

## Evidence

- Commands:
- Documents:
- Screenshots or logs:
