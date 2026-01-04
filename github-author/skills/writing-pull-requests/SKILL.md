---
name: Writing Pull Requests
description: Activates when the user asks to "write a PR", "draft a pull request", "create PR description", "improve PR title", "make PR easier to review", "help with pull request", or "open a PR". Also triggers proactively when preparing to create a pull request with `gh pr create` or when reviewing staged changes for contribution. Covers PR authoring, titles, and descriptions.
---

# Writing Pull Requests

Effective pull requests communicate the **why** behind changes, not the **what**. Code diffs already show what changed; the PR title and description convey motivation, impact, and context that accelerates review.

## Core Principle: Repository Transformation

The PR title describes how the **repository** changes when the PR merges. The verb targets the repository capability, not the developer action.

**Think**: "This PR modifies the repository to _____"

| Developer Action (avoid) | Repository Capability (prefer) |
|--------------------------|-------------------------------|
| Add rate limiting | Limit authentication attempts |
| Implement caching | Cache API responses |
| Create validation | Validate user input before processing |
| Write error handling | Handle connection timeouts gracefully |

The verbs "add", "implement", "create", and "write" describe developer work. Prefer verbs that describe what the repository **does** after the change: parse, handle, support, expose, enable, optimize, simplify, prevent, serialize, validate, extract.

## Title Structure

PR titles follow imperative mood, beginning with a verb:

**Format**: `<Verb> <what the repository now does>`

- Begin with an action verb in imperative form
- Describe the new capability or behavior
- Keep concise but descriptive
- Capitalize the first letter (it is a sentence)

**Examples**:
- `Parse MAC addresses without separators`
- `Limit authentication attempts to prevent brute-force attacks`
- `Serialize connection pool cleanup to prevent leaks`
- `Extract authentication into dedicated service`

## Gathering Context

Before drafting a PR, gather context from multiple sources:

### From Git

Analyze the working tree to understand the change scope:

1. Review the diff to understand what changed
2. Check commit history to see the progression of work
3. Note branch name conventions that may encode intent

### From the Repository

Search for related context in the repository:

1. Check open issues that may relate to the changes
2. Review recently closed issues for ongoing efforts
3. Look at recent PRs touching similar areas

Use `gh issue list` and `gh pr list` to discover related work. Reference relevant issues in the PR description to connect the contribution to ongoing efforts.

### From the Conversation

Draw context from the discussion that led to the changes:

1. Why was this change initiated?
2. What alternatives were considered?
3. What constraints shaped the solution?

When context is missing, ask proactively. The motivation behind a change is essential for a good PR.

## Repository Templates

Before drafting, check for repository-specific templates that encode team conventions.

### Locating Templates

Search these paths (first match wins):
1. `.github/pull_request_template.md`
2. `.github/PULL_REQUEST_TEMPLATE.md`
3. `docs/pull_request_template.md`
4. `pull_request_template.md` (root)
5. `.github/PULL_REQUEST_TEMPLATE/` (multiple templates)

### Using Templates

When a template exists, evaluate fit:
- **Good fit**: Follow the template structure
- **Partial fit**: Use relevant sections, adapt others with judgment
- **Poor fit**: Draft freely but note why the template didn't apply

Templates are guides, not rigid forms.

## Description Philosophy

The description explains **why** this change exists. For PRs, focus on motivation over mechanics. For Issues linked to the PR, focus on **why** over **how** - the desired outcome rather than implementation steps.

The first paragraph immediately follows the title without a header. This opening carries the weight of explaining the change purpose.

**When an issue is linked**: The description can be brief since the issue provides context.

**When no issue exists**: The description must compensate by providing that context directly - background, how the problem was discovered, impact if unaddressed, and constraints.

## PR Scope

Keep PRs focused on a single logical change.

**Signs of good scope**:
- Reviewable in one sitting (under 400 lines typical)
- Single purpose evident from title
- All changes relate to stated intent

**Signs of scope creep**:
- "Also fixes..." or "While I was here..." in description
- Multiple unrelated file groups changed

When scope grows, split into stacked PRs or separate unrelated changes.

## Proofs

Complex changes benefit from proof that they work as expected:

- **Library code**: Examples in code demonstrate capability; tests prove fixes
- **Executables/backends**: Manual verification in production-like environments

Link proofs using trailer format: `Proof: org/repo#123 (comment)`

## Workflow

When creating a PR:

1. **Gather context**: Review diff, commits, branch name, and conversation
2. **Search for related work**: Check open/closed issues and recent PRs
3. **Identify the capability**: What does the repository do differently?
4. **Draft title**: Verb + capability (not developer action)
5. **Write description**: Focus on why, link related issues, include proof for complex changes
6. **Review**: Does the title describe repository transformation? Does the description explain motivation?

## Reference Files

For detailed guidance, consult:

| File | Contains |
|------|----------|
| `references/description-structure.md` | Description format, prose flow, headers, anti-patterns |
| `examples/pr-examples.md` | Complete PR examples with titles and descriptions |

## Self-Review Checklist

Before presenting the PR:

**Process**:
- [ ] Read the diff as if seeing it for the first time
- [ ] Confirm CI passes (don't waste reviewer time on broken builds)
- [ ] Remove debug code and commented-out blocks
- [ ] Verify scope - no unrelated changes snuck in

**Title**:
- [ ] Begins with imperative verb describing repository capability
- [ ] Does NOT use developer-action verbs (add, implement, create, write)
- [ ] Describes how the repository changes, not what you did

**Description**:
- [ ] Opens with untitled paragraph explaining why
- [ ] Links related issues using full short syntax (`org/repo#123`)
- [ ] Includes proof for complex changes
- [ ] Uses prose flow, not bullet lists of changes
- [ ] If no linked issue, provides compensating context
