# github-author

Enrich Claude's knowledge for authoring high-quality GitHub contributions. This plugin focuses on the craft of writing effective Pull Requests and Issues, emphasizing content quality over workflow mechanics.

## Features

### Skills

- **writing-pull-requests** - Activates when Claude helps with PR creation. Teaches the "fill in the blank" technique for titles ("After this PR merges, the repository will _____"), motivation-focused descriptions, and context surfacing through probe questions
- **writing-issues** - Activates when Claude helps with issue creation. Encodes present progressive titles ("Supporting...", "Fixing..."), outcome-focused bodies, and the "By the time this Issue is complete..." pattern for definition of done

### Commands

- `/draft-pr` - Interactive PR drafting workflow that analyzes your git changes and guides you through creating an effective pull request
- `/draft-issue` - Guided interview for creating well-structured GitHub issues

## Installation

```bash
claude plugin install github-author@notorious-ai
```

## Usage

### Automatic Skill Activation

The skills activate automatically when you ask Claude to help with PRs or issues:

- "Help me write a PR for these changes"
- "I need to create an issue for this bug"
- "Draft a feature request for..."

### Interactive Commands

```bash
# Start interactive PR drafting
/draft-pr

# Start guided issue creation
/draft-issue
```

## Philosophy

This plugin encodes opinionated conventions for GitHub authoring:

- **PR Titles**: Imperative mood, verb-first, describing how the repository changes
- **Issue Titles**: Present progressive, beginning with a meaningful verb
- **Content Focus**:
  - PRs: Emphasize the "why" over the "what" - code diffs show what changed
  - Issues: Emphasize the "why" over the "how" - focus on desired outcomes, not implementation steps

The "what" and "how" are implementation details. They belong to the PR reviewer and Issue assignee, respectively.

## Requirements

- `gh` CLI installed and authenticated (for GitHub API interactions)
- Git repository with remote configured
