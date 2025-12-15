---
description: Guided interview for creating well-structured GitHub issues
allowed-tools: Read, Grep, Bash(gh:*), AskUserQuestion
---

# Draft GitHub Issue

Guide the user through creating an effective issue using the writing-issues skill.

## Step 1: Check for Issue Templates

Look for repository issue templates:
!`ls -la .github/ISSUE_TEMPLATE/ 2>/dev/null || echo "No issue templates found"`

If templates exist, list them and ask user if they want to follow a template.

## Step 2: Determine Issue Type

Use AskUserQuestion to understand what kind of issue:

**Question 1:**
- question: "What type of issue are you creating?"
- header: "Issue type"
- options:
  - Bug report (Something isn't working correctly)
  - Feature request (A new capability or enhancement)
  - Task tracking (Work that needs to be done)
  - Discussion (Exploring a decision or gathering input)

## Step 3: Gather Context Based on Type

### If Bug Report:

Use AskUserQuestion:

**Question:**
- question: "How reproducible is this bug?"
- header: "Frequency"
- options:
  - Always (100% reproducible)
  - Sometimes (Intermittent, not always)
  - Rare (Happened once or twice)
  - Unknown (Haven't tried reproducing)

Ask for:
- What is happening? (Current behavior)
- What should happen? (Expected behavior)
- Steps to reproduce (if reproducible)
- Environment details (if relevant)

### If Feature Request:

Ask for:
- What problem or need does this address?
- Who is affected?
- What outcome would resolve this?

Use AskUserQuestion:

**Question:**
- question: "How would you describe the impact?"
- header: "Impact"
- options:
  - Critical (Blocking important work)
  - High (Significantly affects users)
  - Medium (Noticeable improvement)
  - Low (Nice to have)

### If Task Tracking:

Ask for:
- What needs to be accomplished?
- Why is this work needed now?
- What does "done" look like?

Use AskUserQuestion:

**Question:**
- question: "Is this task part of a larger effort?"
- header: "Scope"
- options:
  - Standalone (Independent work)
  - Part of epic (Related to other issues)
  - Dependency (Blocks or is blocked by other work)

If "Part of epic" or "Dependency", ask for related issue numbers.

### If Discussion:

Ask for:
- What decision needs to be made?
- What context do others need?
- What questions should be considered?

## Step 4: Search for Related Issues

Check for duplicates or related work:
!`gh issue list --state all --limit 10 2>/dev/null || echo "Could not fetch issues"`

Ask user if any existing issues relate to this one.

## Step 5: Draft Issue

Using the gathered context and the writing-issues skill:

1. **Draft title**: Present progressive verb + goal
   - NOT imperative (Add, Fix, Implement)
   - Use progressive (Supporting, Fixing, Improving, Investigating)

2. **Draft body**:
   - Open with untitled paragraph explaining why this issue exists
   - Focus on desired outcome, not implementation steps
   - Include acceptance criteria as outcomes (if applicable)
   - Link related issues

3. **Follow template**: If user selected a template, structure content accordingly

## Step 6: Present for Review

Present the drafted issue title and body.

Use AskUserQuestion for confirmation:

- question: "Ready to create this issue?"
- header: "Create issue"
- options:
  - Create issue (Proceed with gh issue create)
  - Revise (Let me adjust the content)
  - Cancel (Exit without creating)

If "Create issue", execute `gh issue create` with the drafted content.
If "Revise", ask what to change and iterate.
