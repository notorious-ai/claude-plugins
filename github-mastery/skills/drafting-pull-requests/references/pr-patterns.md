# PR Patterns by Type

Concrete examples of well-structured pull requests for common scenarios. The description focuses on context the diff cannot convey: intent, breaking changes, migration notes, and follow-up steps.

## Bug Fix PR

Short and focused, explaining root cause and fix.

**Title**: Fix race condition in cache invalidation

**Description**:
```
Users reported stale data appearing intermittently after updates. The root cause was a race between cache invalidation and refresh that could interleave, allowing stale values to be restored.

The fix adds a mutex around the invalidate-refresh sequence, ensuring atomicity.

Fixes #456
```

## Feature PR

Explains the value delivered and why it matters.

**Title**: Surface nodes affected by mutations for analysis

**Description**:
```
The Targets function enables important pre-execution capabilities like locking strategy, permission validation, and conflict detection between concurrent compilations.

At its core, the function iterates over all unique nodes that would be affected by compilation steps, allowing callers to analyze impact before execution.
```

## Refactoring PR

Emphasizes no behavior change while explaining motivation.

**Title**: Extract payment processing into dedicated service

**Description**:
```
Prepares the codebase for upcoming subscription billing work by improving separation of concerns. No behavior changes - pure refactoring.

Payment logic moves from OrderController to a dedicated PaymentService, making the code more testable and the billing domain easier to extend.
```

## Simple Maintenance PR

When the change is self-explanatory, keep it brief.

**Title**: Replace personal CODEOWNERS entry with the maintainers team

**Description**:
```
Replacing my personal CODEOWNERS entry with @onelayerhq/maintainers so ownership sits with the team rather than a single person, while leaving all other coverage unchanged.
```

## Framework/Infrastructure PR

Establishes context for why the infrastructure matters.

**Title**: Establish a framework to ease testing digital-twin graphs

**Description**:
```
I set out to fix some known issues with the digital-twins library. The necessary changes would have been very large. Moreover, we found those issues by using the digital-twins library to build digital-twin services. As a way to avoid "simulating" use-cases, and to reuse the knowledge of problems we have already found by experimenting, I find great benefit in establishing a framework to test digital-twin graphs.

At its core, the graphtest package exposes the means to define a suite of interesting node values and then run them through the graph. We've identified most of our issues by actually writing nodes to the graph and then reading them back out to detect changes.

Also, you'll find some commits that refresh the code up to our latest knowledge and standards.
```

## Security/Compliance PR

Clear about the motivation and what's resolved.

**Title**: Resolve critical security alerts in sub-modules

**Description**:
```
This resolves critical security alerts about vulnerabilities in required modules:
- go.onelayer.dev/exp
- go.onelayer.dev/tools/vanity-import

Now that we are SOC2 compliant, it is best to actually address critical vulnerabilities.
```

## CI/Tooling PR with Proof

Explains the problem and links to evidence.

**Title**: Fix newline character at the end of integration workflow runs

**Description**:
```
This adds a single character causing the run-name YAML definition to trim the suffix newline character. The "chomping indicator" is explained with more details at <https://yaml-multiline.info/>.

Along the way, I've discovered and fixed a bug with tagging edge on publish-to-ghcr.yml.

Proof: <https://github.com/OneLayerHQ/atmosphere/pull/234#issuecomment-2032843778>
```

## Follow-up PR

References the prior work and explains the incremental step.

**Title**: Remove exp from Dependabot's config

**Description**:
```
The exp/ directory used to contain a module that is now hosted at onelayerhq/go-exp. This follows through on previous work (#332) to remove it from this repository by removing all traces of it from Dependabot's configuration.
```

## PR with Breaking Changes

Highlights what breaks and how to migrate.

**Title**: Support unregistered node types between neo4j graph revisions

**Description**:
```
Usually when we upgrade our system, we add new node types to the graph. This prevents us from downgrading or reverting because the Neo4j engine panics when it encounters node types "from the future".

The new flag allows the engine to expose these alien nodes as raw, which allows to use them opaquely. That is, they still have a content address and programs may access their Neo4j representation.

## Migration

Callers that need backward compatibility should enable AlienMode when connecting to graphs that may contain newer node types.
```

## PR with Post-Merge Follow-up

Notes what needs to happen after merge.

**Title**: Update automatic release-notes

**Description**:
```
This changes the labels that we use to highlight several categories of changes to the product releases.

- Fix how we attribute Dependabot changes to it
- Separate Visibility and Segmentation changes from the broad Features category
- Rename domain/ labels to start with product/ instead

The following tasks are important to tidy after merge:

- [ ] Rename labels on GitHub
- [ ] Port how-to-use-labels.md changes to onelayerhq/docs
```
