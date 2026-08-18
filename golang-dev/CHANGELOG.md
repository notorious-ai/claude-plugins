# Changelog

## golang-dev

Point the install command at the marketplace the collection publishes under.

## testing

Correction pass following the first landing.

- Move `evaluator-cases.md` beside SKILL.md, since it loads by reviewer role rather than by scenario like every file under `references/`
- Cite canon snippets by source file alone, dropping the line ranges that rot on each Go release and invite doubt about a quote that merely moved
- Carry the snippets' provenance in a dot-file the skill never loads, with all twenty-two samples re-verified line for line against the `go1.27rc2` tag
- Close the maphash sample's second test function, which had been cut one brace short of compiling
- Drop the hand-typed package-surface listing from the maphash file: unattributed code in a folder admitting only Go-team snippets, and silent about the three Write methods its own sample mixes seven ways
- Stop restating sample ids and source paths in prose, leaving the markup as the one place either is declared
- Correct the router's claim of one file per source package, false for the two files that quote a second package for their counter-example
- Attribute a go/parser expectation to the position of the offending token rather than of the marker comment following it
- Settle the goroutine-leak calibration rule: a synctest bubble waits for the goroutines inside it, so bubble exit is the detector and a WaitGroup belongs outside one
- Keep synctest narration out of the calibration file's blessed code shape, which the always-loaded doctrine forbids
- Describe the panic-recovery helper in `references/helpers.md` in place, instead of sending writers after a name that lives only in the reviewer-only calibration file
- Fix the target at the newest Go release without hedging for older toolchains, since the compiler names a missing feature the moment it matters
- Spell out how an example's name attributes it to a symbol, naming pkgsite as the reader and bounding what vet catches to an identifier matching nothing in the package or its imports
- Require a name or an unrolled call for a case whose value carries no meaning on its own
- Confine `when_to_use` to triggering, lifting the procedural sentences out of the field that shares a listing budget with the description
- Pre-approve `go doc`, `go test`, `go vet`, and gofmt's reporting forms through `allowed-tools`

Initial release of the testing skill for committed Go tests.

- Golden hierarchy of contract authority running from the package's prose down to its existing tests, with drift surfaced as a finding instead of absorbed into a new test
- Package-as-unit doctrine: an external test package, anticipated call patterns over symbol-by-symbol scans, and one representative runnable example required per package
- Go-doc-first planning, drafting the test plan from the exported documentation alone before any source file is opened
- Role-split routing where writers read only the exemplar samples matching their package's clusters while reviewers read the corpus whole
- Eight exemplar files of verbatim, attributed Go-team snippets, serving the transform, lifecycle, stream, contract-conformance, harness, golden-fixture, async-assert, and example archetypes
- Six scenario references covering helpers and fakes, tables and sub-tests, fixtures, runnable examples, concurrency and time, and conformance harnesses
- Reviewer-only calibration cases pairing a shape a grader must not flag with the near-neighbour it must
- Owner-only boundary keeping a reviewer of tests out of exported source and prose, with drift findings routed to the report

## planning-commits

Encode per-commit hygiene as part of the incremental facet.

- Extend `references/triad.md` so the incremental facet names mechanical hygiene — formatting, tidying, regenerating derived files — as belonging within each commit, never deferred to a trailing dump
- Surface the same rule in SKILL.md workflow step 3 so it applies whether or not the triad reference has been loaded
- Add `examples/go-mod-get-before-use.md` showing one `go.mod: get` commit per module ahead of the first caller, with `go mod tidy` run before staging
- Add `examples/go-mod-tidy-first.md` showing how to detect a contaminated working tree and isolate its cleanup as the first commit
- Add `examples/antipattern-trailing-format-dump.md` covering the format/tidy analogue of the trailing-docs-dump anti-pattern, with framing that defers to per-repo tooling awareness rather than hardcoding a specific stack

Polish pass following initial-release review.

