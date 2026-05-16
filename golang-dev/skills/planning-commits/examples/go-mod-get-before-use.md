# go.mod: get one module per commit, ahead of the first caller

When a Go changeset introduces new module dependencies, each `go get` lands as its own commit ahead of the commit that consumes it. The diff is scoped to exactly that one module — `go.mod` adds one top-level `require`, `go.sum` carries the corresponding entries, and nothing else.

## Plan entry

A Go feature that needs both an OpenTelemetry tracer and its OTLP exporter might plan as:

```
1. go.mod: get go.opentelemetry.io/otel
   Run `go get go.opentelemetry.io/otel@<version>`, then `go mod
   tidy`, then stage the resulting go.mod and go.sum diff. The
   commit body lists the alternatives evaluated (OpenCensus,
   vendor-specific SDKs) and why otel won. No production caller
   imports it yet.

2. go.mod: get go.opentelemetry.io/otel/exporters/otlp
   Add the OTLP exporter the same way. Separate commit because the
   exporter is a distinct decision: stdout, otlp, and a vendor SDK
   were all candidates. Body documents why otlp won.

3. Wire tracing into the request path
   First commit where both modules are actually imported. Now the
   feature commit's diff is exclusively the production code that
   uses the dependencies adopted in commits 1 and 2.
```

## What this demonstrates

The atomic facet, specialised to Go module management. Each `go.mod: get` commit is independently revertable: if the OTLP exporter choice proves wrong, the revert of commit 2 leaves commit 1's otel adoption intact and the feature work in commit 3 can be retargeted at a different exporter.

This is the Go-flavoured form of the general dependency-adoption pattern (see `examples/dependency-adoption-isolated.md`), with the additional rule that one `go get` invocation introduces exactly one top-level require.

## Why one module per commit

A single `go get a/b a/c a/d` would land three require entries in one commit. Each was a different decision evaluated against its own alternatives, but the decision context is now smeared across all three. Reverting one rolls back all three.

## Why `go mod tidy` before staging

Running `go mod tidy` before staging ensures the commit's `go.sum` diff is exactly what the new module needs — no transitive churn from earlier drift in the working tree, no leftover `require` entries from previous spike branches. If `go mod tidy` produces a diff for modules other than the one just added, that diff belongs in a separate cleanup commit ahead of the series (see `examples/go-mod-tidy-first.md`).

The test: `git diff --cached --stat` should show only `go.mod` and `go.sum` modified, and the `go.mod` portion should contain exactly one new top-level require line.
