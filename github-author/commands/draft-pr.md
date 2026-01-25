---
description: Interactive PR drafting with git-first context gathering
allowed-tools: Read, Grep, Bash(git:*), Bash(gh:*), AskUserQuestion
---

# Draft Pull Request

Gather git context and draft an effective pull request using the writing-pull-requests skill. Focus on surfacing the **why** - intent, constraints, and rationale - that the diff cannot convey.

## Step 1: Gather Git Context

Collect information about the current branch:

Branch and commits:
!`git branch --show-current && echo "---" && git log --oneline main..HEAD 2>/dev/null | head -15`

Files changed:
!`git diff main...HEAD --stat 2>/dev/null | tail -15`

## Step 2: Search for Related Work

Check for related issues and PRs:

Open issues:
!`gh issue list --state open --limit 8 2>/dev/null || echo "Could not fetch issues"`

Recent PRs:
!`gh pr list --state all --limit 5 2>/dev/null || echo "Could not fetch PRs"`

## Step 3: Surface the Hidden Context

Use probe questions to uncover what the diff cannot show. The writing-pull-requests skill guides what context to capture - focus on:

- **Expected outcome** - what the change accomplishes (verifiable against the changeset)
- **Constraints that shaped the solution** - technical, organizational, or timeline limitations
- **Designed exclusions** - what this change explicitly does not address and why
- **Reevaluation triggers** - conditions under which to revisit this decision

Ask clarifying questions:

- "What constraint prevented the simpler solution?"
- "What is explicitly out of scope, and why?"
- "Under what conditions should we revisit this approach?"

Use AskUserQuestion if purpose is unclear:

- question: "What problem does this PR solve or what value does it add?"
- header: "Motivation"
- options:
  - Bug fix (Corrects incorrect behavior)
  - New feature (Adds new capability)
  - Improvement (Enhances existing functionality)
  - Refactoring (Restructures without behavior change)

Check for linked issues:

- question: "Is there a related issue to link?"
- header: "Issue link"
- options:
  - Yes (I'll provide the issue number)
  - No issue exists (The PR description will provide context)
  - Search again (Help me find related issues)

If no linked issue, the description must compensate with comprehensive context.

## Step 4: Draft PR

Apply the writing-pull-requests skill to draft:

1. **Identify the capability**: What does the repository do differently after this merges?
2. **Title**: Imperative verb + capability (think: "After this PR merges, the repository will _____")
3. **Description**: Open with why, link related issues with context, note constraints and exclusions

For complex changes, ask about proof to link.

## Step 5: Consider Rationale Embedding

If rationale was uncovered that benefits future maintainers, check the changeset for appropriate places to embed it (code comments, existing docs). Respect existing project conventions.

## Step 6: Present for Review

Present the drafted PR.

Use AskUserQuestion:

- question: "Ready to create this PR?"
- header: "Create PR"
- options:
  - Create PR (Proceed with gh pr create)
  - Create as draft (Create draft PR for early feedback)
  - Revise (Let me adjust the title or description)
  - Cancel (Exit without creating)

If "Create PR" or "Create as draft", execute `gh pr create`.
If "Revise", ask what to change and iterate.
