# Harnesses and testing packages

Load when several implementations or packages need the same scenarios, or
when designing a helper testing package. The directives here are learned
from the Go team's own practice: net/http/httptest for harnesses;
testing/fstest, testing/iotest, and testing/slogtest for verifier-and-fake
pairs; x/tools' analysistest for the applicative kind.

## When a package earns one

A module's applicative layer earns a bespoke helper testing package, one per
layer, orchestrating scenarios that respect real user workflows. Several
implementations of one interface earn a conformance suite that each
implementation runs from its own tests. Export the harness when third
parties implement the interface, as httptest and analysistest do; keep it
internal when only this module's tests consume it, the internal/nettest
posture. The threshold is the same line helpers cross: when test helpers
require tests themselves, they have become a testing package, and a
harness is itself tested, its self-test doubling as usage documentation.

## API shape

One exported entry point, one line of glue, because a consumer's whole
certification should fit in one test: slogtest.Run(t, newHandler, result)
and analysistest.Run(t, dir, analyzer) each take the testing handle once
and own everything after it. The entry point opens with t.Helper(),
registers teardown with t.Cleanup, converts panics to failures, and routes
internal logs to t.Logf, so output lands in the consumer's run at the
consumer's frame. The verifier form takes no *testing.T at all:
fstest.TestFS(fsys, expected...) error joins every violation with
errors.Join, leaving the caller to decide what is fatal. Ship the verifier
with a fake in the same package (fstest.TestFS beside fstest.MapFS),
because fakes verify consumers while verifiers verify producers. Probe
optional capabilities by type assertion and check them only when present,
so richer implementations owe more without minimal ones failing.

Conformance cases replay a user's workflow rather than pin symbols one by
one, because the contract lives in sequences: iotest.TestReader drives a
reader through the read, seek, and reread patterns real callers perform,
and fstest.TestFS walks and reopens the whole tree the way consuming code
does. Failures surface in the consumer's test run while the expectation
lives in the harness's source, so route the reader: analysistest reports
every unmatched expectation at its testdata file and line.

## Discipline

Doc-comment the deliberate non-features and the scope, the way httptest
documents what must not change after Start, so consumers know what remains
theirs to configure and to test: the harness owns the shared contract
only, and implementations test what is specific to their backend. Harness
defaults mirror production (httptest.Server is the real net/http server on
a real socket); a consumer depending on customization beyond the default
depends on a deployment detail that may break in production too. Verifiers
only tighten, because a tightened verifier failing a lagging
implementation is the flagged breaking change; fakes only grow richer; an
exported harness field is never repurposed, deprecate in place and add
beside it. A human escape hatch costs little and pays off: a flag that
keeps the failed environment alive for manual poking serves the debugging
human, not just CI.

## The derivation transfers

go-digitaltwin's enginetest demonstrates these directives in a new world;
it is not a source of them. Following the canon produced the same shapes.
The consumer contract is one line of glue, enginetest.Run(t, engine,
engine), in the engine's own test. Checks are plain functions returning a
problem string, and only Run touches *testing.T. Because failures surface
in the engine author's run while cases live in the harness's source, every
case captures its file:line via runtime.Caller and Run logs "Read the
source for test-case %v at %v". Altitude splits the canon way: the
exported conformance suite owns the interface contract while
internal/dbtest, pure infrastructure, stays internal. None of these are
rules; each is what the directives above yield when derived afresh. Every
such package is a whole world; the intent is the same. Learn from the Go
team's practice, and read enginetest to see the derivation done.
