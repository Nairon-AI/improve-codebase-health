# Improve Codebase Health

Scoped code-health steward for safer human and AI-assisted engineering.

Improve Codebase Health audits recent changes or selected code areas, scores maintainability risk, applies only auto-safe cleanup when requested, and surfaces larger refactors as explicit plans. It is designed for weekly Friday hardening: reduce debt, clarify ambiguous names, strengthen types, improve tests, and make the platform easier for coding agents to navigate without breaking production behavior.

```text
Choose scope + mode
        |
        v
Health scan across safety, clarity, types, tests, architecture
        |
        v
Tier findings: report, auto-safe, ask-first, design-required
        |
        v
Optional Tier 1 cleanup -> typecheck/tests
        |
        v
Ranked refactor/architecture candidates -> human approval
```

## Start Here

Run this from the product repo you want to inspect.

Recommended Friday flow:

```text
/improve-codebase-health --scope diff --mode friday-steward
```

No-argument flow:

```text
/improve-codebase-health
```

The agent asks:

1. What scope should I inspect?
2. What should I do?

Good first run:

- scope: `Current branch diff`
- mode: `Audit only`

Then run safe cleanup only after the report looks right:

```text
/improve-codebase-health --scope diff --mode safe-cleanup
```

Full setup guide: [docs/SETUP.md](docs/SETUP.md).

### First Local Test

No external service required.

1. Copy or install the skill into your agent environment.
2. `cd` into a product repo.
3. Run `/improve-codebase-health --scope diff --mode audit`.
4. Confirm output includes health score, dimension scores, scope, mode, findings, and verification.
5. Run `/improve-codebase-health --scope diff --mode safe-cleanup` only if you want Tier 1 fixes.

Good first result:

```text
Health Score: 82/100
Scope: current branch diff against origin/main
Mode: audit
```

## How Scope Works

Improve Codebase Health is intentionally scoped. No-arg usage asks for scope; explicit args skip questions.

Common scopes:

```text
/improve-codebase-health --scope diff
/improve-codebase-health --scope since --since 5
/improve-codebase-health --scope path --path apps/web
/improve-codebase-health --scope pr --pr 123
/improve-codebase-health --scope issue --issue 123
/improve-codebase-health --scope feature --feature onboarding
/improve-codebase-health --scope repo
```

Default recommendation for feature hardening:

```text
/improve-codebase-health --scope diff --mode friday-steward
```

## Modes

```text
/improve-codebase-health --mode audit
/improve-codebase-health --mode safe-cleanup
/improve-codebase-health --mode plan-refactor
/improve-codebase-health --mode friday-steward
```

- `audit`: report only, no edits.
- `safe-cleanup`: apply Tier 1 fixes only.
- `plan-refactor`: produce Tier 2/3 plan, no edits.
- `friday-steward`: apply Tier 1 fixes, rank Tier 2/3 candidates.

## What It Does

- Scores scoped code health from `0-100`.
- Reviews recent changes, paths, PRs, issues, features, or whole repos.
- Finds change-safety risk, agent navigability gaps, ambiguity, type holes, weak tests, shallow modules, duplication, and dependency-direction problems.
- Classifies every finding by edit authority:
  - Tier 0: report only
  - Tier 1: auto-safe
  - Tier 2: ask first
  - Tier 3: design required
- Applies only Tier 1 fixes in safe cleanup modes.
- Produces concrete verification instructions.
- Surfaces risky architecture changes as plans, not surprise edits.

## What It Does Not Do

- It does not silently reshape architecture.
- It does not rename public APIs without approval.
- It does not run migrations or backfills automatically.
- It does not touch auth, payment, permission, or production-data boundaries as auto-safe work.
- It does not treat subjective naming taste as ambiguity.
- It does not replace repo-native type checks, tests, or human review.

## Requirements

- A git repository.
- Repo-native typecheck/test commands documented in `README.md`, `SKILLS.md`, package scripts, or local docs.
- Optional: GitHub CLI for PR/issue scope.
- Optional: an agent environment with a question tool for no-argument scope/mode selection.

## Health Dimensions

| Dimension | Question |
| --- | --- |
| Change safety | Can focused changes avoid unrelated breakage? |
| Agent navigability | Can agents find files, concepts, and checks quickly? |
| Domain clarity / ambiguity | Could names/models cause plausible wrong edits? |
| Type safety | Do types encode important invariants? |
| Test confidence | Would tests catch likely bugs? |
| Module depth / architecture | Do modules provide leverage behind coherent interfaces? |
| Dead code / duplication / slop | Is stale weight slowing the system down? |
| Dependency direction | Do dependencies point in understandable directions? |

## Safety Tiers

Tier 1 is intentionally strict. A cleanup is auto-safe only when:

- blast radius is local
- no public/exported contract changes
- no runtime behavior change except unreachable/dead behavior removal
- typecheck proves callers still valid
- tests exist or narrow verification is possible
- patch is easy to review

Everything else becomes ask-first or design-required.

## Ambiguity

Ambiguity means a future human or coding agent could make a plausible wrong edit because code or docs allow multiple meanings.

Every ambiguity finding must show:

- ambiguous symbol or concept
- competing interpretations
- evidence each interpretation is plausible
- likely wrong edit
- best fix
- safe fallback if rename/migration is risky
- documentation home

If a database table or old exported name is hard to rename, the skill should still surface it and recommend a glossary entry, ADR, boundary type alias, short seam comment, or migration plan.

## Repository Layout

```text
improve-codebase-health/
├── README.md
├── LICENSE
├── package.json
├── .codex-plugin/
│   └── plugin.json
├── commands/
│   └── improve-codebase-health.md
├── docs/
│   └── SETUP.md
├── evals/
│   └── evals.json
├── scripts/
│   └── check.js
└── skills/
    └── improve-codebase-health/
        ├── SKILL.md
        └── references/
            ├── ambiguity-rubric.md
            ├── risk-framework.md
            ├── safety-tiers.md
            └── scope-and-modes.md
```

## Usage Patterns

Audit recent branch work:

```text
/improve-codebase-health --scope diff --mode audit
```

Safely clean recent branch work:

```text
/improve-codebase-health --scope diff --mode safe-cleanup
```

Harden last five days:

```text
/improve-codebase-health --scope since --since 5 --mode friday-steward
```

Plan a risky refactor:

```text
/improve-codebase-health --scope feature --feature onboarding --mode plan-refactor
```

Inspect a package:

```text
/improve-codebase-health --scope path --path packages/billing --mode audit
```

## License

MIT License. See [LICENSE](LICENSE).
