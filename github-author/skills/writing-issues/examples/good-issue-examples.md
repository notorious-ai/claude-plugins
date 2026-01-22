# Good Issue Examples

This file contains examples of effective issue titles and bodies. Each example demonstrates principles from the main skill:

- **Title**: Uses present progressive verbs (-ing form) to indicate ongoing work
- **Body**: Opens with motivation, focuses on outcome over implementation
- **Probe tags**: Show what targeted questions would surface the context that makes the issue effective

Use these examples to understand patterns, not as templates to fill in.

## Task Tracking

### Ongoing Effort

<example>
<context>
Tracking work to improve API documentation coverage across the codebase.
</context>

<probe>
- "Who is affected?" → New team members and external integrators
- "What's the impact?" → Difficult to understand endpoints and error conditions
- "What does done look like?" → Comprehensive docs for all public endpoints
</probe>

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

<probe>
- "Why now?" → EOL date in March 2025
- "What's the risk?" → No security updates after EOL
- "What does success look like?" → All auth flows work, no user-facing changes
</probe>

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

<probe>
- "What are users trying to do?" → Find historical orders
- "What's the error?" → RangeError in console
- "Is it consistent?" → Yes, always happens with >30 day range
</probe>

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

<probe>
- "How often does it happen?" → ~0.1% of orders
- "What's the business impact?" → Duplicate charges, inventory issues
- "What patterns exist?" → Two POST requests within 50ms
</probe>

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

<probe>
- "Who is affected?" → Users outside US timezones (40% of base)
- "What's the pain?" → Notifications arrive at 3 AM local time
- "How many complaints?" → ~20/month to support
</probe>

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

<probe>
- "What are the current metrics?" → P50: 4.2s, P95: 11.8s
- "What's the business impact?" → 15% abandonment rate
- "What's the target?" → P50 under 2s, P95 under 5s
</probe>

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

<probe>
- "What are the current pain points?" → Over-fetching, round-trips, versioning
- "What questions need answering?" → Migration path, rate limiting, tooling
- "Is there a preferred direction?" → No, genuinely open discussion
</probe>

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

## Architecture Issues

<example>
<context>
Current service boundaries causing operational problems.
</context>

<probe>
- "What's the current pain?" → Circular dependencies, deploy ordering issues
- "What does success look like?" → Independent deployment, clear ownership
- "What constraints exist?" → Must maintain API compatibility during transition
</probe>

<title>
Restructuring service boundaries for independent deployment
</title>

<body>
The current service architecture has evolved into tightly coupled
components that must be deployed together. The authentication service
depends on user-service which depends on auth for token validation,
creating a circular dependency that complicates deployments.

By the time this issue is complete, each service will have clear
ownership boundaries and can be deployed independently without
coordinating with other teams.

## Current Problems
- Deployments require coordinating 3 teams
- Circular dependency causes startup ordering issues
- Changes to shared types require synchronized releases

## Constraints
- Must maintain API compatibility for external integrations
- Cannot require downtime for migration
- Team capacity limits parallel work streams

See also:
- org/repo#345 (prior architecture discussion)
- [Service boundaries ADR][adr-services]

[adr-services]: https://docs.example.com/adr/0023-service-boundaries
</body>

<why_good>
Title describes the outcome (independent deployment). Body uses the
"By the time this issue is complete..." pattern for clear definition
of done. Constraints help future implementers understand boundaries.
</why_good>
</example>

## API Design Issues

<example>
<context>
Designing pagination approach for new list endpoints.
</context>

<probe>
- "What's driving this?" → New endpoints need consistent pagination
- "What are the options?" → Offset, cursor, keyset
- "What constraints exist?" → Must work with existing client libraries
</probe>

<title>
Defining pagination strategy for list endpoints
</title>

<body>
New list endpoints need a consistent pagination approach. The existing
endpoints use mixed strategies (some offset-based, some cursor-based),
causing confusion for API consumers and inconsistent client code.

By the time this issue is complete, we will have documented pagination
conventions that all new endpoints follow and a migration path for
existing endpoints.

## Options to Consider

**Offset-based**: Simple but problematic with concurrent modifications
**Cursor-based**: Handles modifications but opaque cursors frustrate debugging
**Keyset**: Predictable and efficient but requires sortable fields

## Requirements
- Must handle large result sets (100k+ items)
- Must work with existing client SDK patterns
- Should support both forward and backward navigation

## Questions
- Do we need to support sorting by arbitrary fields?
- How do we handle deleted items during pagination?
- What's our strategy for the "total count" problem?
</body>

<why_good>
Title describes what's being defined. Body presents options neutrally,
lists requirements as constraints, and poses questions for discussion.
No premature solution selection.
</why_good>
</example>

## Infrastructure Issues

<example>
<context>
Database performance degrading as data grows.
</context>

<probe>
- "What's the current state?" → P95 queries hitting 2s, was 200ms
- "What's the growth rate?" → 10x data in 18 months
- "What are the symptoms?" → Slow queries on large tables
</probe>

<title>
Addressing database performance degradation at scale
</title>

<body>
Query performance has degraded significantly as data volume has grown.
P95 query times have increased from 200ms to 2s over the past 18 months
as data volume grew 10x. The orders table alone contains 50M rows and
is growing by 1M/month.

By the time this issue is complete, P95 query times will be under 500ms
and the system will handle projected growth for the next 24 months.

## Observed Symptoms
- Orders list endpoint: 2s P95 (was 200ms)
- User dashboard: 1.5s P95 (was 150ms)
- Report generation: timing out for large date ranges

## Growth Projections
- Current: 50M orders, 10M users
- 12 months: 80M orders, 15M users
- 24 months: 120M orders, 25M users

## Constraints
- Cannot afford extended downtime for migrations
- Must maintain query compatibility for reporting tools
- Budget limits hardware-only solutions

Related: org/repo#678 (monitoring improvements)
</body>

<why_good>
Title describes the problem at the right level of abstraction. Body
quantifies current state and growth, uses definition of done pattern,
and lists constraints that will guide solution selection.
</why_good>
</example>

## Migration Issues

<example>
<context>
Moving from self-hosted Postgres to managed service.
</context>

<probe>
- "Why migrate?" → Operational burden, lack of expertise
- "What's the risk?" → Data loss, extended downtime
- "What's the timeline?" → Before current hardware EOL in Q2
</probe>

<title>
Migrating database to managed PostgreSQL service
</title>

<body>
The self-hosted PostgreSQL instance requires significant operational
attention and our team lacks deep database expertise. Recent incidents
(org/repo#890, org/repo#891) highlighted risks we're not equipped to
manage.

By the time this issue is complete, production data will run on a
managed PostgreSQL service with automated backups, monitoring, and
failover capabilities.

## Drivers
- Two incidents in past quarter requiring emergency response
- Hardware reaches end-of-life in Q2, forcing a decision
- Team spending 20+ hours/month on database maintenance

## Success Criteria
- [ ] Zero data loss during migration
- [ ] Maximum 15 minutes of read-only downtime
- [ ] Automated daily backups with point-in-time recovery
- [ ] Monitoring and alerting configured

## Out of Scope
- Schema optimizations (separate issue)
- Application-level caching changes
- Connection pooling improvements

See also: org/repo#890, org/repo#891 (recent incidents)
</body>

<why_good>
Title describes the migration outcome. Body explains drivers (incidents,
timeline, operational burden), uses definition of done pattern, and
explicitly scopes out related but separate work.
</why_good>
</example>
