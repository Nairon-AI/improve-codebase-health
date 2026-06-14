<p align="center">
  <img src="assets/logo.svg" alt="Improve Codebase Health" width="160">
</p>

<h1 align="center">Improve Codebase Health</h1>

<p align="center">
  <strong>Codebase health reviews grounded in classic software engineering books.<br>
  Consistent. Traceable. Safe to act on.</strong>
</p>

<p align="center">
  <a href="#health-dimensions">Health Dimensions</a> •
  <a href="#what-it-looks-like">What It Looks Like</a> •
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#comparison">Comparison</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/version-0.1.0-blue.svg" alt="Version">
  <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="MIT License">
  <img src="https://img.shields.io/badge/Claude_Code-Plugin-blueviolet.svg" alt="Claude Code Plugin">
  <img src="https://img.shields.io/badge/Codex_CLI-Plugin-orange.svg" alt="Codex Plugin">
</p>

---

AI makes code faster to write. It also makes architecture easier to lose touch with.

Improve Codebase Health is a plugin package that helps coding agents review whether a codebase is still safe to change. It looks past syntax, style, and coverage into the problems that compound slowly: vague names, shallow modules, weak seams, dependency drift, brittle tests, and code that future agents can plausibly misunderstand.

Run it anytime: before a PR, after a feature lands, during a refactor, before release, or as a regular codebase stewardship ritual. Weekly cleanup is a good habit, not a product limitation.

Every finding follows:

```text
Symptom -> Source -> Consequence -> Remedy
```

And every recommendation is classified by safety:

```text
Tier 0: report only
Tier 1: auto-safe cleanup
Tier 2: ask before changing
Tier 3: design required
```

The point is simple: surface architecture drift without letting agents casually reshape the system.

## The Books

| Book | Author | Helps Detect |
| --- | --- | --- |
| The Mythical Man-Month | Frederick Brooks | accidental complexity, coordination drag |
| Code Complete | Steve McConnell | unclear control flow, weak naming, risky conditionals |
| Refactoring | Martin Fowler | duplication, divergent change, shotgun surgery |
| Clean Architecture | Robert C. Martin | dependency direction, policy/detail leakage |
| The Pragmatic Programmer | Andrew Hunt and David Thomas | hidden coupling, knowledge duplication |
| Domain-Driven Design | Eric Evans | distorted domain language, overloaded concepts |
| A Philosophy of Software Design | John Ousterhout | shallow modules, high cognitive load |
| Software Engineering at Google | Titus Winters, Tom Manshreck, and Hyrum Wright | sustainable change, dependency hygiene |
| Working Effectively with Legacy Code | Michael Feathers | missing test seams, legacy risk |
| xUnit Test Patterns | Gerard Meszaros | brittle tests, fixture bloat |
| The Art of Unit Testing | Roy Osherove | weak assertions, poor isolation |
| How Google Tests Software | James Whittaker, Jason Arbon, and Jeff Carollo | risk-based testing, confidence gaps |

Software engineering principles are timeless. AI-assisted teams need them more, not less, because code volume and change frequency are higher.

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

Full guide: [docs/health-dimensions.md](docs/health-dimensions.md).

## What It Looks Like

```text
Health Score: 74/100
Scope: current branch diff against origin/main
Mode: audit

[high] [Tier 3] [Module Depth / Architecture]
Checkout orchestration leaks payment, inventory, and email details

Symptom:
Checkout callers must understand payment capture order, inventory reservation rules, and email timing.

Source:
A Philosophy of Software Design by John Ousterhout — shallow modules.
Refactoring by Martin Fowler — divergent change.

Consequence:
A small fulfillment change can break payment or notification behavior.

Remedy:
Design a deeper CheckoutFlow interface that owns orchestration and exposes observable outcomes.

Verification:
Move tests to checkout outcomes. Keep payment, inventory, and email behind adapters.
```

More examples: [docs/gallery.md](docs/gallery.md).

## Installation

### One Prompt Install

Paste this into your coding agent terminal/session:

```text
Install the Improve Codebase Health plugin from https://github.com/Nairon-AI/improve-codebase-health into this repo.

Detect the current agent environment and install it the normal way for that agent:
- If Claude Code plugin commands are available, install it as a Claude Code plugin.
- If Codex plugin/skill install is available, install it through Codex.
- If this repo uses .agents/skills, install the bundled skill there.
- If this repo uses .claude/skills, install the bundled skill there.
- If no skill directory exists, create .agents/skills/improve-codebase-health.

Do not change product code. Preserve existing agent docs and unrelated files. After installing, verify the skill files exist, show the installed path, and tell me how to run /improve-codebase-health.
```

That is the recommended path: let the agent detect the environment and use the native install route.

### Claude Code Plugin

```text
/plugin marketplace add Nairon-AI/improve-codebase-health
/plugin install improve-codebase-health@improve-codebase-health-marketplace
```

### Local Installer

```bash
git clone https://github.com/Nairon-AI/improve-codebase-health.git
cd improve-codebase-health
./scripts/install.sh agents
```

