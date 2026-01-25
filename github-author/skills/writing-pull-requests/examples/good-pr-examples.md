# Good PR Examples

This file contains examples of effective pull request titles and descriptions. Each example demonstrates principles from the main skill:

- **Title**: Uses repository-capability verbs (what the code does), not developer-action verbs (what you did)
- **Description**: Opens with outcome or motivation, explains the "why" the diff cannot convey
- **Probe tags**: Show what targeted questions would surface the context that makes the PR effective

Use these examples to understand patterns, not as templates to fill in.

## Library Enhancement

<example>
<context>
Adding support for parsing MAC addresses without separators (e.g., "00005e005301")
to align with IEEE EUI guidelines and Azure Instance Metadata Service format.
</context>

<probe>
- "What real-world system uses this format?" → Azure IMDS
- "What standard permits this?" → IEEE EUI guidelines
</probe>

<title>
Parse MAC addresses without separators
</title>

<description>
IEEE EUI guidelines permit MAC addresses as pure hex without separators
(e.g., "00005e005301"). Azure Instance Metadata Service uses this format,
but `ParseMAC` only accepted colon, hyphen, or dot separators.

The parser now recognizes separator-less format by validating even length
and checking for valid sizes (6, 8, or 20 bytes).

Closes org/net#234
</description>

<why_good>
Title verb "Parse" describes what the package now does. Description explains
the real-world need (Azure IMDS) and the technical gap being filled.
</why_good>
</example>

## Backend Feature

<example>
<context>
Adding rate limiting to authentication endpoints to prevent brute-force attacks.
No existing issue - discovered during security review.
</context>

<probe>
- "How was this discovered?" → Security review
- "What evidence exists of the problem?" → Production logs show attack patterns
- "What outcome does this achieve?" → Prevents brute-force while preserving legitimate access
</probe>

<title>
Limit authentication attempts to prevent brute-force attacks
</title>

<description>
Security review identified that authentication endpoints accept unlimited
attempts, making the system vulnerable to credential stuffing and brute-force
attacks. Production logs show several IPs making thousands of attempts per hour.

The rate limiter tracks attempts per IP using a sliding window algorithm.
After 5 failed attempts within 15 minutes, subsequent attempts receive
HTTP 429 with a Retry-After header. Legitimate users are unaffected under
normal usage patterns.

Configuration is via environment variables to allow tuning per environment.
The staging deployment shows the limiter triggering correctly without
impacting normal login flows.

Proof: org/backend#789 (comment)
</description>

<why_good>
Title describes the repository's new capability, not developer action.
Description provides context that would have been in an issue: how the
problem was discovered, its impact, and the solution approach.
</why_good>
</example>

## Simple Bug Fix

<example>
<context>
Fixing a nil pointer panic when serializing users with no email address.
Issue exists with reproduction steps.
</context>

<probe>
- "What causes users to lack emails?" → Created before email requirement
- "Is there a linked issue?" → Yes, context lives there
</probe>

<title>
Handle nil email addresses in user serialization
</title>

<description>
Users created before the email requirement was added lack email addresses,
causing panics during JSON serialization.

Closes org/backend#456
</description>

<why_good>
Title verb "Handle" describes behavior change. Brief description because
the issue contains full context and reproduction steps.
</why_good>
</example>

## Complex Bug Fix

<example>
<context>
Fixing a race condition in the connection pool that caused intermittent
connection leaks under high load.
</context>

<probe>
- "What is the race condition?" → Cleanup vs Acquire timing
- "How was this verified?" → 24-hour load test with metrics
- "What's the fix approach?" → Serialize with existing mutex
</probe>

<title>
Serialize connection pool cleanup to prevent leaks
</title>

<description>
Under high load, the connection pool leaked connections due to a race
between the cleanup goroutine and concurrent Acquire calls. The cleanup
routine could mark a connection as available while Acquire was returning
it to a caller, resulting in the same connection being used by two goroutines.

The fix serializes cleanup operations with a mutex that Acquire already
holds, ensuring connections transition atomically between states.

Load testing with 1000 concurrent connections over 24 hours shows zero
leaked connections, compared to ~50/hour before the fix.

Closes org/backend#789

Proof: org/backend#789 (comment)
</description>

<why_good>
Title describes the corrective behavior ("Serialize...to prevent").
Description explains the race condition clearly, the fix approach, and
provides quantitative proof of the improvement.
</why_good>
</example>

## Refactoring

<example>
<context>
Extracting user authentication into a dedicated service to improve
testability and prepare for SSO integration.
</context>

<probe>
- "Why now?" → SSO integration requires central auth path
- "What changes behaviorally?" → Nothing - tests pass unchanged
- "What does this enable?" → Testability and future SSO work
</probe>

<title>
Extract authentication into dedicated service
</title>

