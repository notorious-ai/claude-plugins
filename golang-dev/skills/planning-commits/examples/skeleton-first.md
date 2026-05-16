# Skeleton-first package or module introduction

When starting a new package, module, command, or significant subsystem, the first commit lays the ground: package documentation, goal, user story, and optionally no-op functions or type sketches with intent. It contains no production implementation — those land in subsequent commits as each piece is designed.

## Plan entry

```
1. Introduce the package with its goal and user story
   Land doc.go (or the equivalent) describing what this package will
   do, who needs it, and the constraints driving its design. Include
   any type sketches or no-op signatures that name the eventual
   surface, but no implementations. The commit must not reference
   symbols or behaviours that do not yet exist on this branch.
```

## What this demonstrates

The incremental facet. The skeleton commit names the goal without forward-referencing implementations that have not yet been written. A reader of `git blame` for the package doc sees the original intent — not a retrospective summary written after the package was already complete.

It also keeps the first commit reviewable on its own terms. A reviewer can confirm the design intent before any implementation discussion begins, which surfaces disagreements early when the cost of changing direction is still low.
