# Changelog

All notable changes to golang-dev are documented in this file.

## [0.6.1] - 2026-08-26

### testing

- Look to a dependency's own exported API before writing a test helper that searches, indexes, or converts the values it owns

## [0.6.0] - 2026-08-18

### naming

- Removed. Idiomatic Go naming is trained into current models; what still slips, the standard linters catch. A policy skill for idiomatic Go packages will follow separately

## [0.5.1] - 2026-07-27

### testing

- Cite canon snippets by source file alone, since line ranges rot on every Go release
- Re-verify all twenty-two Go-team samples against `go1.27rc2` and fix the maphash sample that did not compile
- Target the newest Go release without hedging for older toolchains
- Describe the panic-recovery helper where writers look for it, in `references/helpers.md`
- Settle the goroutine-leak rule: a synctest bubble is the detector, and a WaitGroup belongs outside one
- Require a name or an unrolled call for a table case whose value carries no meaning on its own
- Pre-approve `go doc`, `go test`, `go vet`, and gofmt's reporting forms, so the skill no longer prompts for them

## [0.5.0] - 2026-07-27

### testing

- New skill: holds committed Go tests to the maintainer's standard and reviews a suite against it
- Treats the package as the unit: an external test package, anticipated call patterns, and one runnable example per package
- Plans tests from the exported documentation before opening any source file, and surfaces drift between docs, code, and tests as a finding
- Ships verbatim, attributed Go-team snippets to imitate, one reference per scenario, and reviewer-only calibration cases

## [0.4.2] - 2026-05-16

### planning-commits

- Keep formatting, tidying, and regenerated files inside the commit that made them necessary, never in a trailing dump

## [0.4.1] - 2026-05-16

### planning-commits

- Surface the premature-naming guardrail without loading the reference file
- Generalise the manifest-tidying example beyond Go to npm and Cargo

## [0.4.0] - 2026-05-16

### planning-commits

- New skill: plans a fine-grained sequence of atomic, incremental commits before any code is written, in any language, then hands each commit to a message-writing skill

### committing

- Defer commit-splitting decisions to `golang-dev:planning-commits`

## [0.3.1] - 2026-05-16

### committing

- Fire at the earliest code-task signal in a Go-centric repo, not only on commit-time keywords
- Pre-approve `git diff`, `git log`, and `git status`, so drafting a commit no longer prompts for each
- Recognise `claude:` and `agents:` targets for Claude Code configuration and subagent files

## [0.3.0] - 2026-05-16

### committing

- Keep the commit body in its lane: the diff is what, file comments are the intrinsic why, the body is the extrinsic why
- Forbid paraphrasing the diff, require the engineer's voice over agent narration, and size the body to the diff

## [0.2.0] - 2026-02-11

### naming

- New skill: names Go identifiers following Go team conventions

## [0.1.0] - 2025-12-03

### committing

- New skill: writes commit messages following Go team conventions for Go packages and supporting files
