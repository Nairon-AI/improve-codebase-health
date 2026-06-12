# Safety Tiers

Every finding must include an edit-authority tier.

## Tier 0: Report Only

Use when the finding is useful context but no edit should happen in this pass.

Examples:

- broad architecture concern outside scope
- unclear code ownership
- low-confidence smell
- needs product/domain answer

## Tier 1: Auto-Safe

Agent may edit in `safe-cleanup` or `friday-steward`.

All rules must pass:

- local blast radius
- no public/exported contract change
- no runtime behavior change except removing unreachable/dead behavior
- typecheck proves callers still valid
- tests exist or narrow verification possible
- patch is easy to review

Allowed examples:

- remove unused private code
- inline pointless private wrapper
- rename local/private ambiguous symbol
- tighten `any` to a known local type
- remove duplicate helper inside one module
- delete obsolete test setup
- simplify branch with identical outputs

## Tier 2: Ask First

Agent may propose a patch plan, but must wait for approval before editing.

Examples:

- exported rename
- file moves
- merging duplicate modules
- replacing test strategy
- changing config surface
- deleting code only believed unused by convention

## Tier 3: Design Required

Requires grilling, design doc, or ADR before implementation.

Examples:

- new interface or seam
- dependency inversion across packages
- public API shape
- persistence model
- auth/data/payment boundaries
- cross-service contracts
- database table/column rename
- domain model shift

## Escalation Rule

If unsure between two tiers, choose the higher-risk tier.

Tier 1 is intentionally boring. The weekly habit should create trust.
