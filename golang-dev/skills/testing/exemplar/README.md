# Exemplar — annotated Go-team snippets

Verbatim test code from the Go standard library, chosen because the Go team's
practice is the source of this skill's doctrine: you imitate canon, and nothing
bundled is canon of its own. Nothing here is agent-written or eval-derived; the
only code allowed in this folder is attributed snippets from the Go team's
packages (standard library and golang.org/x). The annotations are ours and say
what to imitate and why.

Each snippet sits in a `<sample id archetypes source>` element carrying
one `<highlight archetype="...">` per archetype and a `<note>` for the general
lesson; an elision inside a code block is always marked. WRITING tests:
match your package's symbol clusters from `go doc -all` to the archetypes
below and read ONLY the matched samples; `file#id` names the
`<sample id="id">` element in `file.md`. REVIEWING tests: read every file
end to end; the whole corpus is the grading sense.

## Archetypes

- transform — top-level pure funcs mapping inputs to outputs, often a family sharing one signature shape (`Index`/`LastIndex`/`IndexAny`). → strings#case-table, strings#family-shared-runner, strings#bloop-benchmark, hash-maphash#property-claim-names, hash-maphash#one-invariant-many-paths
- lifecycle — a constructor returning `*T` that owns background work (pools, workers, expiry timers) and must be shut down; the shutdown wears many signature shapes (`Close() error`, `Stop()`, `Shutdown(context.Context) error`, names inconsistent across packages), so recognize it by language-reasoning over the docs and signatures — they are more than enough for the vast majority of cases; never peek at code bodies to classify. → database-sql#matrix-runner, database-sql#wait-before-read, database-sql#bubble-sleep-expiry
- stream — incremental `Read`/`Write`/`WriteByte` methods or io interfaces in signatures, begging tiny bespoke fakes. → io#one-behavior-fakes, io#regression-to-property, hash-maphash#one-invariant-many-paths
- contract-conformance — a type documented to implement a published interface (`fs.FS`, `io.Reader`) whose owner ships a verifier. → archive-zip#verifier-shape, archive-zip#conformance-call
- harness — a case corpus or variant matrix wanting one composition point: a shared runner func, one expectation language. → go-parser#harness-header-doc, go-parser#error-marker-language, go-parser#fixture-inline-expectations, database-sql#matrix-runner, cmd-gofmt#corpus-glob-idempotence, strings#family-shared-runner, archive-zip#verifier-shape
- golden-fixture — outputs too large to inline: expected bytes live in testdata beside their inputs, refreshed by an `-update` flag. → cmd-gofmt#update-flag-diff, cmd-gofmt#corpus-glob-idempotence, cmd-gofmt#flag-in-fixture, go-parser#fixture-inline-expectations
- async-assert — docs promising behavior after goroutines settle or time passes (expiry, delivery, draining). → database-sql#wait-before-read, database-sql#bubble-sleep-expiry
- example — the mandatory runnable Example and its pkgsite voice; this archetype matches EVERY package. → encoding-json#example-user-voice, encoding-json#example-self-naming-violation, strings#example-edge-case

## Finding samples

Whole-file Read of a matched file is the default (every file is small).
For cross-file queries, from this directory (invariants: tags start at
column 0; `id` is the first attribute; per-file <sample> open/close
counts always match):

```bash
awk '/^<sample id="case-table"/,/^<\/sample>/' strings.md          # one sample by id
grep -o '^<sample id="[^"]*"' strings.md | cut -d'"' -f2           # ids in a file
grep -El '^<sample .*archetypes="([^"]*,)?golden-fixture(,[^"]*)?"' *.md  # files serving an archetype
awk '/^<highlight archetype="stream"/,/<\/highlight>/{print FILENAME": "$0}' *.md  # highlights by archetype
```