<description>
Authentication logic is scattered across handlers, making it difficult
to test and extend. The upcoming SSO integration requires a central
authentication path.

This refactoring consolidates authentication into `auth.Service` without
changing behavior. Existing tests pass unchanged, confirming the extraction
preserves semantics.

Closes org/backend#567
</description>

<why_good>
Title describes the structural change. Description explains why the
refactoring is needed now (SSO prep) and confirms no behavioral change.
</why_good>
</example>

## Simple Maintenance

<example>
<context>
Updating a deprecated dependency before it loses security support.
</context>

<probe>
- "Why update now?" → EOL date approaching
- "Any breaking changes?" → None, drop-in replacement
</probe>

<title>
Upgrade jwt-go to golang-jwt/jwt for continued security support
</title>

<description>
The `dgrijalva/jwt-go` package is unmaintained and no longer receives
security patches. The community fork `golang-jwt/jwt` is the recommended
replacement and is API-compatible.

This is a drop-in replacement with no code changes beyond import paths.

Closes org/backend#234
</description>

<why_good>
Title specifies the exact transition. Description explains urgency
(security support) and reassures reviewers (API-compatible, no changes).
</why_good>
</example>

## Framework/Infrastructure

<example>
<context>
Adding database migration infrastructure to support schema evolution.
</context>

<probe>
- "What problem does this solve?" → No way to evolve schema safely
- "Why this approach?" → Versioned migrations with rollback support
- "What alternatives were considered?" → ORM auto-migration rejected for control
</probe>

<title>
Support versioned database migrations with rollback capability
</title>

<description>
Schema changes currently require manual SQL execution with no rollback
path. This has caused production incidents when migrations fail mid-way
and leave the database in an inconsistent state.

The migration framework provides:
- Versioned migration files with up/down operations
- Transaction wrapping for atomic application
- Dry-run mode for CI verification
- Rollback to any previous version

This approach was chosen over ORM auto-migration for explicit control
over schema changes in production.

Closes org/backend#678
</description>

<why_good>
Title describes the capability. Description explains the current pain
(production incidents), what the solution provides, and why this approach
over alternatives.
</why_good>
</example>

## Security/Compliance

<example>
<context>
Adding audit logging for compliance with SOC 2 requirements.
</context>

<probe>
- "What compliance requirement?" → SOC 2 audit trail
- "What events are logged?" → Authentication, authorization, data access
- "What format?" → Structured JSON for SIEM integration
</probe>

<title>
Log authentication and authorization events for SOC 2 compliance
</title>

<description>
SOC 2 certification requires an audit trail of authentication attempts,
authorization decisions, and sensitive data access. The current logging
captures errors but not successful operations, leaving gaps in the audit
record.

All auth events now emit structured JSON logs suitable for SIEM ingestion.
The log format follows the company's existing observability schema for
consistency with other services.

No user-visible changes. Logging is append-only and does not affect
request latency (verified in staging load tests).

Closes org/compliance#45
</description>

<why_good>
Title specifies what is logged and why. Description connects to compliance
requirement, explains the gap being filled, and addresses operational
concerns (latency, format).
</why_good>
</example>

## CI/Tooling with Proof

<example>
<context>
Adding linting to CI to catch common errors before review.
</context>

<probe>
- "What problems does this catch?" → Common errors reviewers currently find
- "Does it pass on current code?" → Yes, after fixing 12 existing issues
- "What's the proof?" → CI run on this PR
</probe>

<title>
Enforce golangci-lint in CI to catch common errors before review
</title>

<description>
Reviewers frequently catch the same categories of issues: unused variables,
shadowed errors, and inefficient string concatenation. Automated linting
would free reviewers to focus on design and logic.

The linter runs as a required CI check. Twelve existing issues were fixed
in this PR to establish a clean baseline. The configuration file documents
which linters are enabled and why.

Proof: The CI run on this PR demonstrates the linter passing on all
existing code.

Closes org/backend#901
</description>

<why_good>
Title describes what CI now enforces. Description explains the value
(reviewer time), notes baseline work done, and uses the PR itself as proof.
</why_good>
</example>

## Follow-up PR

<example>
<context>
Second PR in a sequence, implementing frontend after backend landed.
</context>

<probe>
- "What did the previous PR do?" → Backend API changes
- "What does this PR complete?" → Frontend integration
- "Any remaining work?" → No, this completes the feature
</probe>

<title>
Display user timezone in profile settings
</title>

<description>
This completes the timezone feature by adding the UI for users to view
and update their timezone preference. The backend API landed in org/repo#890.

The timezone selector uses the browser's timezone as the default,
matching the behavior defined in the original issue.

Closes org/repo#456
</description>

<why_good>
Title describes the user-visible capability. Description connects to
the previous PR, explains the default behavior choice, and closes the
original issue to complete the feature.
</why_good>
</example>
