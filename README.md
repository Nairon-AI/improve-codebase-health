<div align="center">

# Improve Codebase Health

### Book-grounded code health reviews for safer AI-assisted engineering

**Weekly Stewardship + Timeless Engineering Principles + Agent-Readable Architecture**
_Keep the codebase clear enough that humans and coding agents can change it safely._

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Codex Skill](https://img.shields.io/badge/Codex-Skill-111827.svg)](skills/improve-codebase-health/SKILL.md)
[![Nairon AI](https://img.shields.io/badge/Nairon-AI-111827.svg)](https://github.com/Nairon-AI)

---

_AI makes code faster to write. It also makes architecture easier to lose touch with._

</div>

---

## What is this?

Improve Codebase Health is a standalone agent skill for scoped code-health reviews. Run it inside a product repo to inspect a branch, path, PR, issue, recent time window, feature area, or whole codebase.

It is built for weekly codebase stewardship. After a week of feature work, the agent reviews what changed, scores code-health risk, applies only boring safe cleanup when allowed, and turns riskier architecture work into explicit plans instead of surprise refactors.

The review model is grounded in classic software-engineering architecture and testing books. Findings should connect a code symptom to an underlying principle, explain the future failure mode, and propose the smallest safe remedy.

---

## Why this exists

Software engineering principles are timeless: clear boundaries, deep interfaces, strong names, useful tests, local reasoning, and dependency discipline still matter. AI does not remove that. It raises the stakes.

In a v1 codebase, agents can move quickly even when the architecture is fuzzy. By v100, after many small sloppy changes, the same fuzziness becomes brittleness: names drift, interfaces leak, tests protect the wrong things, and nobody fully trusts the shape of the system. Humans can often feel that pain before they can name it. Coding agents usually cannot. They need the pain translated into explicit signals.

Improve Codebase Health turns that felt engineering judgment into a repeatable review habit:

- spot paper cuts before they become local conventions
- surface major architecture problems before they become expensive rewrites
- clarify domain language so agents do not make plausible wrong edits
- keep boundaries, interfaces, tests, and types understandable
- preserve human understanding of the codebase as it scales
- make the platform safer for future agents to change

This is not a once-a-quarter cleanup project. It is meant to be embedded in the repo and run regularly, ideally once a week, so codebase health is continuously monitored instead of deferred until everything feels brittle.

---

## Install

Run this prompt inside the target repo using Codex or Claude Code:

```text
Install the Improve Codebase Health skill from https://github.com/Nairon-AI/improve-codebase-health into this repo.

Do the install cleanly:
- Read this repo's existing AGENTS.md, CLAUDE.md, README.md, and nearest SKILLS.md first.
- Preserve existing work. Do not overwrite unrelated files.
- Install the skill from skills/improve-codebase-health into this repo's normal agent skill location.
- If this repo uses .agents/skills, install it there.
- If this repo uses .claude/skills, install it there too.
- If neither exists, create .agents/skills/improve-codebase-health.
- Add or update a short AGENTS.md/CLAUDE.md note only if the repo already has an agent-skills section.
- Do not change product code.
- Verify the skill files exist after install.
- Show git status, installed paths, and any warnings.
```

Then invoke:

```text
/improve-codebase-health
```

This repo ships the actual **skill** at `skills/improve-codebase-health/`, plus a thin command/plugin wrapper for agent environments that support it.

---

## How It Works

```text
Choose scope + mode
        |
        v
Read repo context              README, SKILLS, domain docs, ADRs, tests
        |
        v
Assess health                  Safety, ambiguity, types, tests, architecture
        |
        v
Classify authority             Report only, auto-safe, ask first, design required
        |
        v
Verify + hand off              Applied fixes, approval items, deferred design work
```

---

## Engineering Foundation

Improve Codebase Health treats code smells and architecture issues as engineering signals, not style complaints. It draws from durable ideas in:

| Source Lens | What It Helps Detect |
| --- | --- |
| **The Mythical Man-Month** | accidental complexity, coordination drag, false confidence from adding more agents |
| **Code Complete** | unclear control flow, weak naming, risky conditionals |
| **Refactoring** | duplicate knowledge, divergent change, shotgun surgery, dead weight |
| **Clean Architecture** | dependency direction, policy/detail leakage, unstable boundaries |
| **The Pragmatic Programmer** | orthogonality loss, hidden coupling, fragile assumptions |
| **Domain-Driven Design** | distorted domain language, overloaded concepts, mismatched models |
| **A Philosophy of Software Design** | shallow modules, high cognitive load, leaky interfaces |
| **Software Engineering at Google** | sustainable change, dependency hygiene, codebase-scale maintenance |
| **Working Effectively with Legacy Code** | missing seams, hard-to-test code, characterization-test needs |
| **xUnit Test Patterns / Art of Unit Testing / How Google Tests Software** | brittle tests, fixture bloat, weak assertions, risk-based coverage gaps |

Every meaningful recommendation should trace:

```text
Symptom in code -> principle violated -> likely future failure -> safe remedy or design plan
```

---

## What It Produces

| Output | Purpose |
| --- | --- |
| **Health Score** | `0-100` score for the inspected scope |
| **Dimension Scores** | Separate signal for safety, navigability, ambiguity, types, tests, architecture, slop, dependencies |
| **Tiered Findings** | Every finding gets edit authority: report-only, auto-safe, ask-first, design-required |
| **Safe Cleanup Patch** | Tier 1 fixes only, when mode allows edits |
| **Ambiguity Report** | Names/concepts that could cause plausible wrong edits |
| **Refactor Candidates** | Tier 2/3 changes ranked for approval or design |
| **Verification Notes** | Type checks, tests, skipped checks, and remaining risk |

---

## Usage

Recommended Friday flow:

```text
/improve-codebase-health --scope diff --mode friday-steward
```

Common runs:

```text
/improve-codebase-health --scope diff --mode audit
/improve-codebase-health --scope diff --mode safe-cleanup
/improve-codebase-health --scope since --since 5 --mode friday-steward
/improve-codebase-health --scope feature --feature onboarding --mode plan-refactor
/improve-codebase-health --scope path --path packages/billing --mode audit
```

No-arg usage asks two questions:

1. What scope should I inspect?
2. What should I do?

---

## Safety Model

| Tier | Authority | Examples |
| --- | --- | --- |
| **Tier 0** | Report only | low-confidence smell, broad concern, needs product answer |
| **Tier 1** | Auto-safe | remove unused private code, rename private local, tighten obvious local type |
| **Tier 2** | Ask first | exported rename, file move, module merge, test strategy change |
| **Tier 3** | Design required | new seam, public API shape, persistence/auth/payment boundary, database rename |

Tier 1 is deliberately boring. Risky architecture changes become plans, not surprise edits.

---

## What This Catches That Linters Miss

| Risk | Why It Matters |
| --- | --- |
| **Change Propagation** | one small product change forces edits across unrelated modules |
| **Cognitive Overload** | agents and humans need too much context before safe edits |
| **Knowledge Duplication** | the same decision lives in multiple files and drifts |
| **Domain Model Distortion** | code names and data shapes stop matching product reality |
| **Test Fragility** | tests protect implementation trivia instead of behavior |
| **False Confidence** | a passing suite does not cover the risks the code actually has |

---

## Docs

| Doc | Description |
| --- | --- |
| [Setup](docs/SETUP.md) | Install prompt, manual fallback, first run |
| [Skill](skills/improve-codebase-health/SKILL.md) | Main workflow |
| [Risk Framework](skills/improve-codebase-health/references/risk-framework.md) | Dimensions, severity, scoring, finding format |
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

**Harden the codebase before agents run faster.**

</div>
