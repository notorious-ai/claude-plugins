# Issue Body Structure

Issue bodies follow GitHub Flavored Markdown. Effective issues focus on the desired outcome rather than prescribing implementation steps. The assignee determines the "how"; the issue author specifies the "why" and "what."

## The Untitled Opening

The first paragraph immediately follows the issue title without a header. This paragraph establishes the context and motivation:

- Why this issue exists
- What problem or need it addresses
- Who is affected and how

When the title clearly conveys the goal, the opening can expand on context. When the title is ambiguous, the opening must clarify the intent.

## Prose Over Checklists

Write issue bodies as prose paragraphs that explain the goal and constraints. Avoid prescriptive task lists that dictate implementation:

**Avoid**:
```markdown
## Tasks
- [ ] Add new column to database
- [ ] Update API endpoint
- [ ] Modify frontend form
```

**Prefer**:
```markdown
User profiles currently lack timezone information, causing scheduled
notifications to arrive at inconvenient times. Users should be able
to specify their timezone so notifications respect their local time.
```

The first approach prescribes implementation. The second describes the outcome, leaving implementation to the assignee.

## When Checklists Are Appropriate

Checklists suit tracking multiple independent items or acceptance criteria:

**Tracking multiple items**:
```markdown
Several deprecated endpoints need removal before the v2.0 release:

- [ ] `/api/v1/users/legacy`
- [ ] `/api/v1/orders/old-format`
- [ ] `/api/v1/products/deprecated`
```

**Acceptance criteria** (outcomes, not steps):
```markdown
## Acceptance Criteria

- [ ] Users can specify timezone in profile settings
- [ ] Scheduled notifications respect user timezone
- [ ] Default timezone is inferred from browser when not set
```

The distinction: checklists track **what** needs to happen, not **how** to do it.

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

Bug reports benefit from structured reproduction information because debugging requires precise context.

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

Feature requests focus on the problem and user need, not the solution. Implementation details are for the PR.

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

Discussion issues frame the decision space rather than proposing solutions.

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

**Problem**: Dictates implementation, removes agency from assignee.

### Vague Goals

```markdown
Improve the search experience.
```

**Problem**: No specific outcome defined. What does "improve" mean?

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

**Problem**: Redis is a solution. What problem does it solve? Slow queries? High database load?

## Writing the "Why"

Surface the motivation by asking:

1. Who is affected by this issue?
2. What can they not do today?
3. What happens if this remains unaddressed?
4. What outcome would resolve this?

The answers form your prose.
