---
name: improve-codebase-health
description: Improve codebase health through scoped audits, safe cleanup, ambiguity reduction, type-safety hardening, test-confidence review, and architecture/debt planning. Use for Friday cleanup, recent-change hardening, technical debt reduction, agent navigability, naming clarity, module depth, dependency direction, or code health scoring.
---

# Improve Codebase Health

Run a conservative code-health steward workflow. The goal is a codebase humans and coding agents can change safely: clearer concepts, stronger types, better tests, less dead weight, lower architecture risk.

## Core Rule

Improve safety, not vibes. Every finding needs concrete evidence, a plausible consequence, a safety tier, and verification.

When invoked with no arguments, ask at most two questions:

1. **Scope** - current branch diff, last N days, path/package, PR/issue, feature area, or whole repo.
2. **Mode** - audit only, safe cleanup, plan refactor, or Friday steward.

Use the environment's question tool when available. If not, ask plainly. If arguments already define scope and mode, do not ask.

## Supported Arguments

- `--scope diff|repo|path|since|pr|issue|feature`
- `--mode audit|safe-cleanup|plan-refactor|friday-steward`
- `--path <path>`
- `--since <days-or-date>`
- `--pr <number-or-url>`
- `--issue <number-or-url>`
- `--feature <name>`
- `--target <score>`
- `--fix-safe`

Default recommended Friday invocation:

```text
/improve-codebase-health --scope diff --mode friday-steward
```

## Modes

- **Audit only** - report findings, no edits.
- **Safe cleanup** - apply Tier 1 fixes only, then verify.
- **Plan refactor** - design Tier 2/3 changes, no edits.
- **Friday steward** - audit scoped work, apply Tier 1 fixes, rank Tier 2/3 candidates.

## Workflow

### 1. Establish Scope

Read [scope-and-modes.md](references/scope-and-modes.md). Resolve scope before scanning.

Prefer narrow scopes:

1. Explicit args.
2. Current branch diff against `origin/main`.
3. User-selected scope.
4. Whole repo only when requested.

### 2. Build Context

Read the nearest repo docs before judging code:

- `README.md`
- nearest `SKILLS.md`
- `CONTEXT.md` or domain glossary if present
- `docs/adr/` for relevant architecture decisions
- existing tests for touched areas

For large scopes, delegate read-only exploration to parallel subagents when available. Give each subagent a bounded question and avoid duplicate exploration.

### 3. Assess Health

Use [risk-framework.md](references/risk-framework.md) for dimensions and finding format.

For module depth, interface, seam, dependency inversion, or architecture refactor findings, also use [architecture-depth.md](references/architecture-depth.md). It contains the deletion test, deep-vs-shallow module vocabulary, dependency categories, and interface exploration workflow.

Score:

- Change safety
- Agent navigability
- Domain clarity / ambiguity
- Type safety
- Test confidence
- Module depth / architecture
- Dead code / duplication / slop
- Dependency direction

### 4. Classify Edit Authority

Use [safety-tiers.md](references/safety-tiers.md).

- **Tier 0: Report only** - no edits.
- **Tier 1: Auto-safe** - may edit in safe cleanup / Friday steward.
- **Tier 2: Ask first** - plan patch, wait for approval.
- **Tier 3: Design required** - grill/design doc/ADR before implementation.

Be strict. Missing a safe fix is better than breaking the system.

### 5. Handle Ambiguity

Use [ambiguity-rubric.md](references/ambiguity-rubric.md).

Ambiguity means a future human or agent could make a plausible wrong edit because code/docs allow multiple interpretations. Do not report naming preferences as ambiguity.

If a rename or migration is too risky, create a documentation fallback:

- glossary entry in `CONTEXT.md`
- ADR for intentionally retained bad names
- short code comment at the confusing seam
- type alias/wrapper when it clarifies without migration
- migration plan, not migration

### 6. Handle Architecture Depth

Use [architecture-depth.md](references/architecture-depth.md) when findings involve shallow modules, unclear interfaces, seams, adapters, module consolidation, or testability.

Do not auto-edit these unless they are clearly Tier 1. Most architecture-depth work is Tier 2 or Tier 3:

- Tier 2 when the shape is obvious and contained.
- Tier 3 when a new interface, seam, adapter strategy, or domain concept is involved.

For Tier 3, use the interface exploration workflow before implementation.

### 7. Apply Allowed Fixes

Only edit automatically when all Tier 1 rules pass.

Do not change public contracts, move cross-module files, add seams, change persistence/auth/payment boundaries, or rename exported symbols without explicit approval.

For each edit:

- fix root cause, not score symptoms
- keep patch reviewable
- update or delete tests that protect old incidental structure
- run required type checks and narrow tests for changed surfaces

### 8. Report

Use this output shape:

```text
Health Score: N/100
Scope: ...
Mode: ...

Dimension Scores:
- Change safety: N/100
- Agent navigability: N/100
- Domain clarity / ambiguity: N/100
- Type safety: N/100
- Test confidence: N/100
- Module depth / architecture: N/100
- Dead code / duplication / slop: N/100
- Dependency direction: N/100

Findings:
1. [severity] [tier] [dimension] Title
   Symptom:
   Evidence:
   Consequence:
   Remedy:
   Verification:

Applied:
- ...

Needs approval:
- ...

Deferred:
- ...
```

## Verification

Before completion:

- Run repo-native type checks for every changed surface.
- Run narrow tests for touched behavior.
- If no checks exist, state that clearly and list manual verification performed.
- Show what changed and what remains.

## Hard Stops

Do not auto-edit:

- database schema/table renames
- auth, payment, permission, or production-data boundaries
- public/exported contracts
- cross-package architecture
- migrations/backfills
- anything requiring an ADR

Surface those as Tier 2 or Tier 3 with a plan.
