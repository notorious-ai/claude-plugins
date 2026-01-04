---
name: Writing Issues
description: Activates when the user asks to "write an issue", "draft an issue", "create a GitHub issue", "file a bug report", "submit a feature request", "track this work", or "open an issue". Also triggers proactively when preparing to create an issue with `gh issue create` or when discussing work that should be tracked. Covers issue authoring for bugs, features, tasks, and discussions.
---

# Writing Issues

Effective issues focus on the **why** over the **how**. They describe desired outcomes rather than prescribing implementation steps. The issue author specifies what needs to happen; the assignee determines how to accomplish it.

## Core Principle: Ongoing Efforts

Issues track ongoing work. The title reflects this with present progressive verbs - work that is happening, not a command to execute.

**Think**: "This issue is _____ (verb+ing)"

| Imperative (avoid) | Present Progressive (prefer) |
|--------------------|------------------------------|
| Add timezone support | Supporting user timezone preferences |
| Fix search crash | Fixing search crash on large date ranges |
| Implement caching | Improving response times for frequent queries |
| Remove deprecated API | Removing legacy v1 API endpoints |

The imperative mood suits PRs (commands that execute on merge). Present progressive suits issues (work in progress).

## Title Structure

Issue titles use present progressive, beginning with a meaningful verb:

**Format**: `<Verb+ing> <what is being accomplished>`

- Begin with present progressive verb (-ing form)
- Describe the goal or outcome being worked toward
- Keep concise but descriptive
- Avoid labels in the title (use GitHub labels instead)

**Examples by type**:
- Feature: `Supporting user timezone preferences`
- Bug: `Fixing search crash on large date ranges`
- Task: `Migrating authentication to passport-next`
- Investigation: `Investigating duplicate order submissions`
- Discussion: `Evaluating GraphQL migration for public API`

## Gathering Context

Before drafting an issue, gather context:

### From the Conversation

Draw from the discussion that surfaced the need:

1. What problem or need was identified?
2. Who is affected and how?
3. What constraints exist?
4. What outcome would resolve this?

When context is incomplete, ask proactively. The motivation behind an issue is essential for effective tracking.

### From the Repository

Check for existing context:

1. Search open issues for related or duplicate work
2. Review recently closed issues for prior attempts
3. Check for issue templates in `.github/ISSUE_TEMPLATE/`

Use `gh issue list` to discover related work. Reference relevant issues to connect efforts.

## Body Philosophy

The body explains **why** this issue exists and **what** outcome is needed. Leave the **how** to the assignee.

The first paragraph immediately follows the title without a header. This opening establishes context and motivation.

### Prose Over Checklists

Describe goals and constraints as prose. Avoid prescriptive task lists:

**Avoid**:
```markdown
- [ ] Add database column
- [ ] Update API endpoint
- [ ] Modify frontend form
```

**Prefer**:
```markdown
User profiles lack timezone information, causing scheduled notifications
to arrive at inconvenient times. Users should be able to specify their
timezone so notifications respect their local time.
```

The first prescribes implementation. The second describes the outcome.

### When Checklists Are Appropriate

Checklists suit tracking scope or acceptance criteria as **outcomes**:

```markdown
## Acceptance Criteria

- [ ] Users can specify timezone in profile settings
- [ ] Scheduled notifications respect user timezone
- [ ] Default timezone inferred from browser when not set
```

These are outcomes to achieve, not steps to implement.

### Definition of Done

Include a clear outcome statement. The pattern "By the time this Issue is complete, the system will have..." works well for defining scope and completion criteria.

**Examples**:
- "By the time this Issue is complete, users will be able to specify their timezone so notifications respect their local time."
- "By the time this Issue is complete, the API will validate all input before processing."

This framing forces clarity about what "done" means and helps prevent scope creep.

## Issue Templates

Before creating an issue, check for templates in `.github/ISSUE_TEMPLATE/`. Templates encode repository-specific conventions. When a template applies to the issue type, follow its structure.

## Type-Specific Guidance

While uniform principles apply to all issues, certain types benefit from specific context. Consult `references/body-structure.md` for detailed guidance on:

- **Bug reports**: Environment, reproduction steps, expected vs actual behavior
- **Feature requests**: User impact, success criteria
- **Discussion issues**: Decision framing, questions to consider

## Follow-up Tasks

When an issue identifies post-completion work, list it clearly at the end. See `references/body-structure.md` for formatting.

## Workflow

When creating an issue:

1. **Gather context**: Understand the problem, who is affected, and desired outcome
2. **Search for related work**: Check open/closed issues for duplicates or related efforts
3. **Check templates**: Use repository templates when applicable
4. **Draft title**: Present progressive verb + goal (not imperative)
5. **Write body**: Focus on why and what, link related work
6. **Review**: Does the title reflect ongoing work? Does the body describe outcome over implementation?

## Reference Files

For detailed guidance, consult:

| File | Contains |
|------|----------|
| `references/body-structure.md` | Body format, prose flow, type specializations, anti-patterns |
| `examples/issue-examples.md` | Complete issue examples with titles and bodies |

## Validation Checklist

Before presenting the issue:

**Title**:
- [ ] Uses present progressive verb (-ing form)
- [ ] Describes goal or outcome, not developer action
- [ ] Avoids labels or type prefixes (use GitHub labels)

**Body**:
- [ ] Opens with untitled paragraph explaining why
- [ ] Focuses on desired outcome, not implementation steps
- [ ] Links related issues using full short syntax (`org/repo#123`)
- [ ] Uses checklists for scope/criteria, not implementation steps
- [ ] Follows repository template when applicable
