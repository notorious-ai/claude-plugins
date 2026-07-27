# Changelog

All notable changes to github-author are documented in this file.

## [0.3.0] - 2026-07-28

### writing-issues

- Replace the "issues explain why and what, PRs explain how" boundary with the problem-space why/how/what trio, since that boundary admitted solution-space requirements by construction
- Type constraints, trade-offs, scope boundaries, and failed prior attempts as problem-space "how" rather than implementation detail to withhold
- Derive validation criteria by inverting a documented symptom, confirming a stated constraint, or retiring a named risk, so every criterion traces to an antecedent already in the body
- Inherit criterion precision from its antecedent instead of choosing it, removing the pull toward invented thresholds
- Guard the constraint section with the can-the-assignee-change-it test against design prescription in costume
- Add the two-implementations test for detecting mechanism named inside a criterion
- Stop presenting "Acceptance Criteria" as a canonical heading; specify the function the section performs and vary headings across examples
- State the inside-out ordering mechanism: symptoms placed before the friction read as a work list, symptoms placed after it read as evidence
- Distinguish scope enumeration from validation so scope checklists survive the new rule
- Distinguish a vague why, which stays forbidden, from a loose validation criterion for a clear why, which is acceptable
- Relabel bug reproduction steps as problem-space "what" rather than an exception to a no-how rule
- Fold title-mood guidance into Title Structure and merge three overlapping checklist sections

### /draft-issue

- Gather symptoms and constraints as distinct context, then derive criteria by inversion rather than asking what "done" looks like

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

- Instruct continuous-line paragraphs in `--body` content to prevent GitHub rendering hard wraps as jagged line breaks

### writing-issues

- Instruct continuous-line paragraphs in `--body` content to prevent GitHub rendering hard wraps as jagged line breaks

### /draft-pr

- Warn against hard-wrapping paragraphs when executing `gh pr create`

### /draft-issue

- Warn against hard-wrapping paragraphs when executing `gh issue create`

## [0.2.0] - 2026-02-01

### writing-pull-requests

- Organize verbs by intent with scannable quick-reference table (new capability, improvement, fix, structural, removal, configuration, documentation)
- Surface problematic verbs with three-column alternatives table (avoid, why, use instead)
- Clarify header usage with concrete thresholds (prose for under 3 paragraphs, headers for 3-4+ paragraphs or complex topics)

## [0.1.0] - 2026-01-31

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
