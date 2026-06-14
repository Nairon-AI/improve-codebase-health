# Getting Started

Improve Codebase Health ships as a plugin package with one bundled agent skill:

```text
skills/improve-codebase-health/SKILL.md
```

The plugin metadata exposes the skill as `/improve-codebase-health` where supported. The skill can also be copied into any agent skill folder.

## Install

### Claude Code Plugin

```text
/plugin marketplace add Nairon-AI/improve-codebase-health
/plugin install improve-codebase-health@improve-codebase-health-marketplace
```

### Codex / Agent Prompt

```text
Install the Improve Codebase Health plugin from Nairon-AI/improve-codebase-health
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
