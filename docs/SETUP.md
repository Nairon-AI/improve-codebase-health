# Setup

Improve Codebase Health is a **plugin package**. The actual review logic lives in an agent skill at `skills/improve-codebase-health/`, and the repo includes command/plugin metadata so supported agent environments can expose it as `/improve-codebase-health`.

## One Prompt Install

Paste this into your coding agent:

```text
Install the Improve Codebase Health plugin from https://github.com/Nairon-AI/improve-codebase-health for the current coding agent/repo.

Rules:
- Do not change product code.
- Do not overwrite unrelated agent docs, skills, commands, or config.
- Prefer the agent's native plugin/skill install mechanism.
- If native plugin install is unavailable, install the bundled skill from `skills/improve-codebase-health`.
- If an existing `improve-codebase-health` install exists, replace only that skill/plugin folder.
- Preserve and report any existing repo conventions you detect.

Detect and install in this order:
1. Claude Code: use plugin install if available:
   `/plugin marketplace add Nairon-AI/improve-codebase-health`
   `/plugin install improve-codebase-health@improve-codebase-health-marketplace`
   If slash plugin install cannot run from this context, install repo-local fallback to `.claude/skills/improve-codebase-health` and copy `commands/improve-codebase-health.md` to `.claude/commands/improve-codebase-health.md` if `.claude/commands` exists.
2. Codex: use the native skill/plugin installer if available. Otherwise install to `.agents/skills/improve-codebase-health` for repo-local use, or `~/.codex/skills/improve-codebase-health` for global use if the user asked for global.
3. Cursor / Copilot / generic Agent Skills: install to the repo's existing skill folder if present: `.agents/skills`, `.github/skills`, `.cursor/skills`, or tool-specific equivalent. If none exists, create `.agents/skills/improve-codebase-health`.
4. Gemini / Windsurf / OpenCode / other agents: install to the agent's documented skill directory when known; otherwise install to `.agents/skills/improve-codebase-health` as the portable fallback.

Verification:
- Confirm `SKILL.md` exists in the installed `improve-codebase-health` folder.
- Confirm the `references/` files were copied.
- Confirm the command is available as `/improve-codebase-health` when the agent supports slash commands, or explain the agent-specific invocation if not.
- Show installed paths, install method used, and any warnings.
```

## Claude Code Plugin Install

```text
/plugin marketplace add Nairon-AI/improve-codebase-health
/plugin install improve-codebase-health@improve-codebase-health-marketplace
```

The plugin packages the `improve-codebase-health` skill plus the slash command wrapper.

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
