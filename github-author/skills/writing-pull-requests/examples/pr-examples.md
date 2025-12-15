# Pull Request Examples

Complete examples showing effective PR titles and descriptions.

## Feature PRs

### Library Enhancement

<example>
<context>
Adding support for parsing MAC addresses without separators (e.g., "00005e005301")
to align with IEEE EUI guidelines and Azure Instance Metadata Service format.
</context>

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

### Backend Feature

<example>
<context>
Adding rate limiting to authentication endpoints to prevent brute-force attacks.
No existing issue - discovered during security review.
</context>

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

## Bug Fix PRs

### Simple Fix

<example>
<context>
Fixing a nil pointer panic when serializing users with no email address.
Issue exists with reproduction steps.
</context>

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

### Complex Fix

<example>
<context>
Fixing a race condition in the connection pool that caused intermittent
connection leaks under high load.
</context>

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

## Refactoring PRs

<example>
<context>
Extracting user authentication into a dedicated service to improve
testability and prepare for SSO integration.
</context>

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

## Title Anti-Patterns

### Developer-Action Verbs

| Bad | Better |
|-----|--------|
| Add rate limiting to auth | Limit authentication attempts |
| Implement connection pooling | Pool database connections |
| Create user validation | Validate user input before processing |
| Write caching layer | Cache API responses for faster retrieval |

**Problem**: "Add", "Implement", "Create", "Write" describe what the developer did, not what the repository now does.

### Vague Descriptions

| Bad | Better |
|-----|--------|
| Fix bug | Handle nil email addresses in serialization |
| Update code | Serialize connection pool cleanup |
| Improve performance | Cache compiled templates for faster rendering |
| Make changes | Extract authentication into dedicated service |

**Problem**: Vague verbs provide no information about what changed.

### Missing Repository Target

| Bad | Better |
|-----|--------|
| Rate limiting | Limit authentication attempts |
| Bug fix for #123 | Handle edge case in date parsing |
| Performance improvement | Reduce memory allocations in hot path |

**Problem**: No verb means the title doesn't describe how the repository transforms.

## Verb Selection Guide

Choose verbs that describe what the repository **does** after the change:

### New Capability
- **Parse**: repository now parses something new
- **Handle**: repository now handles a case it didn't before
- **Support**: repository now supports a feature or format
- **Expose**: repository now exposes internal functionality
- **Enable**: repository now enables a previously impossible action

### Improvements
- **Optimize**: repository now performs better
- **Simplify**: repository now has cleaner structure
- **Reduce**: repository now uses fewer resources
- **Cache**: repository now caches for performance

### Fixes
- **Prevent**: repository now prevents a bad outcome
- **Serialize**: repository now coordinates concurrent access
- **Validate**: repository now validates input properly
- **Respect**: repository now respects a constraint it ignored

### Structural
- **Extract**: repository now has separated concerns
- **Consolidate**: repository now has unified logic
- **Refactor**: repository now has improved structure

### Removal
- **Remove**: repository no longer has deprecated code
- **Drop**: repository no longer supports old behavior
