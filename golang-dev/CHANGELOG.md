# Changelog

## planning-commits

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
