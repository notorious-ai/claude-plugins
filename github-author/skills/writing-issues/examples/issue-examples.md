# Issue Examples

Complete examples showing effective issue titles and bodies.

## Task Tracking Issues

### Ongoing Effort

<example>
<context>
Tracking work to improve API documentation coverage across the codebase.
</context>

<title>
Improving API documentation coverage
</title>

<body>
Several API endpoints lack adequate documentation, making it difficult
for new team members and external integrators to understand expected
behavior and error conditions.

The goal is comprehensive documentation for all public endpoints,
including request/response schemas, authentication requirements, and
example usage.

## Scope

- [ ] Authentication endpoints (`/auth/*`)
- [ ] User management endpoints (`/users/*`)
- [ ] Order processing endpoints (`/orders/*`)
- [ ] Webhook configuration endpoints (`/webhooks/*`)

Related discussion: org/repo#234
</body>

<why_good>
Title uses present progressive ("Improving") to indicate ongoing work.
Body explains the problem (lack of docs, impact on adoption) and desired
outcome (comprehensive docs). Checklist tracks scope, not implementation steps.
</why_good>
</example>

### Specific Task

<example>
<context>
Migrating from deprecated authentication library before EOL.
</context>

<title>
Migrating authentication to passport-next
</title>

<body>
The current authentication library `passport-legacy` reaches end-of-life
in March 2025 and will no longer receive security updates. Production
systems must migrate before this date.

`passport-next` provides equivalent functionality with improved security
defaults and active maintenance.

## Acceptance Criteria

- [ ] All authentication flows work with new library
- [ ] Session handling remains compatible
- [ ] No user-facing changes to login experience

Depends on org/repo#567 (configuration refactoring)
</body>

<why_good>
Title indicates the migration work. Body explains urgency (EOL date),
the alternative, and success criteria as outcomes not steps.
</why_good>
</example>

## Bug Reports

### Clear Reproduction

<example>
<context>
Search crashes when date range exceeds 30 days.
</context>

<title>
Fixing search crash on large date ranges
</title>

<body>
The search results page crashes when users filter by date ranges
spanning more than 30 days. Users attempting to find historical
orders cannot complete their task.

## Environment
- Browser: Chrome 120
- OS: macOS 14.2
- Account type: Standard user

## Steps to Reproduce
1. Navigate to /search
2. Set date range filter to span > 30 days
3. Click "Apply Filters"

## Expected Behavior
Results should display orders within the date range.

## Actual Behavior
Page displays "Something went wrong" error. Console shows:
`RangeError: Maximum call stack size exceeded`
</body>

<why_good>
Title uses present progressive of fixing action. Body provides clear
reproduction steps, environment details, and contrast between expected
and actual behavior.
</why_good>
</example>

### Intermittent Issue

<example>
<context>
Race condition causes occasional duplicate order submissions.
</context>

<title>
Investigating duplicate order submissions
</title>

<body>
Customer support reports occasional duplicate orders appearing in the
system. Users click "Submit" once but two orders are created. This
affects approximately 0.1% of orders based on the past month's data.

The pattern suggests a race condition when users double-click or when
network latency causes retry behavior. The impact is significant:
duplicate charges, inventory discrepancies, and customer frustration.

## Known Occurrences
- Order #12345 on 2024-01-15 (user confirmed single click)
- Order #12389 on 2024-01-16 (detected by inventory mismatch)
- Order #12402 on 2024-01-17 (customer complaint)

## Investigation Notes
Request logs show two POST requests within 50ms for affected orders.
</body>

<why_good>
Title uses "Investigating" for issues requiring discovery. Body quantifies
the problem, describes impact, and provides investigation starting points
without prescribing solutions.
</why_good>
</example>

## Feature Requests

### User-Driven Need

<example>
<context>
Users request timezone support for scheduled notifications.
</context>

<title>
Supporting user timezone preferences
</title>

<body>
Users in different timezones receive scheduled notifications at
inconvenient times. A user in Tokyo receives "daily summary" emails
at 3 AM local time because the system uses UTC.

Enabling timezone preferences would let users receive notifications
at appropriate local times. This is particularly important for the
upcoming scheduled reports feature.

