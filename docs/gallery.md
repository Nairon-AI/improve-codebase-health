# Example Reports

These examples show output shape, not fixed results.

## Branch Health Audit

```text
Health Score: 74/100
Scope: current branch diff against origin/main
Mode: audit

Dimension Scores:
- Change safety: 70/100
- Agent navigability: 78/100
- Domain clarity / ambiguity: 68/100
- Type safety: 82/100
- Test confidence: 72/100
- Module depth / architecture: 70/100
- Dead code / duplication / slop: 86/100
- Dependency direction: 80/100

Findings:
1. [high] [Tier 3] [Module Depth / Architecture] Checkout orchestration leaks policy
   Symptom:
   Checkout callers must understand payment capture order, inventory reservation, and email timing.
   Source:
   A Philosophy of Software Design by John Ousterhout — shallow modules.
   Refactoring by Martin Fowler — divergent change.
   Consequence:
   Future edits to fulfillment can accidentally change payment behavior.
   Remedy:
   Design a deeper CheckoutFlow interface and move orchestration behind it.
   Verification:
   Shift tests to observable checkout outcomes, then keep payment/inventory/email behind adapters.
```

## Safe Cleanup

```text
Applied:
- Removed unused private helper in packages/api/src/orders/format.ts
- Replaced local `any` with `OrderSummary`
- Deleted obsolete fixture branch no test used

Needs approval:
- Rename exported `status` to `fulfillmentStatus`

Deferred:
- Database table name remains ambiguous; add glossary entry until migration plan exists.
```

## Ambiguity Finding

```text
[medium] [Tier 2] [Domain clarity / ambiguity] `status` mixes payment and fulfillment meaning

Symptom:
Order code reads `status` in payment and fulfillment branches.

Evidence:
payments.ts treats `complete` as captured funds.
fulfillment.ts treats `complete` as shipped package.

Consequence:
An agent could add refund logic to the wrong lifecycle and skip payment reversal.

Remedy:
Rename to `paymentStatus` and `fulfillmentStatus` where contracts allow.
If database migration is risky, document `orders.status` as legacy fulfillment status and add typed aliases at the read boundary.

Verification:
Typecheck, lifecycle tests, migration plan review if DB names change.
```
