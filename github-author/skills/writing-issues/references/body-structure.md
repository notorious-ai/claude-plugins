# Issue Bodies by Type

The characteristics in `SKILL.md` apply to every issue. This file adds what readers of each issue type additionally expect, plus GitHub linking and formatting conventions. Expectations are not templates: include a section when it carries real content for this issue, and omit it when it would be an empty heading.

## Bug Reports

Readers of a bug report expect to see the conditions under which the symptom appears and the symptom itself, concretely enough to reproduce:

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

All four sections are problem-space what: `Environment` and `Steps to Reproduce` record the conditions, `Actual Behavior` records the symptom, and together they let anyone else see the problem. The opening paragraph still carries the why — here, a user who cannot complete their task.

`Expected Behavior` is `Actual Behavior` inverted, which is why a short bug report rarely needs a separate validation section: the criterion is that actual becomes expected. A short report may also lead with the symptom rather than the friction, since triage and deduplication both start from the symptom.

## Feature Requests

Readers of a feature request expect to find the voiced need: who asked, what they cannot do today, and how the request arrived:

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

Feature requests are why-led, with the what supplied by voiced need. `User Stories` are problem space: each names a person and something they cannot do today, which is evidence rather than design. A sketched shape ("grouping or folders") describes the outcome and stays on the right side of the boundary only while it stays that coarse. Tables, components, and endpoints belong in the PR.

## Discussion Issues

Readers of a discussion issue expect the decision to be framed before anyone proposes an answer:

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

## Linking Related Work

Weave links into prose with the reason each one matters:

```markdown
A prior attempt to add timezone support (org/repo#234) was abandoned
due to database migration complexity. The [timezone handling RFC][tz-rfc]
outlines the architectural approach we've since agreed on.

[tz-rfc]: https://docs.example.com/rfcs/timezone-handling
```

When several resources don't fit naturally in prose, a brief annotated list works:

```markdown
## Background

- org/repo#234 (prior attempt, abandoned due to migration complexity)
- org/repo#567 (notification system discussion that surfaced this need)
```

Avoid ending issues with a bare "See also" dump. If a link is worth including, it is worth one clause explaining why.

Conventions:

- Prefer reference-style links (`[text][anchor]` with `[anchor]: url` at the bottom) over inline links.
- Wrap bare URLs in angle brackets: `<https://...>`.
- Reference issues and PRs with the full short syntax: `org/repo#123`.
- For tracking relationships, use the keywords GitHub understands: `Relates to org/repo#123`, `Depends on org/repo#123`, `Blocked by org/repo#123`.

## Follow-up Tasks

When an issue identifies post-completion work, list it at the end of the body:

```markdown
The following tasks are important to tidy after completion:

- [ ] Rename labels on GitHub
- [ ] Port documentation changes to external docs site
- [ ] Notify dependent teams of the change
```
