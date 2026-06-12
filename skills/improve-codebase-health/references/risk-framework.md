# Risk Framework

Use this framework for every audit, cleanup, and Friday steward pass.

## Dimensions

### Change Safety

Question: can a focused change be made without surprising unrelated behavior?

Signals:

- one edit requires many scattered edits
- hidden coupling across modules
- side effects mixed with domain logic
- unclear ownership

### Agent Navigability

Question: can a coding agent find the right files, concepts, and verification path quickly?

Signals:

- important flows lack obvious entry points
- same concept has multiple names
- docs disagree with code
- tests do not reveal intended behavior

### Domain Clarity / Ambiguity

Question: do names and models make the domain harder to understand or easier to edit wrong?

Use `ambiguity-rubric.md` for evidence requirements.

### Type Safety

Question: do types encode important invariants, or do callers rely on discipline?

Signals:

- `any`, weak records, broad strings, untyped JSON
- nullable/optional values without domain meaning
- repeated runtime guards inside trusted code
- invalid states representable by default

### Test Confidence

Question: would tests catch the bugs this area is likely to produce?

Signals:

- tests assert implementation details
- heavy mocks hide real integration behavior
- important seams have no tests
- fixtures make invalid states easy

### Module Depth / Architecture

Question: does each module provide leverage behind a small, coherent interface?

Use `architecture-depth.md` for deep-vs-shallow module analysis, deletion tests, seam/adapters, dependency categories, and interface exploration.

Signals:

- pass-through wrappers
- shallow helpers that scatter complexity
- interfaces as complex as implementations
- seams created before two real adapters exist
- tests that reach past the public interface
- local changes that reappear across many callers

### Dead Code / Duplication / Slop

Question: is the codebase carrying weight that no longer buys clarity or behavior?

Signals:

- unused private code
- duplicate decisions across files
- stale comments/tests
- mechanical indirection

### Dependency Direction

Question: do dependencies point in an understandable direction?

Signals:

- cycles
- domain logic imports framework shells
- low-level modules know high-level policy
- test utilities leak into production code

## Severity

- **Critical** - likely production breakage, data loss, security exposure, or impossible-to-verify core path.
- **High** - likely wrong future edits, fragile architecture, poor test confidence in important path.
- **Medium** - meaningful maintainability drag, local ambiguity, fixable type/test gap.
- **Low** - small cleanup with limited risk.

## Required Finding Shape

```text
[severity] [tier] [dimension] Title

Symptom:
What is visibly wrong.

Evidence:
Files, snippets, diff facts, tests, graph, or docs showing it.

Consequence:
Concrete future failure or wrong edit.

Remedy:
Smallest useful correction. Include safe fallback if direct fix is risky.

Verification:
Type checks, tests, manual checks, or design review needed.
```

No evidence, no finding.

## Scoring

Start each dimension at 100. Deduct:

- Critical: -25
- High: -15
- Medium: -8
- Low: -3

Cap each dimension at minimum 0. Overall health score is weighted average:

- Change safety: 20%
- Agent navigability: 15%
- Domain clarity / ambiguity: 15%
- Type safety: 15%
- Test confidence: 15%
- Module depth / architecture: 10%
- Dead code / duplication / slop: 5%
- Dependency direction: 5%

If scope is small, score only inspected scope and label it clearly.
