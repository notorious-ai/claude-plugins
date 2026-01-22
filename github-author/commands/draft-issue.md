---
description: Guided interview for creating well-structured GitHub issues
allowed-tools: Read, Grep, Bash(gh:*), AskUserQuestion
---

# Draft GitHub Issue

Guide the user through creating an effective issue using the writing-issues skill. Focus on surfacing the **why** - motivation, impact, and desired outcome - rather than prescribing implementation.

## Step 1: Check for Issue Templates

Look for repository issue templates:
!`ls -la .github/ISSUE_TEMPLATE/ 2>/dev/null || echo "No issue templates found"`

If templates exist, list them and ask user if they want to follow a template.

## Step 2: Determine Issue Type

Use AskUserQuestion:

- question: "What type of issue are you creating?"
- header: "Issue type"
- options:
  - Bug report (Something isn't working correctly)
  - Feature request (A new capability or enhancement)
  - Task tracking (Work that needs to be done)
  - Discussion (Exploring a decision or gathering input)

## Step 3: Surface the Hidden Context

Use probe questions to uncover the essential "why". The writing-issues skill guides what context to capture - focus on:

- **Who is affected and how** - the specific pain or limitation
- **What happens if unaddressed** - impact of inaction
- **What does "done" look like** - verifiable end state

Ask type-specific questions:

**Bug**: What were you trying to accomplish? What should have happened? How reproducible?

**Feature**: What problem prompted this? Who needs it and in what situation? What outcome resolves it?

**Task**: Why now? What constraints exist? What will be true when complete?

**Discussion**: What decision is needed? What context do others need? What questions matter?

If information is unavailable, use actionable placeholders: `[FILL: specific action to obtain this]`

## Step 4: Search for Related Issues

Check for duplicates or related work:
!`gh issue list --state all --limit 10 2>/dev/null || echo "Could not fetch issues"`

Ask if any existing issues relate. Prior attempts and discussions provide valuable context.

## Step 5: Draft Issue

Apply the writing-issues skill to draft:

1. **Title**: Present progressive verb + goal (think: "This issue is _____")
2. **Body**: Open with why, state who/how affected, include definition of done, link related work with context

## Step 6: Present for Review

Present the drafted issue.

Use AskUserQuestion:

- question: "Ready to create this issue?"
- header: "Create issue"
- options:
  - Create issue (Proceed with gh issue create)
  - Revise (Let me adjust the content)
  - Cancel (Exit without creating)

If "Create issue", execute `gh issue create`.
If "Revise", ask what to change and iterate.
