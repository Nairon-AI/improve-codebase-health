# Setup

Copy `skills/improve-codebase-health/` into the agent skill directory used by your environment.

Invoke:

```text
/improve-codebase-health
```

For non-interactive use:

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
