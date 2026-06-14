# Health Dimensions

The skill reviews code through eight dimensions grounded in classic software engineering sources.

| Dimension | Question | Common Signals |
| --- | --- | --- |
| Change Safety | Can one focused change be made safely? | shotgun surgery, hidden coupling, mixed responsibilities |
| Agent Navigability | Can an agent find the right concept and tests? | unclear entry points, stale docs, scattered patterns |
| Domain Clarity / Ambiguity | Could names cause plausible wrong edits? | overloaded terms, inconsistent concepts, vague tables |
| Type Safety | Do types encode invariants? | `any`, broad strings, nullable states, weak records |
| Test Confidence | Would tests catch likely bugs? | implementation assertions, mock abuse, coverage illusion |
| Module Depth / Architecture | Do modules hide complexity behind useful interfaces? | shallow wrappers, weak seams, leaky adapters |
| Dead Code / Duplication / Slop | Is the repo carrying stale weight? | unused code, duplicate decisions, obsolete comments |
| Dependency Direction | Do dependencies flow predictably? | cycles, domain importing infrastructure, inverted ownership |

## Finding Shape

Every finding must use:

```text
Symptom -> Source -> Consequence -> Remedy
```

No evidence, no finding.

## Book Grounding

The skill pulls principles from:

- The Mythical Man-Month by Frederick Brooks
- Code Complete by Steve McConnell
- Refactoring by Martin Fowler
- Clean Architecture by Robert C. Martin
- The Pragmatic Programmer by Andrew Hunt and David Thomas
- Domain-Driven Design by Eric Evans
- A Philosophy of Software Design by John Ousterhout
- Software Engineering at Google by Titus Winters, Tom Manshreck, and Hyrum Wright
- Working Effectively with Legacy Code by Michael Feathers
- xUnit Test Patterns by Gerard Meszaros
- The Art of Unit Testing by Roy Osherove
- How Google Tests Software by James Whittaker, Jason Arbon, and Jeff Carollo