- Tighten SKILL.md description by removing the sibling-skill example, leaving the body to name the message-writing hand-off
- Collapse the inline anti-pattern enumeration in Workflow step 2 to a pointer at the Example Files table
- Surface the "premature naming" guardrail from plan-shape into Workflow step 3 so it lands without loading the reference
- Generalise the manifest-tidying example to name Go, npm, and Cargo ecosystems
- Correct a possessive typo in docs-with-feature.md

Initial release of the planning-commits skill for sequencing atomic, fine-grained, incremental commits before any code is written or messages are drafted.

- Core workflow inspecting the changeset, identifying capabilities and decisions, drafting the plan, presenting for approval, and handing each commit off to a message-writing skill
- Triad reference defining atomic, fine-grained, and incremental with the value-vs-syntactic distinction and the decision-rationale-layering benefit
- Plan-shape reference specifying the single-sentence scope plus context paragraph deliverable and the hand-off contract to commit-message-writing skills
- Six positive examples covering skeleton-first introductions, flags growing with their features, siblings split by decision context, docs travelling with their feature, isolated dependency adoption, and decision-rationale layering
- Five anti-pattern examples covering syntactic grouping by symbol kind, abstraction layer, and mechanical role, plus the flags-up-front and trailing docs-dump failures
- Language-agnostic triggers covering "plan commits", "break this into commits", "atomic commits", and proactive loading before any non-trivial changeset
- Validation checklist and special-case guidance for mixed-language, dependency-only, and large-refactor changesets

## naming

Removed. The skill no longer ships with the plugin.

- Idiomatic Go naming is trained into current models; what still slips, the standard linters catch
- A policy skill for idiomatic Go packages will follow separately

Initial release of the naming skill for Go identifiers.

- Core workflow for naming packages, functions, methods, types, variables, constants, and receivers
- Reference files for context-aware naming guidance across all identifier types
- Examples from Go stdlib demonstrating excellent naming patterns
- Anti-pattern examples showing common mistakes with corrections
- Triggers on user requests and proactively when Claude creates new code elements
- Comprehensive coverage of Go team conventions including MixedCaps, initialisms, and repetition avoidance

## committing

Defer commit-splitting decisions to the new planning-commits skill.

- Replace the "consider splitting into separate commits" guidance in Mixed Changes with a pointer to `golang-dev:planning-commits`

Modernize skill frontmatter to use current Claude Code fields.

- Split discovery hints into a dedicated `when_to_use` field and strengthen it to fire at the earliest code-task signal in a Go-centric repo, not only on commit-time keywords
- Pre-approve read-only git inspection (`git diff`, `git log`, `git status`) via `allowed-tools` so commit drafting no longer prompts for permission on every diagnostic command

Recognize Claude Code targets and refine body discipline guidance.

- Add `claude:` target for CLAUDE.md, `.claude/`, and plugin manifests
- Add `agents:` target for subagent definition files
- Reorder body-guidelines to follow the writer's drafting sequence
- Present all three body principles at the drafting step so the reference becomes optional
- Single-source the body checklist in body-guidelines.md
- Co-locate example-file tag conventions with the example files
- Illustrate the stranger test on a parser rename diff

Tighten body discipline so the commit message stays in its lane.

- Name the three layers of meaning: diff is WHAT, file comments are WHY-INTRINSIC, body is WHY-EXTRINSIC
- Forbid paraphrasing the diff, illustrated with a worked before-and-after example
- Introduce the stranger test as a pre-draft step that anchors body content in unanswered questions
- Require the engineer's voice; reject agent narration and any echo of user instructions or prompts
- Require body length to be proportional to diff complexity

Initial release of the committing skill for Go-centric codebases.

- Core workflow for generating commit messages matching Go team conventions
- Reference files for Go package targeting and non-Go file categories
- Body guidelines with validation steps and URL transformation
- 70+ real stdlib examples organized by work type (feature, performance, security, etc.)
- Anti-pattern examples with partitioned bad/good pairs
- Triggers on both user requests and agent-initiated commits
