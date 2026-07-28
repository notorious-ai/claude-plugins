---
description: Guided interview for creating well-structured GitHub issues
allowed-tools: Read, Grep, Glob, Skill, Bash(gh:*), AskUserQuestion
disable-model-invocation: true
model: sonnet
---

# Draft GitHub Issue

Guide the user through creating an effective issue using the writing-issues skill. An issue lives entirely in the problem space. The interview gathers the problem's why, how, and what, then derives validation criteria from that context rather than from a guess about the solution.

## Step 1: Load Conventions and Check for Issue Templates

Invoke the writing-issues skill before asking anything. The conventions govern every question below, so they load first.

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

Probe for three distinct kinds of context. All three come from the problem space, and the writing-issues skill governs how each is written.

- **The friction and its cost** - what breaks down or goes unmet, who bears it, and what it costs to leave it alone
- **The constraints** - what any solution must live within: deadlines, operational limits, dependencies, and attempts that already failed. Put each one through the skill's constraint test before recording it.
- **The observable symptoms** - the visible pain that shows the problem is real: metrics, reproductions, incident records, complaint volumes. Record the numbers the user actually has, and none they do not.

Ask type-specific questions:

**Bug**: What were you trying to accomplish, and what does the failure cost you? What should have happened, and what happened instead? How reproducible is it, and how often does it occur? Does anything constrain a fix, such as supported versions or data that cannot be migrated?

**Feature**: What problem prompted this, and who lives with it today? What does going without cost them? What does that pain look like now - workarounds, drop-off, support volume? What must any solution respect?

**Task**: Why now, and what does delay cost? What signals the need - end-of-life dates, hours spent, incident counts? What bounds the work, such as downtime the business can absorb or interfaces others depend on?

**Discussion**: What decision is needed, and what forces it now? What evidence do others need in order to weigh in? What narrows the option space before anyone proposes anything?

If information is unavailable, use actionable placeholders: `[FILL: specific action to obtain this]`

## Step 4: Ask How Anyone Will Know

Validation comes after Step 3, never before it. There is nothing to read off the body until Step 3's context is on the table, and validation drafted early is a guess about the solution that the rest of the interview then rationalises.

Ask the user how anyone would know the why has been satisfied, then record the answer in whatever form it naturally takes. Most good issues answer this in a sentence or two of prose, not a checkbox list. Follow the Validation guidance in the writing-issues skill for what makes an answer hold up.

The interview earns its keep when the user wants a criterion the body cannot yet support. Ask them for the symptom, constraint, or risk it implies. Then record that answer in the body, not only in the validation.

The heading, if the answer takes a section of its own, is the author's call. The skill covers how to choose one.

## Step 5: Search for Related Issues

Check for duplicates or related work:
!`gh issue list --state all --limit 10 2>/dev/null || echo "Could not fetch issues"`

Ask if any existing issues relate. Prior attempts and discussions provide valuable context.

## Step 6: Draft Issue

Draft with the conventions loaded in Step 1:

1. **Title**: Present progressive verb + goal (think: "This issue is _____")
2. **Body**: Run inside-out. The friction first, then the constraints around it, then the symptoms as evidence, then the validation from Step 4. Link related work with context.

If Step 5 surfaced a prior attempt or a risk that Step 3 missed, add it to the body and check whether it changes the validation.

## Step 7: Present for Review

Present the drafted issue.

Use AskUserQuestion:

- question: "Ready to create this issue?"
- header: "Create issue"
- options:
  - Create issue (Proceed with gh issue create)
  - Revise (Let me adjust the content)
  - Cancel (Exit without creating)

If "Create issue", execute `gh issue create`. Avoid hard-wrapping paragraphs in the `--body` content; GitHub renders mid-paragraph newlines as literal line breaks.
If "Revise", ask what to change and iterate.
