---
name: Drafting Pull Requests
description: This skill should be used when the user asks to "create a PR", "open a pull request", "submit changes", "make a PR", "draft a PR", or when preparing code changes for review on GitHub.
---

# Drafting Pull Requests

Effective pull requests communicate intent clearly, enable efficient review, and maintain project history. This skill guides the creation of PRs that foster productive collaboration.

## Core Principles

A well-crafted PR answers three questions:
1. **What** changed? (the diff speaks for itself)
2. **Why** did it change? (the description explains intent)
3. **How** should it be reviewed? (structure guides the reviewer)

## Respecting Repository Templates

Before drafting a PR, check for repository-specific templates. Templates encode team conventions and should be respected when they fit the context.

### Locating Templates

Search these paths in order (first match wins):

1. `.github/pull_request_template.md`
2. `.github/PULL_REQUEST_TEMPLATE.md`
3. `docs/pull_request_template.md`
4. `pull_request_template.md` (root)
5. `.github/PULL_REQUEST_TEMPLATE/` (multiple templates)

```bash
# Quick check for any PR template
find . -maxdepth 3 -iname "*pull_request_template*" 2>/dev/null
```

### Using Templates

When a template exists, read it and evaluate whether it fits the current change:

- **Good fit**: Follow the template structure, filling sections appropriately
- **Partial fit**: Use relevant sections, omit or adapt others with judgment
- **Poor fit**: Draft freely but note why the template didn't apply

Templates are guides, not rigid forms. A bug fix doesn't need a "Screenshots" section; a one-line typo fix doesn't need extensive testing notes.

## PR Title

Write titles in **imperative mood** that describe how the codebase changes.

**Structure**: `<verb> <what changes>`

### Good Verbs

Find the verb that describes HOW the codebase changes after the PR merges.

**Fill in the blank:** "After merging, this codebase will _____"

| Intent | Verbs |
|--------|-------|
| New functionality | handle, measure, transform, parse, validate, track, compute |
| New declarations | define, expose, introduce |
| Improvements | enhance, optimize, refactor, simplify |
| Fixes | fix, respect, correct, resolve |
| Removal | remove, drop, deprecate |
| Configuration | configure, enable, disable |
| Documentation | explain, clarify, document |

### Verbs to Avoid

These describe what YOU did, not how the codebase changes:

| Avoid | Why | Better |
|-------|-----|--------|
| add | Developer action | handle, define, introduce |
| create | Developer action | define, establish |
| implement | Developer action | handle, support |
| write | Developer action | document, explain |
| update | Vague | What specifically changes? |
| change | Vague | What's the effect? |

### Title Examples

**Good**:
- "Handle OAuth callback for SSO login"
- "Fix race condition in cache invalidation"
- "Refactor payment processing for testability"
- "Remove deprecated analytics endpoints"

**Avoid**:
- "Added authentication" (past tense, developer action)
- "Authentication feature" (noun phrase, no verb)
- "Various fixes" (vague scope)
- "Fix #123" (no context without clicking)

## PR Description

The description explains **why** the change matters. The diff shows what changed; the description provides intent and context.

### Writing Style

Prefer prose over heavy section headers. A "Summary" header above a single paragraph adds noise without value.

For short descriptions (1-2 paragraphs), write flowing prose that explains the intent and any relevant context. Headers become useful when the body exceeds three paragraphs, helping readers navigate to what they care about.

### Structure for Longer Descriptions

When a PR warrants more than three paragraphs, structure it as:

1. **Opening paragraph** (no header) - The synopsis explaining intent and why this change matters. This stands alone as the intro by virtue of headers appearing below.

2. **Labeled sections** - Use headers for distinct topics that follow:
   - **Approach**: High-level explanation of the solution
   - **Trade-offs**: Alternatives considered and why this approach won
   - **Testing**: How the change was verified
   - **Migration**: Steps for consumers of breaking changes

### Opening with Intent

Start with 1-3 sentences explaining the **purpose** (why), not the implementation (what).

**Good**: "Users reported confusion when sessions expired silently. This adds explicit expiration warnings 5 minutes before timeout, giving users time to save work."

**Avoid**: "This PR adds a warning message component and updates the session service to track expiration time." (describes implementation, not intent)

### Additional Context

Include supporting information only when it aids review:

- **Breaking changes**: What breaks and the migration path
- **Dependencies**: Related PRs or external changes that must land first
- **Testing notes**: How to verify behavior manually when automated tests aren't sufficient
- **Screenshots**: For UI changes, showing before/after states

### Linking Issues

Connect PRs to issues at the end of the description using GitHub keywords:

- `Closes #123` - Closes issue when PR merges
- `Fixes #123` - Same as closes (semantic for bug fixes)
- `Resolves #123` - Same as closes

The summary should stand alone without requiring issue links for context.

## PR Scope

Keep PRs focused on a single logical change.

**Signs of good scope**:
- Reviewable in one sitting (under 400 lines typical)
- Single purpose evident from title
- All changes relate to stated intent

**Signs of scope creep**:
- "Also fixes..." or "While I was here..." in description
- Multiple unrelated file groups changed
- Reviewer asks "why is this in here?"

When scope grows, split into stacked PRs or separate unrelated changes into their own PR.

## Draft PRs

Use draft PRs for:
- Work-in-progress needing early feedback
- Changes blocked on dependent PRs
- Proposals for design discussion

Convert to ready-for-review when:
- All commits are complete
- CI passes
- Self-review is done

## Self-Review Checklist

Before requesting review:

1. **Read the diff** as if seeing it for the first time
2. **Verify the title** accurately describes the change using proper verbs
3. **Check the description** explains why, not just what
4. **Confirm CI passes** (don't waste reviewer time on broken builds)
5. **Remove debug code** and commented-out blocks
6. **Verify scope** - no unrelated changes snuck in

## References

For detailed patterns on specific PR scenarios, consult:
- **`references/pr-patterns.md`** - Common PR patterns by type (bug fix, feature, refactor)
