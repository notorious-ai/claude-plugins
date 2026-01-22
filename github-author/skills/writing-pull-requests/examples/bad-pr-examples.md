# PR Anti-Patterns

This file documents common mistakes in PR titles and descriptions. Each anti-pattern includes:

- **Pattern**: What the problematic PR looks like
- **Problem**: Why this is ineffective
- **Better**: How to improve it

Use this file to recognize anti-patterns in drafts and understand why they fail.

## Title Anti-Patterns

### Developer-Action Verbs

Titles that describe what the developer did rather than what the repository now does.

| Bad Title | Problem | Better Title |
|-----------|---------|--------------|
| Add rate limiting to auth | "Add" describes developer action | Limit authentication attempts |
| Implement connection pooling | "Implement" describes developer action | Pool database connections |
| Create user validation | "Create" describes developer action | Validate user input before processing |
| Write caching layer | "Write" describes developer action | Cache API responses for faster retrieval |
| Update error handling | "Update" is vague developer action | Handle connection timeouts gracefully |
| Change config format | "Change" describes developer action | Support YAML configuration files |

**Why this matters**: The title should pass the "fill in the blank" test: "After this PR merges, the repository will _____." Developer-action verbs fail this test.

### Verbs to Avoid (with Rationale)

| Verb | Why It Fails | What It Signals |
|------|--------------|-----------------|
| **Add** | Describes putting something in, not what it does | The author focused on the action of adding, not the capability gained |
| **Implement** | Describes the development process | The author is narrating their work rather than describing the outcome |
| **Create** | Describes bringing something into existence | The author focused on creation, not function |
| **Write** | Describes the act of coding | The author is describing their activity |
| **Update** | Says something changed without saying how | The author hasn't identified the meaningful change |
| **Change** | Maximally vague about what happened | The author hasn't thought through the impact |
| **Modify** | Variant of "change" with same problem | Describes developer action without specifying capability |
| **Refactor** | Sometimes acceptable, but often masks unclear thinking | Ask: what does the repository do differently? If nothing, explain why the structure change matters |

**Preferred verbs** describe what the code does: parse, handle, support, expose, enable, optimize, simplify, prevent, serialize, validate, extract, cache, limit, pool, respect, consolidate.

### Vague Descriptions

Titles that provide no meaningful information about the change.

| Bad Title | Problem | Better Title |
|-----------|---------|--------------|
| Fix bug | Which bug? What behavior changed? | Handle nil email addresses in serialization |
| Update code | What was updated? Why? | Serialize connection pool cleanup |
| Improve performance | What improved? How? | Cache compiled templates for faster rendering |
| Make changes | Meaningless | Extract authentication into dedicated service |
| Various fixes | Multiple problems conflated | (Split into separate PRs) |
| Minor updates | Dismissive of reviewer's time | Correct typos in API documentation |

**Why this matters**: Vague titles waste reviewer time and create useless git history. A year from now, "Fix bug" tells you nothing.

### Missing Repository Target

Titles that lack a verb entirely, failing to describe transformation.

| Bad Title | Problem | Better Title |
|-----------|---------|--------------|
| Rate limiting | No verb - what about rate limiting? | Limit authentication attempts |
| Bug fix for #123 | References issue but doesn't describe change | Handle edge case in date parsing |
| Performance improvement | No verb - what improved? | Reduce memory allocations in hot path |
| Authentication refactor | No verb - what happened to auth? | Extract authentication into dedicated service |
| Caching | Noun only - did we add it? Remove it? | Cache frequently-accessed user profiles |

**Why this matters**: The title is a sentence in imperative mood. Without a verb, it's not a sentence and doesn't describe action.

## Description Anti-Patterns

### Commit List Rehash

```markdown
## Changes
- Updated user.go
- Fixed test
- Added validation
```

**Problem**: Duplicates information already visible in the git log. Reviewers can see the commits. The description should explain what the commits cannot: motivation, context, and rationale.

**Better**: Explain why these changes were made together and what outcome they achieve.

### Implementation Narration

```markdown
First I created the interface, then implemented the repository,
then updated the service to use it, and finally added tests.
```

**Problem**: Describes the developer's journey, not why the change matters. The sequence of work is irrelevant to reviewers.

**Better**: Explain the problem being solved and why this solution was chosen.

### File-by-File Description

```markdown
## Files Changed
- `auth/login.go`: Added rate limiting check
- `auth/middleware.go`: Updated to use limiter
- `auth/config.go`: Added rate limit configuration
```

**Problem**: This information is visible in the diff. Describing files adds no value.

**Better**: Describe the capability: "Authentication endpoints now limit failed attempts to 5 per 15-minute window, returning HTTP 429 on excess attempts."

### Missing Context

```markdown
Fixes the issue.
```

**Problem**: Which issue? Why did it need fixing? What was the fix? This description is useless to reviewers and future readers.

**Better**: Even with a linked issue, provide enough context to understand the change without clicking through.

### Developer-Action Opening

```markdown
This PR adds caching to the user service to improve performance.
```

**Problem**: Opens with developer action ("This PR adds") rather than outcome or motivation.

**Better**: "User profile lookups average 200ms due to repeated database queries. Caching frequently-accessed profiles reduces lookup time to <5ms for 95% of requests."

### Bullet List of Changes

```markdown
## Summary
- Added caching
- Updated tests
- Fixed linting
- Cleaned up imports
```

**Problem**: Bullet lists of changes duplicate the diff and commit list. They don't explain why.

**Better**: Prose that explains the motivation and outcome, with bullets only for acceptance criteria or reviewable sections in large PRs.
