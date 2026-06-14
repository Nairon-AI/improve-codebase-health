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
Install the Improve Codebase Health plugin from https://github.com/Nairon-AI/improve-codebase-health into this repo.

Detect the current agent environment and install it the normal way for that agent:
- If Claude Code plugin commands are available, install it as a Claude Code plugin.
- If Codex plugin/skill install is available, install it through Codex.
- If this repo uses .agents/skills, install the bundled skill there.
- If this repo uses .claude/skills, install the bundled skill there.
- If no skill directory exists, create .agents/skills/improve-codebase-health.

Do not change product code. Preserve existing agent docs and unrelated files. After installing, verify the skill files exist, show the installed path, and tell me how to run /improve-codebase-health.
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
