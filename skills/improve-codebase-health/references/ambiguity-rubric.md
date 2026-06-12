# Ambiguity Rubric

Ambiguity means a future human or coding agent could make a plausible wrong edit because code or docs allow multiple meanings.

Do not flag taste preferences. A shorter or prettier name is not enough.

## Required Evidence

An ambiguity finding must include:

1. Ambiguous symbol/concept.
2. Competing interpretations.
3. Evidence each interpretation is plausible.
4. Likely wrong edit an agent/dev might make.
5. Best fix.
6. Safe fallback if direct fix is risky.
7. Documentation home.

## Common Ambiguity Sources

- overloaded names: `status`, `type`, `data`, `config`, `user`
- domain names reused for infrastructure concepts
- database table names that no longer match product meaning
- flags that combine multiple decisions
- helpers named by mechanics instead of intent
- duplicate concepts with different names
- same name meaning different things in frontend/backend/admin/jobs

## Good Finding Example

```text
[medium] [Tier 2] [Domain clarity / ambiguity] `status` mixes payment and fulfillment meaning

Symptom:
Order code reads `status` in payment and fulfillment branches.

Evidence:
`payments.ts` treats `status=complete` as captured funds.
`fulfillment.ts` treats `status=complete` as shipped package.

Consequence:
An agent could add a refund rule to fulfillment status and skip payment reversal.

Remedy:
Rename to `paymentStatus` and `fulfillmentStatus` where exported contracts allow.
If database migration is too risky now, document `orders.status` as legacy fulfillment status and add typed aliases at the read boundary.

Verification:
Typecheck, order lifecycle tests, migration plan review if DB names change.
```

## Safe Fallbacks

Use when rename/migration is not safe in the current pass:

- add or update `CONTEXT.md` glossary
- add ADR for intentionally retained bad name
- add a short comment at the confusing seam
- add type alias or value object at boundary
- create migration plan without running migration

## Non-Findings

Do not report:

- a name that is merely not your preferred style
- domain jargon already documented and consistently used
- short local variables with tiny scope
- old database names when docs and boundary types already remove confusion
