# Dependency adoption is its own commit

When the work introduces a new third-party dependency — a Go module, npm package, Cargo crate, Python distribution, system tool — the decision to depend on it deserves its own commit. The commit body documents the alternatives considered and the reasoning behind the choice.

## Plan entry

A feature that needs structured logging might plan as:

```
1. Adopt slog/zerolog/zap as the structured logging dependency
   Add the chosen module to go.mod / package.json / Cargo.toml with
   no callers yet. The commit body lists the top alternatives that
   were evaluated, the criteria that distinguished them (allocation
   profile, API ergonomics, ecosystem fit, maintenance posture),
   and why this choice won. Lockfile updates land in this commit
   too.

2. Replace fmt-style logging in pkg/server
   Migrate the server package's existing log.Printf calls to the
   new logger. The diff is mechanical; the value is that the new
   dependency now has a real caller and the migration's first
   shape is visible.

3. Replace fmt-style logging in pkg/worker
   Same migration for the worker package, separated because the
   worker's logging contract differs (structured fields for job
   IDs, retry counts) and is worth reviewing on its own.
```

## What this demonstrates

The atomic facet, in its decision-layering form. Commit 1 captures a single decision — which structured logger to depend on — and its body is the durable record of why. Six months later, when somebody asks "why did we pick this and not the other one?", `git log` answers the question precisely.

Isolating the dependency also makes the decision revertable. If the choice proves wrong, the revert affects only commit 1 (and any later commits that consume the dependency, which can be re-targeted). A reviewer evaluating commit 1 alone decides the dependency question without their attention being split across migration noise.

## What the commit body should contain

The body of the dependency-adoption commit is the WHY-EXTRINSIC of the decision:

- The top alternatives considered, named explicitly.
- The criteria that distinguished them.
- Which criterion won this choice, and which trade-offs were accepted.
- Any non-obvious constraints (licence, transitive dependencies, build-time impact).

The code's own comments (the WHY-INTRINSIC) explain how the chosen library is used. The commit body explains why it is the chosen library.
