# Changelog

All notable changes to github-author are documented in this file.

## [0.3.2] - 2026-07-29

### writing-pull-requests

- Set sentences that enumerate three or more parallel items off as prose-lists: items that still read as one sentence but scan as a list

### writing-issues

- Name the prose-list as the remedy for a comma-chained enumeration, so breaking a sentence into items does not require reshaping it into fragments

## [0.3.1] - 2026-07-29

### writing-pull-requests

- State in the opening that the problem space normally lives in a linked issue, and that one opening paragraph of friction and cost stands in for it when none exists

## [0.3.0] - 2026-07-28

### writing-issues

- Recast the skill from construction procedure to characteristics of the
  finished issue: workflow steps, negative-pattern blocks, and the pre-flight
  checklist gave way to five characteristics a good body embodies, trusting form
  to follow content
- Replace the "issues explain why and what, PRs explain how" boundary with the
  problem-space trio — why (the friction and its cost), how (the constraints any
  solution must live within), what (the symptoms as evidence) — communicated
  inside-out, since the old boundary admitted solution-space requirements by
  construction
- State the inside-out ordering mechanism: symptoms placed before the friction
  read as a work list, symptoms placed after it read as evidence
- Stop presenting "Acceptance Criteria" as a canonical heading: no heading is
  canonical, validation is read off the body rather than invented, and one
  sentence often carries it
- Guard constraints with the can-the-assignee-change-it test against design
  prescription in costume
- Report evidence at its actual weight: anecdotes stay anecdotes, numbers appear
  only where something was measured, and an absent measure becomes a
  `[FILL: ...]` pointer instead of an invented threshold
- Keep the remedy out of the title unless it was settled before the issue
  existed
- State validation once, in one form: a sentence for a single outcome, or a "By
  the time this issue is complete:" lead-in with a list for several, since a
  paragraph and a checklist carrying the same items shadow each other
- Stop planting invented validation headings ("How We'll Know"): a reader-novel
  category costs a parse the contents never repay, so corrections use the
  lead-in sentence or a conventional label
- Bind the lead-in sentence and its list into one statement rather than a
  closing line plus a formal section, and rule out activity criteria ("root
  cause documented", "approach decided"), which are work items wearing
  checkboxes
- Reserve headings for bodies large enough to need them, at the model's
  discretion, and for material past the opening: the why opens every issue
  untitled, so a generic "Context" or "Background" head mostly labels what the
  issue already leads with
- Rebuild the worked examples as a five-shot set mostly adapted from real
  issues, spread across domain, body weight, and validation form, with
  continuous-line bodies matching the `gh --body` format the skill teaches
- Refit the body-structure reference to reader expectations by issue type,
  dropping the sections that restated the skill

### writing-pull-requests

- Restate the issue and PR boundary as two trios, replacing a division that
  assigned "why" to issues and "how" to pull requests

### /draft-issue

- Gather the friction, the constraints, and the evidence as distinct context,
  then read criteria off what the body now says
- Run on Sonnet via the `model` frontmatter field, since issue drafting does not
  need a larger model

## [0.2.2] - 2026-03-08

### writing-pull-requests

- Rewrite description in third person for reliable skill discovery
- Mark as background knowledge with `user-invocable: false`

### writing-issues

- Rewrite description in third person for reliable skill discovery
- Mark as background knowledge with `user-invocable: false`

### /draft-pr

- Restrict to manual invocation with `disable-model-invocation: true`
- Reference writing-pull-requests skill as explicit invocation, not vague prose
- Add `Glob` and `Skill` to allowed tools

### /draft-issue

- Restrict to manual invocation with `disable-model-invocation: true`
- Reference writing-issues skill as explicit invocation, not vague prose
- Add `Glob` and `Skill` to allowed tools

## [0.2.1] - 2026-03-08

### writing-pull-requests

- Instruct continuous-line paragraphs in `--body` content to prevent GitHub
  rendering hard wraps as jagged line breaks

### writing-issues

- Instruct continuous-line paragraphs in `--body` content to prevent GitHub
  rendering hard wraps as jagged line breaks

### /draft-pr

- Warn against hard-wrapping paragraphs when executing `gh pr create`

### /draft-issue

- Warn against hard-wrapping paragraphs when executing `gh issue create`

## [0.2.0] - 2026-02-01

### writing-pull-requests

- Organize verbs by intent with scannable quick-reference table (new capability,
  improvement, fix, structural, removal, configuration, documentation)
- Surface problematic verbs with three-column alternatives table (avoid, why,
  use instead)
- Clarify header usage with concrete thresholds (prose for under 3 paragraphs,
  headers for 3-4+ paragraphs or complex topics)

## [0.1.0] - 2026-01-31

### writing-pull-requests

- Teach "fill in the blank" technique for titles: "After this PR merges, the
  repository will _____"
- Distinguish repository-capability verbs (parse, handle, support) from
  developer-action verbs (add, implement, create)
- Guide motivation-focused descriptions with prose flow over bullet lists
- Surface hidden context through probe questions documented in examples
- Encode rationale embedding in code comments alongside PR descriptions
- Provide good/bad examples with `<probe>` tags showing context discovery

### writing-issues

- Encode present progressive titles reflecting ongoing work ("Supporting...",
  "Fixing...", "Investigating...")
- Guide outcome-focused bodies with "By the time this Issue is complete..."
  pattern
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
