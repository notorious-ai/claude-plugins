# Issue Body Structure

Issue bodies follow GitHub Flavored Markdown. Every part of a body carries some piece of the problem's why, how, or what.

A body runs inside-out: why first, then how, then what, with validation flowing from the what. Symptoms presented before the friction read as a work list. Symptoms presented after it read as evidence.

## The Untitled Opening

The first paragraph immediately follows the issue title without a header. This paragraph establishes the context and motivation:

- Why this issue exists
- What problem or need it addresses
- Who is affected and how

When the title clearly conveys the goal, the opening can expand on context. When the title is ambiguous, the opening must clarify the intent.

## Questions That Surface the Trio

Interrogate the conversation until every element of the trio has an answer. The answers form your prose. A question left unanswered is either a probe to put to the user or a `[FILL: ...]` placeholder naming how to obtain it.

**The why**, the problem core:

1. Who is affected by this issue?
2. What can they not do today?
3. What happens if this remains unaddressed?
4. Who else absorbs the cost, and where does it land?

**The how**, the constraints:

1. What is already true about the world that any solution has to accommodate? A deadline qualifies, and so does team size.
2. Has this been attempted before, and what did that attempt run into?
3. What is deliberately out of scope here?

**The what**, the evidence:

1. What does the problem look like when it happens, in the terms the affected person would use?
2. How often, to how many, and since when?
3. What record already exists?
4. What is suspected rather than measured?

A symptom you cannot yet quantify still belongs in the body, labelled as suspected, because the label is what later keeps the matching criterion honest.

## Scope Enumeration

A checklist is the clearest form for naming the units of problem surface an issue covers:

```markdown
Several deprecated endpoints need removal before the v2.0 release:

- [ ] `/api/v1/users/legacy`
- [ ] `/api/v1/orders/old-format`
- [ ] `/api/v1/products/deprecated`
```

This is problem-space what: the extent of the problem, enumerated. The endpoints above say how far the problem reaches, not what will be true once it is resolved.

## Validating the Why

Criteria are the problem's what in future tense. Write the body first, then read them off it; `SKILL.md` states the check.

A definition of done does not need a checklist. Often it is one or two sentences, the whole why stated as resolved:

```markdown
Scheduled notifications go out on UTC because profiles carry no timezone.
A user in Tokyo receives their "daily summary" at 3 AM local time, and
support logs roughly 20 complaints a month about notification timing.

By the time this issue is complete, a Tokyo user's daily summary arrives
during their morning instead of overnight, and notification-timing
complaints have fallen from ~20/month toward zero across a full support
cycle.
```

Reach for a checklist instead when the why breaks into several independently checkable pieces; `SKILL.md`'s own timezone example shows that form.

## Issue Type Specializations

While uniform principles apply to all issues, certain types benefit from specific context.

### Bug Reports

Bug reports describe unexpected behavior:

```markdown
The search results page crashes when filtering by date range spanning
more than 30 days. Users attempting to find historical orders cannot
complete their task.

## Environment
- Browser: Chrome 120
- OS: macOS 14.2

## Steps to Reproduce
1. Navigate to /search
2. Set date range filter to span > 30 days
3. Click "Apply Filters"

## Expected Behavior
Results should display orders within the date range.

## Actual Behavior
Page displays "Something went wrong" error.
```

Every one of those four sections is problem-space what. `Environment` and `Steps to Reproduce` record the conditions under which the symptom appears; `Actual Behavior` records the symptom itself. Together they are the evidence that the problem is real and the means for anyone else to see it. The opening paragraph still carries the why, here a user who cannot complete their task.

`Expected Behavior` is `Actual Behavior` inverted, which is why a short bug report rarely needs a separate validation section. The criterion is that actual becomes expected. A short report may also lead with the symptom rather than the friction. Triage and deduplication both start from the symptom, so the inside-out order gives way here.

### Feature Requests

Feature requests describe a need or opportunity:

```markdown
Power users managing multiple projects have expressed difficulty
switching between contexts. Currently, all projects appear in a
single list without organization.

Enabling project grouping or folders would help users organize
their work by client, priority, or whatever scheme suits their
workflow.

## User Stories
- As a freelancer, I want to group projects by client
- As a team lead, I want to separate active from archived projects
```

