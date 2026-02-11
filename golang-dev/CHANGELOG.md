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

Initial release of the committing skill for Go-centric codebases.

- Core workflow for generating commit messages matching Go team conventions
- Reference files for Go package targeting and non-Go file categories
- Body guidelines with validation steps and URL transformation
- 70+ real stdlib examples organized by work type (feature, performance, security, etc.)
- Anti-pattern examples with partitioned bad/good pairs
- Triggers on both user requests and agent-initiated commits
