# Changelog

All notable changes to github-author are documented in this file.

## [0.1.0] - Unreleased

### writing-pull-requests
- Teach "fill in the blank" technique for titles: "After this PR merges, the repository will _____"
- Distinguish repository-capability verbs (parse, handle, support) from developer-action verbs (add, implement, create)
- Guide motivation-focused descriptions with prose flow over bullet lists
- Surface hidden context through probe questions documented in examples
- Encode rationale embedding in code comments alongside PR descriptions
- Provide good/bad examples with `<probe>` tags showing context discovery

### writing-issues
- Encode present progressive titles reflecting ongoing work ("Supporting...", "Fixing...", "Investigating...")
- Guide outcome-focused bodies with "By the time this Issue is complete..." pattern
- Distinguish problem-space (issues) from solution-space (PRs)
- Surface hidden context through probe questions documented in examples
- Provide type-specific guidance for bugs, features, tasks, and discussions
- Include good/bad examples with `<probe>` tags and `<why_good>` rationale

### /draft-pr
- Gather git context (branch, commits, diff) before drafting
- Search for related issues and PRs via `gh` CLI
- Interactive clarification for motivation and issue linking
- Present draft for review with create/revise/cancel options

### /draft-issue
- Check for repository issue templates before drafting
- Guided interview by issue type (bug, feature, task, discussion)
- Search for duplicate or related issues via `gh` CLI
- Present draft for review with create/revise/cancel options
