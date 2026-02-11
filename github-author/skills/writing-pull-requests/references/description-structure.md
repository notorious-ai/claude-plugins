# PR Description Structure

PR descriptions follow GitHub Flavored Markdown. Effective descriptions answer reviewer questions efficiently while focusing on motivation over mechanics. The description is prose, not a form to fill out.

## The Untitled Opening

The first paragraph immediately follows the PR title without a header. This paragraph carries the weight of explaining **why** the change exists:

- The problem being solved or value being added
- The motivation driving the change
- The impact on users or the system

When an issue is linked, the opening can be brief since the issue provides context. When no issue exists, the opening must compensate by providing that context directly.

### Opening with Intent

The opening sentence establishes the change's purpose. Start with outcome or motivation, not developer action.

**Prefer** (outcome-focused):
```markdown
Users with large datasets experience 10+ second page loads, causing
15% to abandon the dashboard before it finishes rendering.
```

```markdown
Security review identified that authentication endpoints accept
unlimited attempts, making the system vulnerable to brute-force attacks.
```

```markdown
The current parser rejects MAC addresses in Azure IMDS format, blocking
integration with Azure Instance Metadata Service.
```

**Avoid** (developer-action focused):
```markdown
This PR adds caching to improve performance.
```

```markdown
I implemented rate limiting for the auth endpoints.
```

```markdown
Added support for MAC address parsing.
```

The "avoid" examples describe what the developer did. The "prefer" examples explain why the change matters.

## Prose Flow

Write descriptions as flowing paragraphs rather than templated sections. Subsequent paragraphs naturally expand on:

- Background and constraints that shaped the solution
- The approach taken and key trade-offs
- Areas deserving focused review
- Non-standard verification performed

Each paragraph should connect logically to the previous, building a complete picture. Link to related issues and supplementary information naturally within the prose rather than listing them separately.

When additional resources don't fit naturally in prose, a list with reference-style links is acceptable:

```markdown
- [Architecture decision record for caching][adr-cache]
- [Benchmark results comparing approaches][benchmarks]

[adr-cache]: https://docs.example.com/adr/0042-caching.md
[benchmarks]: https://gist.github.com/user/abc123
```

## Link Formatting

Prefer reference-style links (`[text][anchor]` with `[anchor]: url` at the bottom) over inline links (`[text](url)`). This keeps prose readable and URLs manageable.

When URLs appear as text (not as link targets), wrap in angle brackets: `<https://...>`.

GitHub issues and PRs use the full short syntax: `org/repo#123`.

### Issue Linking Keywords

GitHub recognizes keywords that automatically close issues when the PR merges. These keywords have specific semantics:

| Keyword | Semantics | Use When |
|---------|-----------|----------|
| `Closes` | Completes the work described in the issue | The PR fully addresses the issue's scope |
| `Fixes` | Resolves a defect or bug | The PR corrects incorrect behavior |
| `Resolves` | Addresses a discussion or decision | The PR implements a decided approach |

All three close the linked issue on merge. The choice signals intent to future readers:

```markdown
Closes org/repo#123          # This PR completes issue #123
Fixes org/repo#456           # This PR fixes bug #456
Resolves org/repo#789        # This PR implements the decision from #789
```

Use `Relates to org/repo#123` when the PR is connected but doesn't fully address the issue.

## When to Use Headers

Headers are organizational tools, not mandatory templates. Use them when they genuinely aid navigation.

**Use prose without headers when:**
- Description is under 3 paragraphs
- Single topic or concern
- Straightforward change with linked issue

**Consider headers when:**
- Description exceeds 3-4 paragraphs and covers multiple topics
- Breaking changes or migration steps need visibility
- Post-merge actions require explicit tracking
- Complex architectural decision needs structured explanation

For short descriptions, flowing prose is more readable than templated sections.

## Headers in Long Descriptions

For lengthy descriptions (roughly 4+ paragraphs), headers help readers navigate. Use them sparingly and appropriately for the content.

### Example: Breaking Changes

```markdown
Refactors configuration parsing to validate inputs and surface errors
early. Previously, invalid configuration would cause silent failures
at runtime.

## Breaking Changes

The `ParseConfig` function now returns `(Config, error)` instead of
just `Config`. Callers must handle the error case.

Update call sites from:
    cfg := ParseConfig(path)
To:
    cfg, err := ParseConfig(path)
    if err != nil { ... }

## Post-Merge

- [ ] Update downstream consumers in `service-a` and `service-b`
- [ ] Notify #platform-eng channel of the breaking change
```

### Example: Migration Required

