# Setup

Improve Codebase Health is a **plugin package**. The actual review logic lives in an agent skill at `skills/improve-codebase-health/`, and the repo includes command/plugin metadata so supported agent environments can expose it as `/improve-codebase-health`.

## Claude Code Plugin Install

```text
/plugin marketplace add Nairon-AI/improve-codebase-health
/plugin install improve-codebase-health@improve-codebase-health-marketplace
```

The plugin packages the `improve-codebase-health` skill plus the slash command wrapper.

## Codex / Repo-aware Agent Install

Ask the agent:

```text
Install the Improve Codebase Health plugin from Nairon-AI/improve-codebase-health
```

## Manual Install In One Product Repo

Run from this repo:

```bash
target=/path/to/product-repo
mkdir -p "$target/.agents/skills"
cp -R skills/improve-codebase-health "$target/.agents/skills/improve-codebase-health"
```

For Claude Code style repos:

```bash
target=/path/to/product-repo
mkdir -p "$target/.claude/skills"
cp -R skills/improve-codebase-health "$target/.claude/skills/improve-codebase-health"
```

## Verify Install

From the target repo, invoke:

```text
/improve-codebase-health
```

Expected first behavior: the agent asks for scope and mode.

For non-interactive verification:

```text
/improve-codebase-health --scope diff --mode audit
```

## Recommended First Run

From a product repo:

```text
/improve-codebase-health --scope diff --mode audit
```

Review the report first. Then run:

```text
/improve-codebase-health --scope diff --mode safe-cleanup
```

Only Tier 1 fixes should be applied automatically.

## What To Expect

The skill should:

- read repo docs before judging code
- resolve scope before scanning
- score health dimensions
- classify findings by Tier 0-3
- use architecture-depth rules for module/interface/seam findings
- auto-edit only Tier 1 in safe cleanup modes
- run repo-native type checks and narrow tests for changed surfaces

It should not:

- silently change public APIs
- rename database tables or columns automatically
- touch auth, payment, permission, or production-data boundaries as safe cleanup
- treat subjective naming preference as ambiguity