Feature requests are why-led, with the what supplied by voiced need. `User Stories` are problem space: each one names a person and something they cannot do today, which is evidence rather than design. The sketched shape ("grouping or folders") describes the outcome, and it stays on the right side of the boundary only while it stays that coarse. Tables, components, and endpoints belong in the PR.

### Discussion Issues

Discussion issues explore decisions or gather input:

```markdown
We're considering migrating from REST to GraphQL for the public API.
This issue collects thoughts and concerns before deciding.

## Context
Current pain points with REST:
- Over-fetching on mobile clients
- Multiple round-trips for related data
- Versioning complexity

## Questions to Consider
- What's the migration path for existing integrations?
- How does this affect rate limiting strategy?
- What tooling do we need for schema management?
```

Discussion issues are how-heavy. The framing sentence supplies the why, `Context` supplies the what (the pain points that make a decision necessary), and `Questions to Consider` map the how: the constraints and trade-offs any answer has to satisfy. The questions frame the decision space instead of proposing a solution, which is the whole job of the type.

## Link Formatting

Prefer reference-style links (`[text][anchor]` with `[anchor]: url` at the bottom) over inline links.

When URLs appear as text, wrap in angle brackets: `<https://...>`.

GitHub issues and PRs use the full short syntax: `org/repo#123`.

## Issue Templates

Before creating an issue, check for templates in the repository:

- `.github/ISSUE_TEMPLATE/` directory
- `.github/ISSUE_TEMPLATE.md` file

Templates encode repository-specific conventions. When a template exists and applies to the issue type, follow its structure. When no template applies, use the general principles in this guide.

## Relating to Other Work

Link related issues, PRs, and discussions within the prose:

```markdown
This builds on the authentication refactoring in org/repo#456 and
addresses the performance concerns raised in org/repo#789.
```

For tracking relationships, use GitHub keywords:

- `Relates to org/repo#123` - indicates relationship
- `Depends on org/repo#123` - indicates blocking dependency
- `Blocked by org/repo#123` - indicates this issue is blocked

## Follow-up Tasks

When issues identify post-completion work, list it clearly:

```markdown
The following tasks are important to tidy after completion:

- [ ] Rename labels on GitHub
- [ ] Port documentation changes to external docs site
- [ ] Notify dependent teams of the change
```

Use checkboxes for trackable items. Place at the end of the issue body, after the main content.

## Linking Related Resources

Every navigable resource mentioned in an issue should be properly linked. Prefer weaving links into prose where they support the narrative:

```markdown
A prior attempt to add timezone support (org/repo#234) was abandoned
due to database migration complexity. The [timezone handling RFC][tz-rfc]
outlines the architectural approach we've since agreed on.

[tz-rfc]: https://docs.example.com/rfcs/timezone-handling
```

When multiple resources don't fit naturally in prose, a brief list is acceptable:

```markdown
## Background

- org/repo#234 (prior attempt, abandoned due to migration complexity)
- org/repo#567 (notification system discussion that surfaced this need)
```

**Avoid** ending issues with a generic "See also" dump. If a link is worth including, it's worth explaining why it matters.

## Common Anti-Patterns

### Implementation Prescription

```markdown
## Solution
Add a `timezone` column to the users table, update the User model,
modify the API to accept timezone in profile updates...
```

**Problem**: This is the solution's what: columns, models, endpoints. It removes agency from the assignee and forecloses approaches nobody has proposed yet.

### Vague Goals

```markdown
Improve the search experience.
```

**Problem**: No specific outcome defined. What does "improve" mean? A vague why is fatal, because nothing downstream can be aimed at it. A loose validation criterion is not the same fault: once the why is clear, a criterion may stay as imprecise as the evidence behind it.

### Feature as Bug

```markdown
## Bug
There's no dark mode.
```

**Problem**: Missing functionality isn't a bug. Frame as feature request.

### Solution Masquerading as Problem

```markdown
We need to add a Redis cache.
```

**Problem**: Redis is a solution. What problem does it solve? Slow queries? High database load? The same disguise turns up in constraint clothing ("constraint: must use Redis"), and one test strips it either way: the assignee could pick something else, so it is a choice.
