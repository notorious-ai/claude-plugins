# Clean a contaminated working tree as the first commit

When work begins in a working tree that is already dirty — `go.mod` has drift from a prior partial change, `go.sum` carries unused entries, generated code is stale, the package fails `gofmt` — the first commit of the series is the cleanup. The contamination does not get to spill into diffs that should be scoped to the feature.

## Plan entry

A feature added to a slightly-stale working tree might plan as:

```
1. go.mod: tidy
   Run `go mod tidy` and stage the resulting go.mod and go.sum
   diff. The commit's only purpose is to bring the module manifest
   to a clean baseline before feature work begins. No new
   dependencies, no source changes. Body notes the drift removed
   when non-obvious (e.g., "removes unused require lines left over
   from a previously reverted dependency spike").

2. [first feature commit]
   Now the feature commit's diff is scoped to the feature itself.
```

When the contamination is from a different tool, use a target that names what was cleaned:

- `gofmt: format the package` for accumulated gofmt drift
- `generate: refresh generated files` for stale `go generate` output
- `golangci-lint: apply auto-fixes` when the lint config changed and auto-fixable findings accumulated

Each is a single mechanical commit, ahead of the feature work. Each commit's diff is exclusively that tool's output.

## What this demonstrates

The atomic facet. If hygiene work is mixed with the first feature commit, that commit's diff carries two unrelated concerns: the feature itself and a cleanup that has nothing to do with the feature. A reviewer cannot evaluate either in isolation, and the commit body has to either omit the cleanup (misleading) or list both (diluting the feature's rationale).

It also keeps the contamination from compounding. A `go mod tidy` deferred to mid-series will pick up not only the original drift but every transitive change the intervening commits introduced — the resulting diff becomes impossible to attribute.

## How to detect contamination before planning

Before drafting the sequence, inspect the starting state:

```bash
git status
go mod tidy && git diff --stat go.mod go.sum
gofmt -l .
go vet ./...
```

If any of these produces a non-empty result before the work starts, the contamination is real and a cleanup commit belongs at the head of the plan. If they are all clean, skip directly to the feature commits.
