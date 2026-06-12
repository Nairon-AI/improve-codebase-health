# Scope And Modes

Resolve scope before scanning. If no arguments are provided, ask at most two questions.

## Scope Options

### Current Branch Diff

Use:

```bash
git diff --name-only origin/main...
```

Best for Friday hardening after a feature branch.

### Last N Days

Use Git history to identify changed files:

```bash
git log --since="<N> days ago" --name-only --pretty=format:
```

Deduplicate file paths. Ignore deleted files unless relevant to debt cleanup.

### Path / Package

Use when user names a surface:

```bash
rg --files <path>
```

Read nearest README/SKILLS before judging.

### PR / Issue

Use GitHub context when available:

- PR diff
- review comments
- CI failures
- linked issue context

Do not push without explicit permission.

### Feature Area

Map by search first:

- route names
- domain terms
- components/modules
- tests
- docs

Present discovered scope before editing.

### Whole Repo

Use only when user chooses it or passes `--scope repo`. Whole-repo audits are report-heavy and should not auto-edit outside Tier 1.

## Mode Matrix

| Mode | Edits? | Best For |
| --- | --- | --- |
| `audit` | No | Understand risk |
| `safe-cleanup` | Tier 1 only | Low-risk cleanup |
| `plan-refactor` | No | Tier 2/3 design |
| `friday-steward` | Tier 1 + ranked candidates | Weekly health habit |

## No-Arg Prompt

Question 1:

```text
What scope should I inspect?
- Current branch diff
- Last N days
- Path/package
- PR/issue
- Feature area
- Whole repo
```

Question 2:

```text
What should I do?
- Audit only
- Safe cleanup
- Plan refactor
- Friday steward
```

If `Last N days`, ask for days as the only follow-up.
