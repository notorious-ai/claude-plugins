# Anti-pattern: grouping by abstraction layer

The temptation arises when a feature introduces an interface and its implementations together. The agent thinks: "Let me first define all the contracts, then fill in the implementations." Sounds disciplined — and produces commits nobody can review.

## The anti-pattern

A feature that introduces pluggable storage backends gets split as:

```
1. Define the Storage interface and its method contracts
   Land the Storage interface with Get, Put, Delete, List, and the
   accompanying Result and Error types. No implementations land in
   this commit.

2. Implement the InMemoryStorage backend
   Land the in-memory implementation that satisfies the Storage
   interface from commit 1.

3. Implement the SQLiteStorage backend
   Land the SQLite-backed implementation that satisfies the same
   interface.
```

## Why this is wrong

Violates the atomic facet, and pressures the incremental one:

- **Atomic.** Commit 1's interface delivers no value on its own. A reviewer cannot evaluate whether the contract is right because no implementation has tested it against real constraints and no caller exercises it. The shape of an interface is best judged by its first consumer.
- **Incremental.** The interface as drafted in commit 1 will almost certainly need revision once the first real implementation runs into a constraint that was not anticipated. Locking it in before any implementation exists forces either a follow-up "amend the interface" commit (noise) or implementations bent to fit an awkward contract.

The split is syntactic — by abstraction layer in the design. The value, a working storage backend with an interface that proves itself, is fractured across commits whose ordering enforces unhelpful constraints.

## Better

Pair each implementation with the interface shape it justifies:

```
1. Land InMemoryStorage with the Storage interface it satisfies
   The interface emerges from a concrete implementation that has
   at least one real caller. Get, Put, Delete, and List are
   defined as the minimum set the in-memory backend needs to be
   useful for testing. A reviewer evaluates the interface against
   a working thing, not against speculation.

2. Land SQLiteStorage and refine the Storage interface where needed
   Adding a persistent backend forces decisions the in-memory case
   did not: connection management, transactional semantics,
   pagination shape for List. If the interface needs new methods
   or refined signatures, that revision lands here, justified by
   the SQLite implementation that demands it.
```

The interface still exists across both commits — but its shape is grounded in a working implementation at every step, not in upfront speculation.
