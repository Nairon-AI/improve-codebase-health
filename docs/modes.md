# Modes

Use one command with explicit mode selection.

| Mode | Edits | Use When |
| --- | --- | --- |
| `audit` | No | You want a codebase health report only. |
| `safe-cleanup` | Tier 1 only | You want boring low-risk cleanup. |
| `plan-refactor` | No | The fix may touch architecture, public contracts, or design. |
| `friday-steward` | Tier 1 plus ranked plan | You want regular codebase stewardship after feature work. |

Run it any time. Friday is a ritual suggestion, not a limitation.

## Scopes

| Scope | Meaning |
| --- | --- |
| `diff` | Current branch against `origin/main`. |
| `since` | Files changed in the last N days or since a date. |
| `path` | One package, app, folder, or file group. |
| `feature` | Agent discovers files by route/domain/search terms. |
| `pr` / `issue` | Use GitHub context when available. |
| `repo` | Whole repo. Best as audit or plan mode. |

## Safety Contract

The skill classifies each finding:

```text
Tier 0: report only
Tier 1: auto-safe cleanup
Tier 2: ask before changing
Tier 3: design required
```

Architecture changes, exported renames, database changes, auth/payment/permission boundaries, and persistence changes are never Tier 1.
