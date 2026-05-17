# Test Matrix

This file maps accepted product or governance behavior to proof.

No product behavior has been defined or implemented yet. Add rows when product
docs, story packets, or governance intake artifacts define accepted behavior.

## Status Values

| Status | Meaning |
| --- | --- |
| planned | Accepted as intended behavior, not implemented |
| in_progress | Actively being built |
| implemented | Implemented and proof exists |
| changed | Contract changed after earlier implementation |
| retired | No longer part of the product contract |

## Matrix

| Story | Contract | Unit | Integration | E2E | Platform | Status | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| TBD | Add rows when story packets are created | no | no | no | no | planned | none |

## Evidence Rules

- Unit proof covers pure domain and application rules.
- Integration proof covers backend enforcement, data integrity, provider
  behavior, jobs, or service contracts.
- E2E proof covers user-visible browser flows.
- Platform proof covers shell, deployment, mobile, desktop, or runtime behavior
  that cannot be proven in lower layers.
- A story can be implemented without every proof column if the story packet
  explains why.
- Stub-only or surface-only work is not implemented proof. If behavior is only
  named, mocked, hard-coded, or cosmetically present, keep the row `planned` or
  `in_progress` and document the missing proof.
