# Issue Anti-Patterns

This file documents common mistakes in issue titles and bodies. Each anti-pattern includes:

- **Pattern**: What the problematic issue looks like
- **Problem**: Why this is ineffective
- **Better**: How to improve it

Use this file to recognize anti-patterns in drafts and understand why they fail.

## Title Anti-Patterns

### Imperative Mood

Issue titles that use imperative verbs (commands) instead of present progressive (ongoing work).

| Bad Title | Problem | Better Title |
|-----------|---------|--------------|
| Add timezone support | Imperative - sounds like a PR | Supporting user timezone preferences |
| Fix search crash | Imperative - sounds like a PR | Fixing search crash on large date ranges |
| Implement caching | Imperative - sounds like a PR | Improving response times with caching |
| Remove deprecated API | Imperative - sounds like a PR | Removing legacy v1 API endpoints |
| Update documentation | Imperative and vague | Improving API documentation coverage |

**Why this matters**: Imperative mood suits PRs (commands that execute on merge). Present progressive indicates ongoing work tracked by the issue. This distinction helps readers understand whether they're looking at a task definition or a proposed solution.

### Task-Like Titles for Small Items

Creating standalone issues for work that belongs in a parent issue's checklist.

| Bad | Problem | Better Approach |
|-----|---------|-----------------|
| Update button color to blue | Too granular for standalone issue | Add to parent issue "Refreshing UI design" |
| Fix typo in error message | Single-line change, no context needed | Add to parent issue or just fix in a PR |
| Add semicolon to line 42 | Implementation detail, not tracked work | Just fix it |
| Rename variable | Trivial refactoring | Add to parent issue "Improving code clarity" |

**When standalone issues are appropriate**: When the work requires discussion, has acceptance criteria, or needs to be assigned and tracked independently.

**When checklists are better**: When multiple small items are part of a larger effort and don't need individual discussion or assignment.

### Labels in Titles

Including type labels or prefixes that GitHub labels should handle.

| Bad | Problem | Better |
|-----|---------|--------|
| Bug: search crashes | Label in title | Fixing search crash on large date ranges |
| [Feature] Timezone support | Bracket prefix | Supporting user timezone preferences |
| URGENT: Fix auth issue | Priority in title | Fixing authentication timeout (use GitHub labels for priority) |
| Performance - dashboard slow | Label prefix | Reducing dashboard load time |

**Why this matters**: GitHub provides labels for categorization. Putting labels in titles clutters them and creates inconsistency. Use labels for filtering and titles for describing the work.

### Vague Titles

Titles that don't describe what work is actually being done.

| Bad | Problem | Better |
|-----|---------|--------|
| Improve performance | What performance? Where? | Reducing dashboard load time |
| Fix bug | Which bug? | Fixing search crash on large date ranges |
| Update code | What code? Why? | Migrating authentication to passport-next |
| Make it better | Meaningless | Improving error messages for clarity |
| Various improvements | Multiple unrelated items | (Split into separate issues) |

**Why this matters**: Vague titles waste readers' time and create useless issue history. A year from now, "Fix bug" tells you nothing about what was done.

## Body Anti-Patterns

### Implementation Prescription

Dictating how to solve the problem instead of describing the desired outcome.

```markdown
## Solution
Add a `timezone` column to the users table, update the User model,
modify the API to accept timezone in profile updates, and add a
timezone selector to the settings page using react-timezone-picker.
```

**Problem**: Removes agency from the assignee. They might find a better approach, but the issue has already committed to implementation details.

**Better**: Describe the outcome needed and let the implementer determine the approach.

```markdown
Users in different timezones receive scheduled notifications at
inconvenient times. A user in Tokyo receives "daily summary" emails
at 3 AM local time because the system uses UTC.

By the time this issue is complete, users will be able to specify
their timezone so notifications respect their local time.
```

### Vague Goals

Issues that don't define what success looks like.

```markdown
Improve the search experience.
```

**Problem**: What does "improve" mean? Faster? More relevant results? Better UI? Without specifics, the issue can never be closed because there's always more to improve.

**Better**: Define measurable outcomes or specific problems to solve.

```markdown
Search results load slowly (8-12 seconds) for users with large datasets,
causing 15% to abandon the page. By the time this issue is complete,
search will return results within 2 seconds for typical queries.
```

### Feature as Bug

Framing missing functionality as a defect.

```markdown
## Bug
There's no dark mode.
```

**Problem**: Missing functionality isn't a bug - it's a feature request. Bugs describe incorrect behavior; features describe new capability. Mislabeling confuses triage and metrics.

**Better**: Frame as a feature request explaining the need.

```markdown
Users working at night report eye strain from the bright interface.
Supporting a dark mode would improve comfort for users who work in
low-light environments.
```

### Solution Masquerading as Problem

Stating a solution without explaining the underlying need.

```markdown
We need to add a Redis cache.
```

**Problem**: Redis is a solution. What problem does it solve? Without understanding the actual need, someone might implement Redis when a simpler solution would suffice.

**Better**: Describe the problem, let the solution emerge from discussion.

```markdown
Dashboard queries are hitting the database 50 times per page load,
causing 4-second load times. The same data is requested repeatedly
within a session, suggesting caching would help.
```

### Missing Motivation

Jumping straight to requirements without explaining why.

```markdown
## Requirements
- Support timezones for user profiles
- Add timezone selector to settings
- Update notification service to use user timezone
```

**Problem**: No motivation explains why this matters. Without context, readers can't evaluate priority or suggest alternatives.

**Better**: Lead with the problem and its impact.

```markdown
Users in different timezones receive scheduled notifications at
inconvenient times. A user in Tokyo receives "daily summary" emails
at 3 AM local time because the system uses UTC.

40% of active users are outside US timezones and support receives
~20 complaints/month about notification timing.
```

### Implementation Steps as Body

Using the issue body to document implementation approach.

```markdown
## Steps
1. Create migration for timezone column
2. Update User model with timezone field
3. Add API endpoint for timezone update
4. Build frontend component
5. Write tests
```

**Problem**: This belongs in a PR or technical design doc, not the issue. Issues describe outcomes; PRs and docs describe implementation.

**Better**: Focus on what needs to happen, not how.

```markdown
By the time this issue is complete, users will be able to specify
their timezone so notifications respect their local time.

## Acceptance Criteria
- [ ] Users can select timezone in profile settings
- [ ] Notifications are sent at user's local time
- [ ] Default timezone is inferred from browser
```

### Duplicate Information

Repeating the title in the body.

```markdown
Title: Supporting user timezone preferences

Body: This issue is for supporting user timezone preferences.
We need to add support for user timezone preferences...
```

**Problem**: Wastes reader's time. The body should add context, not echo the title.

**Better**: The body should immediately provide information the title cannot.

```markdown
Title: Supporting user timezone preferences

Body: Users in different timezones receive scheduled notifications
at inconvenient times. A user in Tokyo receives "daily summary"
emails at 3 AM local time because the system uses UTC...
```
