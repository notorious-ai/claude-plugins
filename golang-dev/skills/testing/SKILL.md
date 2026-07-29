---
name: testing
description: >-
  Sets the maintainer's standard for committed Go tests (_test.go): what
  earns a commit, how a suite is shaped, named, and commented, and how to
  review one. Carries the golden hierarchy of contract authority,
  go-doc-first design and review, annotated Go-team snippets to imitate,
  and one reference file per scenario.
when_to_use: >-
  Use whenever Go _test.go files are the work: writing or adding tests for
  a package or a single symbol; reviewing, consolidating, or judging an
  existing suite ("these tests smell", "what would a reviewer say");
  turning trivial tests into runnable examples for pkgsite; building a
  conformance harness so other implementations can prove they satisfy an
  interface; shaping a new package's API so it stays testable before the
  code exists; rescuing a test that flakes or resists being written. Load
  it after writing or changing any Go code, since committed tests are part
  of done: do not wait for the word "test". Not for non-Go test
  frameworks, godoc-only tasks, go vet or CI tooling failures, fuzz-crash
  debugging, or test-plan process documents.
allowed-tools: Bash(go doc:*) Bash(go test:*) Bash(go vet:*) Bash(gofmt -l:*) Bash(gofmt -d:*)
---

# Committed Go Tests

Imitation is the method, split by role. The `exemplar/` files are annotated
verbatim snippets from the Go team's own packages; imitate them, because
canon is the source and nothing bundled is canon of its own. WRITING tests:
after go doc -all, match the package's disjoint symbol clusters to
archetypes via exemplar/README.md and read ONLY the matched samples, as
inspiration — generation is creative synthesis; the review loop carries the
nuance load. REVIEWING or critiquing tests: read the whole exemplar corpus
with its annotations — evaluation is discrimination; the corpus is your
grading sense, calibrated by evaluator-cases.md, the rulings evaluators
mis-graded before. Load references on scenario, not sooner:

- `references/helpers.md` — a test wants a helper, a fake, or a dependency.
- `references/tables-and-subtests.md` — cases repeat, or a t.Run forms.
- `references/fixtures.md` — file inputs, long literals, malformed cases.
- `references/examples.md` — an Example function is written, reviewed, or judged.
- `references/concurrency.md` — goroutines, panics, races, invalid inputs.
- `references/harnesses.md` — conformance suites and testing packages.

## The contract and the golden hierarchy

Test freely while developing: throwaway tests, tailored executables,
build-tagged experiments, runs under constrained CPU (a weak-runner flake
is a contract failure too). None of it gets committed: committed _test.go
files carry only the package's contract with its users, so a breaking
change either fails the tests or amends them to state the new contract;
unit tests are rapid iteration against a contract, not bug hunts.

The package's prose, the package doc and exported doc comments that godoc
publishes and users rely on, is the most sacred part of its contract.
Authority descends through exported signatures, code behavior, and
unexported comments, down to the existing tests: the least golden thing in
the room, never the standard. A test authored from the implementation
mirrors it, bugs included; one authored from the prose holds the package to
its promises. Drift is a finding, never silently absorbed: ask the owner,
else side with prose unless the code moved deliberately, then fix the prose.
Go-doc-first makes this operational: draft the test plan from go doc -all
alone, no bodies, before opening source, so every collision is surfaced drift.

## The unit is the package

Go's objects are packages, not files or symbols. Exercise each package as
its user, in an external `package foo_test` that enforces the user's seat
at compile time, unless a peephole into internals is required. Thinking as
a user tests flows, the anticipated call patterns that embody the contract,
not a symbol-by-symbol scan. Aspire to fewer tests that cover more of the
exported API, because users compose the API rather than call it piecemeal.

When asked to add a test for one symbol, first see whether it fits an
existing test as a sub-test or table row; usually it will not, and a
runnable example is the next reach. A bug-hunt request gets run, not
committed. A symbol extending the API gets tested the way its siblings are.

A representative runnable example of the anticipated call pattern is
mandatory per package; an ExampleLoad that just calls Load earns no commit.
Example comments, doc and in-function alike, render on pkgsite: they speak
to users about the attributed symbol and scenario, repeating non-Go
contract parts at call sites, never narrating the code. Test comments speak
only to maintainers: a non-trivial test carries a doc comment giving the
author's rationale in layman's terms, a trivial one needs none, and no test
comment ever opens with the function's name. Never explain conventions,
ordering, or synctest mechanics: nothing good to say, say nothing. A test
name claims a property in plain English, not a symbol; a whole-package
scenario test named for the package is good. Bodies are trivial
straight-line code: hard-coded numbers, not algorithms, the math done at
coding time and written as results. Write for the newest Go, 1.27, and
never hedge for older toolchains: a feature the toolchain in use lacks
announces itself at compile time. Canon postdating training data:
b.Loop benchmarks (Go 1.24), which the compiler keeps alive where old b.N
discard-loops optimize away, and t.Context() (Go 1.24), canceled just
before Cleanup so context-shutdown resources drain in time.

## Concurrency and time

Go's doc conventions (go.dev/doc/comment) presume a top-level function safe
for concurrent use and a type's methods not, unless the docs promise more:
never commit a test pinning concurrency the docs do not promise; in review,
delete such tests rather than rewrite them. Prefer testing/synctest (Go
1.25) for contexts and goroutines: bubbles run on virtual time, so sleeping
inside one is idiomatic and stable. Use the least orchestration: never
spawn a goroutine whose only job the main goroutine could do directly
(waiting on a goroutine that calls Wait is calling Wait), and never contort
a test to dodge a hang, because unit tests complete faster than humans
notice, so "hang is a valid test failure".

## Review and redesign

Defective test structure is breakage: per-symbol grain, self-naming
comments, dev scaffolds, and change-detectors re-asserting a constant
fixture contribute only blunt coverage; consolidate or delete them, since
"don't break anything" means the package's contract, not the test file's
shape, then finish any pass by re-reading the file top to bottom against the
package's prose. The secondary goal is the package: tests repeatedly
translating an API value mean production users need the translation too, so
flag that area for a rethink; interrelated const/var values take an interplay
comment. Findings deserve the author's inferences (promise it, or refuse
to harden?); non-trivial tests land as fine-grained commits carrying them.
A reviewer of tests never edits exported source or prose: those are
owner-only, regardless of what any exemplar or fixture suggests, and drift
findings go to the report, not the code.

Testability is a design signal. Never assert error strings, least of all for
errors this module controls: return typed or sentinel errors checked via
errors.Is and errors.AsType[T] (Go 1.26), because a grep-only test indicts
the API; prefer io interfaces, readers and writers over paths. A test that
proves hard to write is a signal to redesign, rethink, or try harder.
