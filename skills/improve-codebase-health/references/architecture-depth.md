# Architecture Depth

Use this when a finding touches module shape, interface design, seams, dependency inversion, testability, or architectural refactoring.

## Vocabulary

Use these terms consistently in architecture findings:

- **Module** - anything with an interface and implementation: function, class, package, app slice, job, or service.
- **Interface** - everything callers must know to use the module correctly: types, invariants, ordering, errors, config, performance. Not just a TypeScript `interface`.
- **Implementation** - code inside the module.
- **Depth** - leverage at the interface. A deep module hides meaningful behavior behind a small, coherent interface. A shallow module makes callers learn nearly as much as the implementation.
- **Seam** - where behavior can be changed without editing in place; the location of an interface.
- **Adapter** - concrete implementation satisfying an interface at a seam.
- **Leverage** - what callers get: more behavior per concept learned.
- **Locality** - what maintainers get: change, bugs, knowledge, and tests concentrated in one place.

Prefer `seam` over overloaded words like `boundary` when the topic is testability or replaceability.

## Core Tests

### Deletion Test

Imagine deleting the module.

- If complexity vanishes, it was likely pass-through structure.
- If complexity reappears across many callers, the module was earning its keep.

Use this before recommending merges, deletes, or deeper modules.

### Interface Test Surface

Callers and tests should cross the same interface. If tests need to reach past the interface, the module is probably the wrong shape or the wrong behavior is exposed.

### Adapter Reality Check

One adapter means a hypothetical seam. Two adapters means a real seam.

Do not recommend a new port/seam unless variation is real, usually production plus test adapter or multiple production adapters.

## Deepening Candidates

Look for:

- understanding one concept requires bouncing through many shallow modules
- pure functions extracted only for testability while real bugs live in orchestration
- pass-through wrappers that add names but no leverage
- tightly coupled modules leaking implementation details
- code hard to test through its current interface
- duplicated decisions caused by weak locality

For each candidate, report:

- **Files** - modules involved
- **Current shape** - why callers must know too much
- **Deepened shape** - what behavior moves behind one clearer interface
- **Leverage** - what callers gain
- **Locality** - what changes/tests become concentrated
- **Verification** - what tests move to the new interface

## Dependency Categories

Classify dependencies before recommending a refactor:

1. **In-process** - pure computation or in-memory state. Usually safe to deepen and test directly.
2. **Local-substitutable** - has local stand-ins such as in-memory filesystem or local database. Test the deep module with the stand-in.
3. **Remote but owned** - internal service across network. Define a port at the seam; production uses HTTP/gRPC/queue adapter, tests use in-memory adapter.
4. **True external** - third-party service. Inject a port; tests use a mock/fake adapter.

## Interface Exploration

For Tier 3 architecture changes, do not jump to the first interface.

Use a design-it-twice pass:

1. Frame constraints:
   - current coupling
   - domain vocabulary
   - dependency category
   - invariants and error modes
   - what tests must survive
2. Generate 3 different interface shapes:
   - minimal interface, 1-3 entry points
   - flexible interface for extension
   - common-case-first interface
   - ports/adapters shape when cross-seam dependency exists
3. Compare by:
   - depth
   - locality
   - seam placement
   - test surface
   - migration cost
4. Recommend one or a hybrid.

## Output Add-on

For architecture findings, add:

```text
Architecture lens:
- Module:
- Interface:
- Seam:
- Depth issue:
- Deletion test:
- Dependency category:
- Test surface:
```