## User Impact
- 40% of active users are outside US timezones
- Support receives ~20 complaints/month about notification timing

Related: org/repo#890 (scheduled reports feature)
</body>

<why_good>
Title describes the capability to support. Body explains the problem
from user perspective, quantifies impact, and links to related work.
No implementation prescription.
</why_good>
</example>

### Performance Need

<example>
<context>
Dashboard load times affecting user experience.
</context>

<title>
Reducing dashboard load time
</title>

<body>
The main dashboard takes 8-12 seconds to load for users with large
datasets (>10k records). Analytics show 15% of users abandon the
page before it finishes loading.

Target performance: dashboard loads within 2 seconds for typical
users, with progressive loading for large datasets.

## Current Metrics
- P50 load time: 4.2s
- P95 load time: 11.8s
- Abandonment rate: 15%

## Success Criteria

- [ ] P50 load time under 2 seconds
- [ ] P95 load time under 5 seconds
- [ ] Large datasets show progressive loading indicator
</body>

<why_good>
Title describes the goal (reducing load time). Body quantifies the
problem with metrics and defines success criteria as measurable
outcomes.
</why_good>
</example>

## Discussion Issues

<example>
<context>
Evaluating API strategy change.
</context>

<title>
Evaluating GraphQL migration for public API
</title>

<body>
We're considering migrating from REST to GraphQL for the public API.
This issue collects thoughts and concerns before deciding.

## Context
Current pain points with REST:
- Over-fetching on mobile clients (bandwidth concerns)
- Multiple round-trips for related data
- Versioning complexity across 3 major versions

## Potential Benefits
- Clients request exactly what they need
- Single endpoint simplifies routing
- Strong typing via schema

## Questions to Consider
- What's the migration path for existing integrations?
- How does this affect rate limiting strategy?
- What tooling do we need for schema management?
- Should we support both REST and GraphQL during transition?

Please share thoughts and concerns in comments.
</body>

<why_good>
Title uses "Evaluating" for exploratory discussions. Body frames the
decision space without advocating a position. Questions invite input
rather than seeking validation.
</why_good>
</example>

## Title Patterns

### Present Progressive Verbs

Issues track ongoing work. Titles use present progressive to reflect this:

| Work Type | Verb Pattern | Example |
|-----------|--------------|---------|
| New capability | Supporting, Enabling | Supporting user timezone preferences |
| Improvement | Improving, Enhancing, Optimizing | Improving API documentation coverage |
| Fix | Fixing, Resolving, Addressing | Fixing search crash on large date ranges |
| Migration | Migrating, Upgrading, Transitioning | Migrating authentication to passport-next |
| Removal | Removing, Deprecating, Retiring | Removing legacy v1 API endpoints |
| Investigation | Investigating, Analyzing, Exploring | Investigating duplicate order submissions |
| Evaluation | Evaluating, Considering, Assessing | Evaluating GraphQL migration |

### Anti-Patterns

| Bad | Problem | Better |
|-----|---------|--------|
| Add timezone | Imperative, not progressive | Supporting user timezone preferences |
| Bug: search crashes | Label in title | Fixing search crash on large date ranges |
| Performance | Too vague | Reducing dashboard load time |
| Implement caching | Developer action, not outcome | Improving response times for frequent queries |
| #123 follow-up | No meaning without context | Completing authentication refactoring |

## Relating Issues to PRs

When a PR addresses an issue, the PR description links back using `Closes org/repo#123`.

### Timeline References

PRs and issues that mention this issue appear in the issue timeline as events (e.g., "X mentioned this issue in PR #123"). This automatic cross-referencing requires no markdown.

### Explicit Progress Tracking

For issues spanning multiple PRs, a dedicated comment can consolidate progress. When PR references appear in bullet lists, GitHub renders them with colored status indicators (green/purple/red), making coarse status visible at a glance:

```markdown
## Progress

- org/repo#456
- org/repo#457
- org/repo#458 (blocked on security review)
```

The colored indicators show merged/open/closed status. Add parenthetical notes only for fine-grained information the indicators don't convey (deployment state, blockers, etc.).
