# Getting Started

Improve Codebase Health ships as a plugin package with one bundled agent skill:

```text
skills/improve-codebase-health/SKILL.md
```

The plugin metadata exposes the skill as `/improve-codebase-health` where supported. The skill can also be copied into any agent skill folder.

## Install

### One Prompt Install

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

### Claude Code Plugin

```text
/plugin marketplace add Nairon-AI/improve-codebase-health
/plugin install improve-codebase-health@improve-codebase-health-marketplace
```

### Local Installer

From a clone:

```bash
./scripts/install.sh agents
./scripts/install.sh codex
./scripts/install.sh claude
./scripts/install.sh cursor
./scripts/install.sh copilot
./scripts/install.sh gemini
./scripts/install.sh windsurf
./scripts/install.sh opencode
```

Install into the current repo instead of global config:

```bash
./scripts/install.sh agents --project
```

## Platform Table

| Environment | Preferred Install | Skill Location |
| --- | --- | --- |
| Claude Code | Plugin marketplace | Plugin-managed, or `.claude/skills` |
| Codex | Agent-assisted plugin/skill install | `~/.codex/skills` or `.agents/skills` |
| Cursor / Copilot-style agents | Agent-assisted skill install | `.agents/skills` or tool-specific skill folder |
| Generic agent skill runner | Local installer | configured skills directory |
| Manual repo-local | Copy bundled skill | `.agents/skills/improve-codebase-health` |

## Run

```text
/improve-codebase-health
```

No arguments means the agent asks for scope and mode.

Examples:

```text
/improve-codebase-health --scope diff --mode audit
/improve-codebase-health --scope since --since 5 --mode friday-steward
/improve-codebase-health --scope path --path packages/api --mode safe-cleanup
/improve-codebase-health --scope repo --mode plan-refactor
```

## Layout

```text
improve-codebase-health/
├── .claude-plugin/
├── .codex-plugin/
├── commands/
├── docs/
├── scripts/
├── skills/
│   └── improve-codebase-health/
│       ├── SKILL.md
│       └── references/
└── assets/
```

## Verify

Run:

```bash
npm run check
```

Then invoke:

```text
/improve-codebase-health --scope diff --mode audit
```
