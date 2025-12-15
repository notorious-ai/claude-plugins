---
description: Interactive PR drafting with git-first context gathering
allowed-tools: Read, Grep, Bash(git:*), Bash(gh:*), AskUserQuestion
---

# Draft Pull Request

Gather git context and draft an effective pull request using the writing-pull-requests skill.

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

## Step 3: Clarify Context (If Needed)

If the purpose of the changes is unclear from the git context:

Use AskUserQuestion to gather motivation:

**Question 1:**
- question: "What problem does this PR solve or what value does it add?"
- header: "Motivation"
- options:
  - Bug fix (Corrects incorrect behavior)
  - New feature (Adds new capability)
  - Improvement (Enhances existing functionality)
  - Refactoring (Restructures without behavior change)

**Question 2:**
- question: "Is there a related issue to link?"
- header: "Issue link"
- options:
  - Yes (I'll provide the issue number)
  - No issue exists (The PR description will provide context)
  - Search again (Help me find related issues)

If user selects "Yes", ask for the issue number.
If "No issue exists", ensure the PR description is comprehensive.

## Step 4: Draft PR

Using the gathered context and the writing-pull-requests skill:

1. **Identify the capability**: From the diff and commits, determine what the repository now does differently

2. **Draft title**: Create an imperative verb-first title describing the repository transformation
   - NOT developer action verbs (add, implement, create, write)
   - Use capability verbs (parse, handle, support, validate, prevent, extract)

3. **Draft description**:
   - Open with untitled paragraph explaining WHY (motivation, impact)
   - Link related issues if identified
   - For PRs without linked issues, provide comprehensive context

4. **Consider proofs**: For complex changes, ask if there's proof to link

## Step 5: Present for Review

Present the drafted PR title and description.

Use AskUserQuestion for confirmation:

- question: "Ready to create this PR?"
- header: "Create PR"
- options:
  - Create PR (Proceed with gh pr create)
  - Create as draft (Create draft PR for early feedback)
  - Revise (Let me adjust the title or description)
  - Cancel (Exit without creating)

If "Create PR" or "Create as draft", execute `gh pr create` with the drafted content.
If "Revise", ask what to change and iterate.