```markdown
Updates the event schema to support multi-tenant contexts. The new
`tenant_id` field enables proper isolation between customer data.

## Migration

Existing events lack the `tenant_id` field. Run the backfill script
before deploying consumers that depend on this field:

    ./scripts/backfill-tenant-ids.sh --dry-run
    ./scripts/backfill-tenant-ids.sh --execute

The script is idempotent and safe to re-run.

Closes org/repo#456
```

Avoid templated headers for short descriptions. A single prose paragraph often suffices.

## Post-Merge Follow-up

When a PR requires action after merging, document it explicitly. Use a `## Post-Merge` or `## Follow-up` section with checkboxes for trackable items:

```markdown
## Post-Merge

- [ ] Update downstream consumers in `service-a` and `service-b`
- [ ] Notify #platform-eng channel of the breaking change
- [ ] Create follow-up issue for deprecation timeline
```

### Follow-up PRs

When this PR is part of a sequence, reference the relationship:

```markdown
## Follow-up

This PR handles the backend changes. Frontend integration follows in
a separate PR once this merges and the API is stable.

See also: org/repo#890 (frontend tracking issue)
```

### Deferred Work

When the PR intentionally defers scope, document what was deferred and why:

```markdown
## Not in Scope

This PR focuses on the core caching mechanism. The following are
intentionally deferred:

- Cache invalidation strategies (requires design discussion)
- Metrics and observability (separate instrumentation PR)
- Configuration hot-reloading (nice-to-have, not blocking)
```

Explicit scoping prevents reviewers from requesting out-of-scope changes and creates a record of intentional decisions.

## Proofs

Complex changes benefit from proof that they work as expected. Proofs take different forms:

**For library code**: Examples in the code demonstrate the new capability. Fixes are proven by concomitant tests that exercise the corrected behavior.

**For executables and backends**: Manual verification in staging or production-like environments. These proofs are often captured as screenshots, logs, or recordings.

**Linking proofs**: When proof requires extensive output or visual evidence, attach it as a PR comment and reference it in the body using trailer format:

```
Proof: org/repo#123 (comment)
```

CI output can serve as proof when the pipeline exercises the changed behavior meaningfully.

## Scaling with Complexity

### Simple PR (obvious change, linked issue)

```markdown
Brief statement of what capability the repository gains.

Closes org/repo#123
```

### Standard PR (typical feature or fix)

```markdown
Explanation of the problem being solved and why it matters. The
change enables [outcome] by [approach].

Closes org/repo#123
```

### Complex PR (architectural change, no linked issue)

```markdown
Detailed motivation explaining the problem, its impact, and why
this change is needed now. Include how the problem was discovered
and what happens if left unaddressed.

The solution approaches [goal] by [strategy]. This design was chosen
over [alternative] because [rationale], as outlined in [the architecture
doc][arch]. Prior discussion in [RFC #78][rfc] established the general
direction.

Proof: org/repo#789 (comment)

[arch]: https://docs.example.com/architecture
[rfc]: https://github.com/org/repo/discussions/78
```

## PRs Without Linked Issues

When no issue provides context, the description becomes the primary record of why this change exists. Cover what the issue would have covered:

- Background on the problem or need
- How the problem was discovered
- Impact if left unaddressed
- Constraints that shaped the solution

The description compensates for the missing issue by providing that essential context.

## Common Anti-Patterns

### Commit List Rehash

```markdown
## Changes
- Updated user.go
- Fixed test
- Added validation
```

**Problem**: Duplicates git log, adds no value. Reviewers see commits.

### Implementation Narration

```markdown
First I created the interface, then implemented the repository,
then updated the service to use it...
```

**Problem**: Describes developer work, not why it matters.

### File-by-File Description

```markdown
- `auth/login.go`: Added rate limiting check
- `auth/middleware.go`: Updated to use limiter
```

**Problem**: Visible in the diff. Describe the capability instead.

### Missing Context

```markdown
Fixes the issue.
```

**Problem**: Which issue? Why? How?

## Writing the "Why"

Surface the motivation by asking:

1. What problem exists today?
2. What happens if we don't fix it?
3. What will be possible after this merges?
4. Why this approach over alternatives?

The answers form your prose.

## Facilitating Review

Smaller, focused PRs are easier to review than omnibus changes. When a large PR is unavoidable, suggest a review path in the description.

Call out areas of uncertainty, highlight breaking changes, and note any temporary code or follow-up work needed.

For UI changes, include screenshots or recordings. Before/after comparisons help reviewers understand visual changes without checking out the branch.

## Draft PRs

Use draft PRs for:
- Work-in-progress needing early feedback
- Changes blocked on dependent PRs
- Proposals for design discussion

Convert to ready-for-review when:
- All commits are complete
- CI passes
- Self-review is done