Project-local install:

```bash
./scripts/install.sh agents --project
```

See [docs/getting-started.md](docs/getting-started.md) and [docs/SETUP.md](docs/SETUP.md).

### Platform Guide

| Environment | Preferred Install | Skill Location |
| --- | --- | --- |
| Claude Code | Plugin marketplace | Plugin-managed, or `.claude/skills` for repo-local |
| Codex | Agent-assisted plugin/skill install | `~/.codex/skills` or `.agents/skills` |
| Cursor / Copilot-style agents | Agent-assisted skill install | `.agents/skills` or tool-specific skill folder |
| Generic agent skill runner | Local installer | configured skills directory |
| Manual repo-local | Copy bundled skill | `.agents/skills/improve-codebase-health` |

## Usage

Run:

```text
/improve-codebase-health
```

No arguments means it asks for scope and mode.

Explicit examples:

```text
/improve-codebase-health --scope diff --mode audit
/improve-codebase-health --scope diff --mode safe-cleanup
/improve-codebase-health --scope since --since 5 --mode friday-steward
/improve-codebase-health --scope path --path packages/api --mode plan-refactor
```

Modes:

| Mode | Action |
| --- | --- |
| `audit` | Report only. |
| `safe-cleanup` | Apply Tier 1 fixes only. |
| `plan-refactor` | Produce design/refactor plan, no edits. |
| `friday-steward` | Audit scoped work, apply Tier 1 fixes, rank larger work. |

Full mode guide: [docs/modes.md](docs/modes.md).

### Slash Command

| Command | Action |
| --- | --- |
| `/improve-codebase-health` | Interactive scope and mode picker. |
| `/improve-codebase-health --scope diff --mode audit` | Review current branch changes only. |
| `/improve-codebase-health --scope diff --mode safe-cleanup` | Apply Tier 1 fixes only. |
| `/improve-codebase-health --scope since --since 5 --mode friday-steward` | Review recent work and rank follow-ups. |
| `/improve-codebase-health --scope repo --mode plan-refactor` | Whole-repo architecture/debt planning, no edits. |

## Configuration

Optional project config:

```yaml
version: 1
ignore:
  - "**/*.generated.*"
  - "**/vendor/**"
safety:
  allow_tier_1_autofix: true
  require_approval_for_tier_2: true
  require_design_for_tier_3: true
```

Copy [.improve-codebase-health.example.yaml](.improve-codebase-health.example.yaml) as a starting point.

## What Linters Miss

Improve Codebase Health does not replace ESLint, Pylint, typecheckers, or tests.

It catches slower problems:

- architecture drift
- shallow modules
- weak seams
- vague domain language
- tests that protect implementation trivia
- types that allow invalid states
- scattered changes across unrelated modules
- code that agents can plausibly misunderstand

## Comparison

| Capability | Improve Codebase Health | Linters / Formatters | Plain Agent Review |
| --- | :---: | :---: | :---: |
| Syntax/style feedback | Partial | Yes | Inconsistent |
| Type/test verification guidance | Yes | Partial | Inconsistent |
| Structured finding chain | Yes | No | Usually no |
| Book-grounded engineering principles | Yes | No | Usually implicit |
| Architecture drift detection | Yes | No | Inconsistent |
| Ambiguous naming/concept detection | Yes | No | Inconsistent |
| Safety tier before edits | Yes | No | Usually no |
| Scoped installable agent workflow | Yes | No | No |

It is not trying to be a stricter linter. It is trying to make architectural pain explicit enough for agents to work with safely.

## Review Modes At A Glance

| Mode | Primary Question | Output |
| --- | --- | --- |
| Audit | Is this scope safe to change? | Health score, findings, no edits. |
| Safe Cleanup | What can be improved with tiny blast radius? | Tier 1 patch plus verification. |
| Plan Refactor | What needs design before code changes? | Ranked Tier 2/3 plan. |
| Friday Steward | What should we clean after recent feature work? | Tier 1 cleanup plus follow-up backlog. |

## Configuration Options

| Setting | Purpose |
| --- | --- |
| `ignore` | Exclude generated, vendor, build, or migration files from analysis. |
| `focus` | Limit review to selected health dimensions. |
| `severity` | Override severity for project-specific norms. |
| `safety` | Control auto-fix permission and approval boundaries. |

## Project Structure

```text
improve-codebase-health/
├── .claude-plugin/              # Claude Code plugin metadata
├── .codex-plugin/               # Codex plugin metadata
├── commands/                    # Slash command wrapper
├── docs/                        # User-facing guides and examples
├── scripts/                     # Installer and validation
├── skills/
│   └── improve-codebase-health/
│       ├── SKILL.md             # Main agent workflow
│       └── references/          # Risk, ambiguity, architecture, safety guides
└── assets/
    └── logo.svg
```

## Development

```bash
npm run check
```

## License

[MIT](LICENSE)

---

<p align="center">
  <strong>Keep the codebase clear enough for humans and agents to change safely.</strong>
</p>
