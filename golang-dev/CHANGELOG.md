# Changelog

## naming

Initial release of the naming skill for Go identifiers.

- Core workflow for naming packages, functions, methods, types, variables, constants, and receivers
- Reference files for context-aware naming guidance across all identifier types
- Examples from Go stdlib demonstrating excellent naming patterns
- Anti-pattern examples showing common mistakes with corrections
- Triggers on user requests and proactively when Claude creates new code elements
- Comprehensive coverage of Go team conventions including MixedCaps, initialisms, and repetition avoidance

## committing

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
