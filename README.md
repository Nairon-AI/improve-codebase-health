<div align="center">

# Improve Codebase Health

### The code-health steward for safer AI-assisted engineering

**Scope + Score + Safe Cleanup + Refactor Plan = Healthier Codebase**
_Harden recent work, reduce ambiguity, strengthen types, and keep architecture changes intentional._

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Codex Skill](https://img.shields.io/badge/Codex-Skill-111827.svg)](skills/improve-codebase-health/SKILL.md)
[![Nairon AI](https://img.shields.io/badge/Nairon-AI-111827.svg)](https://github.com/Nairon-AI)

---

_Most codebases do not fail because one file is messy. They fail because unsafe change becomes normal._

</div>

---

## What is this?

Improve Codebase Health is a standalone agent skill for scoped code-health reviews. It helps a coding agent inspect a branch, path, PR, issue, recent time window, feature area, or whole repo; score the health risks; apply only boring safe cleanup when requested; and turn risky architecture changes into explicit plans.

The main use case is a Friday hardening pass after a feature week. Instead of asking an agent to "clean up the codebase" and hoping it does not break everything, the skill forces scope, mode, safety tier, evidence, and verification before edits happen.

The skill is intentionally conservative. It improves the codebase so humans and agents can make future changes with more confidence, not less.

---

## How It Works

```text
User invokes skill             No args asks scope + mode
        |
        v
Scope selection                Diff, last N days, path, PR, issue, feature, repo
        |
        v
Context read                   README, SKILLS, domain docs, ADRs, tests
        |
        v
Health assessment              Safety, ambiguity, types, tests, architecture, slop
        |
        v
Safety tiering                 Report only, auto-safe, ask first, design required
        |
        v
Optional safe cleanup          Tier 1 only, then typecheck and narrow tests
        |
        v
Ranked handoff                 Applied fixes, approval items, deferred design work
```

---

## What It Produces

| Output | Purpose |
| --- | --- |
| **Health Score** | Gives the inspected scope a `0-100` code-health score |
| **Dimension Scores** | Separates risk across change safety, agent navigability, ambiguity, types, tests, architecture, slop, and dependency direction |
| **Tiered Findings** | Marks each item as report-only, auto-safe, ask-first, or design-required |
| **Safe Cleanup Patch** | Applies only Tier 1 changes in safe cleanup modes |
| **Ambiguity Report** | Shows names/concepts that could cause plausible wrong future edits |
| **Refactor Candidates** | Ranks Tier 2/3 changes that need approval or design |
| **Verification Notes** | Lists type checks, tests, and any gaps |

---

## Engineering Foundation

Improve Codebase Health reviews architecture and code smells through a classic software-engineering lens, not only style or complexity metrics. Recommendations should connect symptoms in the code to durable principles from books and field-tested engineering practice.

| Source Lens | What It Helps Detect |
| --- | --- |
| **The Mythical Man-Month** | Accidental complexity, coordination drag, false confidence from adding more people or agents |
| **Code Complete** | Unclear control flow, weak naming, risky conditionals, low-level implementation confusion |
| **Refactoring** | Duplicate knowledge, divergent change, shotgun surgery, feature envy, dead weight |
| **Clean Architecture** | Dependency direction, policy/detail leakage, unstable boundaries |
| **The Pragmatic Programmer** | Orthogonality loss, knowledge duplication, fragile assumptions, hidden coupling |
| **Domain-Driven Design** | Distorted domain language, overloaded concepts, mismatched models |
| **A Philosophy of Software Design** | Shallow modules, high cognitive load, leaky interfaces |
| **Software Engineering at Google** | Sustainable change, dependency hygiene, test strategy, codebase-scale maintenance |
| **Working Effectively with Legacy Code** | Missing seams, hard-to-test code, characterization-test needs |
| **xUnit Test Patterns** | Test smells, fixture bloat, brittle tests, unclear test intent |
| **The Art of Unit Testing** | Poor isolation, unreadable tests, false confidence from weak assertions |
| **How Google Tests Software** | Risk-based testing, confidence by layer, integration coverage gaps |

The point is not to quote books for decoration. The point is to make each architecture or code-smell recommendation traceable:

```text
Symptom in code
        |
        v
Underlying engineering principle
        |
        v
Concrete consequence for future changes
        |
        v
Smallest safe remedy or intentional design plan
```

---

## What This Catches That Linters Miss

| Risk | Why It Matters |
| --- | --- |
| **Change Propagation** | One small product change forces edits across unrelated modules |
| **Cognitive Overload** | Agents and humans need too much context before making safe edits |
| **Knowledge Duplication** | The same decision lives in multiple files and drifts over time |
| **Accidental Complexity** | The code is harder than the business problem requires |
| **Dependency Disorder** | Details pull policy downward or create circular ownership |
| **Domain Model Distortion** | Code names and data shapes stop matching the product reality |
| **Test Fragility** | Tests protect implementation trivia instead of behavior |
| **False Confidence** | A passing suite does not cover the risks the code actually has |

This is why the skill treats code health as more than "cleanup." Some findings become safe edits. Some become explicit refactor plans. Some become ADRs or glossary updates because the right move is to preserve context before changing code.

---

## Product Principles

1. **Scope before judgment** - No-arg runs must ask what area to inspect and what level of action is allowed.

2. **Safety over momentum** - Missing a safe cleanup is better than making a clever breaking change.

3. **Evidence before opinion** - Every finding needs concrete files, snippets, diff facts, tests, docs, or dependency evidence.

4. **Ambiguity means wrong edits** - A vague name is only a finding when a future human or agent could plausibly change the wrong thing.

5. **Architecture changes require intent** - New seams, public contract changes, migrations, auth/payment/data boundaries, and domain model shifts need approval or design.

6. **Type safety is codebase UX** - Stronger types make the platform easier for agents to navigate and harder to misuse.

7. **Tests should protect behavior** - Cleanup should remove tests that lock incidental structure and add confidence at real interfaces.

8. **Verification closes the loop** - Type checks and narrow tests are mandatory for touched surfaces.

---

## Scope Modes

| Scope | Best Use |
| --- | --- |
| **Current Branch Diff** | Friday hardening before PR or merge |
| **Last N Days** | End-of-week cleanup across several branches or commits |
| **Path / Package** | Focused health pass on one app, package, or subsystem |
| **PR / Issue** | Review recent code plus discussion and CI context |
| **Feature Area** | Agent maps files by domain terms before scanning |
| **Whole Repo** | Broad audit, usually report-heavy and edit-light |

---

## Action Modes

| Mode | Edits? | Purpose |
| --- | --- | --- |
| **Audit Only** | No | Understand health risk without changing code |
| **Safe Cleanup** | Tier 1 only | Apply low-risk local cleanup |
| **Plan Refactor** | No | Turn Tier 2/3 findings into an implementation plan |
| **Friday Steward** | Tier 1 + candidates | Weekly habit: safe fixes plus ranked approval items |

---

## Safety Tiers

| Tier | Authority | Examples |
| --- | --- | --- |
| **Tier 0** | Report only | Low-confidence smell, broad concern, needs product answer |
| **Tier 1** | Auto-safe | Remove unused private code, rename private local, tighten obvious local type |
| **Tier 2** | Ask first | Exported rename, file move, module merge, test strategy change |
| **Tier 3** | Design required | New seam, public API shape, persistence/auth/payment boundary, database rename |

Tier 1 is deliberately boring. That is the point.

---

## Health Dimensions

| Dimension | Question |
| --- | --- |
| **Change Safety** | Can focused changes avoid unrelated breakage? |
| **Agent Navigability** | Can agents find files, concepts, and checks quickly? |
| **Domain Clarity / Ambiguity** | Could names or models cause plausible wrong edits? |
| **Type Safety** | Do types encode important invariants? |
| **Test Confidence** | Would tests catch likely bugs? |
| **Module Depth / Architecture** | Do modules provide leverage behind coherent interfaces? |
| **Dead Code / Duplication / Slop** | Is stale weight slowing the system down? |
| **Dependency Direction** | Do dependencies point in understandable directions? |

---

## Usage

No-arg interactive run:

```text
/improve-codebase-health
```

Recommended Friday flow:

```text
/improve-codebase-health --scope diff --mode friday-steward
```

Audit recent branch work:

```text
/improve-codebase-health --scope diff --mode audit
```

Safely clean recent branch work:

```text
/improve-codebase-health --scope diff --mode safe-cleanup
```

Harden the last five days:

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

---

## Built Surfaces

| Surface | Status | Purpose |
| --- | --- | --- |
| **Skill** | Built | Main `improve-codebase-health` agent workflow |
| **References** | Built | Risk framework, scope modes, safety tiers, ambiguity rubric |
| **Command Wrapper** | Built | Slash command entrypoint |
| **Evals** | Initial | Basic expected-behavior cases |
| **Package Metadata** | Initial | Codex plugin metadata and npm package shell |

---

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

---

## Development

```bash
npm run check
```

The check validates required files and JSON metadata.

---

## Documentation

| Doc | Description |
| --- | --- |
| [Setup](docs/SETUP.md) | Install/copy instructions and first run |
| [Skill](skills/improve-codebase-health/SKILL.md) | Main agent workflow |
| [Risk Framework](skills/improve-codebase-health/references/risk-framework.md) | Health dimensions, severity, scoring, finding format |
| [Safety Tiers](skills/improve-codebase-health/references/safety-tiers.md) | Edit authority rules |
| [Ambiguity Rubric](skills/improve-codebase-health/references/ambiguity-rubric.md) | Naming/concept ambiguity evidence rules |
| [Scope and Modes](skills/improve-codebase-health/references/scope-and-modes.md) | Supported scope and action modes |
| [Evals](evals/evals.json) | Initial expected-behavior checks |

---

## License

[MIT](LICENSE)

---

<div align="center">

_Built by [Nairon AI](https://github.com/Nairon-AI)_

**Harden the codebase before agents run faster.**

</div>
