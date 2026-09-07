# github-author

Author high-quality GitHub contributions with Claude Code or Codex.
This plugin focuses on the craft of writing effective Pull Requests and Issues, emphasizing content quality over workflow mechanics.

## Features

### Skills

- **writing-pull-requests** - Activates during PR creation.
  Teaches the "fill in the blank" technique for titles ("After this PR merges, the repository will _____"), motivation-focused descriptions, and context surfacing through probe questions
- **writing-issues** - Activates during issue creation.
  Encodes present progressive titles ("Supporting...", "Fixing..."), problem-space bodies built on the why/how/what trio, and validation criteria derived by inverting the symptoms the body already states

### Commands (Claude Code)

- `/draft-pr` - Interactive PR drafting workflow that analyzes your git changes and guides you through creating an effective pull request
- `/draft-issue` - Guided interview for creating well-structured GitHub issues

## Installation

### Claude Code

```bash
claude plugin marketplace add notorious-ai/claude-plugins
claude plugin install github-author@notorious-ai
```

### Codex CLI

```bash
codex plugin marketplace add notorious-ai/claude-plugins
codex plugin add github-author@notorious-ai
```

Start a new Codex session after installation.

## Usage

### Automatic Skill Activation

The skills activate automatically when you ask Claude Code or Codex to help with PRs or issues:

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

An issue lives entirely in the problem space.
A pull request lives in the solution space.
That boundary, not a split between motivation and detail, is what these conventions defend:

- **PR Titles**: Imperative mood, verb-first, describing how the repository changes
- **Issue Titles**: Present progressive, beginning with a meaningful verb
- **Content Focus**:
  - PRs: Carry the solution's own why, how, and what.
    Why this design and not another.
    How the constraints shaped it.
    What it consists of, without retelling a diff the reader can already see.
  - Issues: Carry the problem's own why, how, and what.
    The friction and who bears it.
    The constraints any solution must live within.
    The symptoms, with whatever numbers exist, that show the problem is real.
- **Validation**: An issue also says how anyone will know the problem is gone, read off what the body already states rather than invented alongside it

Choosing the design is the assignee's work, and an issue that pre-empts that choice both removes their agency and tends to miss the better approach.

## Requirements

- `gh` CLI installed and authenticated (for GitHub API interactions)
- Git repository with remote configured
