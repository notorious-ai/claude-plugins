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
  of done: do not wait for the word "test". Begin in go-doc-first mode,
  planning from the exported docs before opening source, and enter
  exemplar/ by role, matched samples to write and the whole corpus to
  review. Not for non-Go test frameworks, godoc-only tasks, go vet or CI
  tooling failures, fuzz-crash debugging, or test-plan process documents.
---

# Committed Go Tests

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
