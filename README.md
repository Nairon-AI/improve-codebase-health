<div align="center">

# Improve Codebase Health

Codebase health reviews grounded in classic software engineering books.

Consistent. Traceable. Safe to act on.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code Plugin](https://img.shields.io/badge/Claude_Code-Plugin-111827.svg)](.claude-plugin/plugin.json)
[![Codex Plugin](https://img.shields.io/badge/Codex-Plugin-111827.svg)](.codex-plugin/plugin.json)

Health Dimensions • What It Looks Like • Installation

</div>

---

> AI makes code faster to write. It also makes architecture easier to lose touch with.

Most code quality tools check syntax, style, coverage, or complexity. Improve Codebase Health goes after the slower problem: codebase drift.

It reviews a branch, PR, path, feature area, recent time window, or full repo and asks:

```text
Is this codebase still safe to change?
```

It can be run anytime: before a PR, after a feature lands, during a refactor, as part of Friday cleanup, or whenever a codebase starts feeling harder to reason about. Weekly stewardship is a good habit, not a limitation.

Findings are grounded in classic software engineering principles, then classified by safety so agents do not casually reshape architecture.

---

## The Books

| Book | Author | Helps Detect |
| --- | --- | --- |
| The Mythical Man-Month | Frederick Brooks | accidental complexity, coordination drag |
| Code Complete | Steve McConnell | unclear control flow, weak naming, risky conditionals |
| Refactoring | Martin Fowler | duplication, divergent change, shotgun surgery |
| Clean Architecture | Robert C. Martin | dependency direction, policy/detail leakage |
| The Pragmatic Programmer | Andrew Hunt & David Thomas | hidden coupling, knowledge duplication |
| Domain-Driven Design | Eric Evans | distorted domain language, overloaded concepts |
| A Philosophy of Software Design | John Ousterhout | shallow modules, high cognitive load |
| Software Engineering at Google | Titus Winters, Tom Manshreck & Hyrum Wright | sustainable change, dependency hygiene |
| Working Effectively with Legacy Code | Michael Feathers | missing seams, hard-to-test code |
| xUnit Test Patterns | Gerard Meszaros | brittle tests, fixture bloat |
| The Art of Unit Testing | Roy Osherove | weak assertions, poor isolation |
| How Google Tests Software | James Whittaker, Jason Arbon & Jeff Carollo | risk-based testing, confidence gaps |

The point is not book trivia. It is traceability:

```text
Symptom -> Source principle -> Consequence -> Remedy
```

---

## Health Dimensions

| Dimension | Diagnostic Question |
| --- | --- |
| Change Safety | How many unrelated things could break from one change? |
| Agent Navigability | Can an agent find the right files, concepts, and checks quickly? |
| Domain Clarity / Ambiguity | Could names or models cause plausible wrong edits? |
| Type Safety | Do types encode important invariants? |
| Test Confidence | Would tests catch the bugs this area is likely to produce? |
| Module Depth / Architecture | Do modules provide leverage behind coherent interfaces? |
| Dead Code / Duplication / Slop | Is stale weight slowing the system down? |
| Dependency Direction | Do dependencies point in an understandable direction? |

Architecture findings also use the bundled [Architecture Depth](skills/improve-codebase-health/references/architecture-depth.md) framework: modules, interfaces, seams, adapters, deletion tests, dependency categories, and interface exploration.

---

## What It Looks Like

```text
Health Score: 74/100
Scope: current branch diff against origin/main
Mode: friday-steward

[high] [Tier 3] [Module Depth / Architecture]
Checkout orchestration leaks payment, inventory, and email details

Symptom:
The checkout module forces callers and tests to know payment capture order,
inventory reservation rules, and email notification timing.

Source:
Ousterhout — A Philosophy of Software Design — shallow modules.
Fowler — Refactoring — divergent change.

Consequence:
A small change to fulfillment can break payment or notification behavior.
Future agents have no stable interface to modify safely.

Remedy:
Design a deeper CheckoutFlow interface that owns orchestration and exposes
observable outcomes. Treat as design-required before implementation.

Verification:
Move tests to the new interface. Keep payment/inventory/email behind adapters.
```

---

## Safety Tiers

| Tier | Meaning | Agent Authority |
| --- | --- | --- |
| Tier 0 | Report only | No edits |
| Tier 1 | Auto-safe cleanup | May edit when mode allows |
| Tier 2 | Ask first | Plan patch, wait for approval |
| Tier 3 | Design required | Grill/design/ADR before implementation |

This is the important part: the plugin can surface architecture drift without letting an agent casually rewrite your system.

---

## Installation

### Claude Code

```text
/plugin marketplace add Nairon-AI/improve-codebase-health
/plugin install improve-codebase-health@improve-codebase-health-marketplace
```

### Codex / Repo-aware Agents

Ask the agent:

```text
Install the Improve Codebase Health plugin from Nairon-AI/improve-codebase-health
```

### Manual Skill Install

```bash
mkdir -p .agents/skills
cp -R skills/improve-codebase-health .agents/skills/improve-codebase-health
```

Then run:

```text
/improve-codebase-health
```

No-arg usage asks for scope and mode. You can also call it directly:

```text
/improve-codebase-health --scope diff --mode audit
/improve-codebase-health --scope diff --mode safe-cleanup
/improve-codebase-health --scope since --since 5 --mode friday-steward
/improve-codebase-health --scope feature --feature onboarding --mode plan-refactor
```

---

## What Linters Miss

Improve Codebase Health does not replace ESLint, Pylint, typecheckers, or tests.

It catches the slower problems:

- architecture drift
- shallow modules
- weak seams
- vague domain language
- tests that protect implementation trivia
- types that allow invalid states
- changes that scatter across unrelated modules
- code that agents can plausibly misunderstand

---

## Docs

| Doc | Description |
| --- | --- |
| [Setup](docs/SETUP.md) | Install and first run |
| [Skill](skills/improve-codebase-health/SKILL.md) | Main workflow |
| [Risk Framework](skills/improve-codebase-health/references/risk-framework.md) | Dimensions, severity, scoring, finding format |
| [Architecture Depth](skills/improve-codebase-health/references/architecture-depth.md) | Deep modules, interfaces, seams, adapters |
| [Safety Tiers](skills/improve-codebase-health/references/safety-tiers.md) | Edit authority rules |
| [Ambiguity Rubric](skills/improve-codebase-health/references/ambiguity-rubric.md) | Naming/concept ambiguity rules |
| [Scope and Modes](skills/improve-codebase-health/references/scope-and-modes.md) | Supported scopes and action modes |

---

## Development

```bash
npm run check
```

## License

[MIT](LICENSE)

---

<div align="center">

_Built by [Nairon AI](https://github.com/Nairon-AI)_

**Keep the codebase clear enough for humans and agents to change safely.**

</div>
