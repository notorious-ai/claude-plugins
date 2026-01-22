---
name: Writing Pull Requests
description: Activates when the user asks to "write a PR", "draft a pull request", "create PR description", "improve PR title", "make PR easier to review", "help with pull request", or "open a PR". Also triggers proactively when preparing to create a pull request with `gh pr create` or when reviewing staged changes for contribution. Covers PR authoring, titles, and descriptions.
---

# Writing Pull Requests

Effective pull requests communicate the **why** behind changes, not the **what**. Code diffs already show what changed; the PR title and description convey motivation, impact, and context that accelerates review.

## Core Principle: Repository Transformation

The PR title describes how the **repository** changes when the PR merges. The verb targets the repository capability, not the developer action.

### The "Fill in the Blank" Technique

Complete this sentence with your title: "After this PR merges, the repository will _____."

The verb must make grammatical sense in this frame. Developer-action verbs fail the test:

| Verb | "The repository will _____" | Works? |
|------|----------------------------|--------|
| Parse MAC addresses | "The repository will parse MAC addresses" | Yes |
| Add rate limiting | "The repository will add rate limiting" | No |
| Handle nil emails | "The repository will handle nil emails" | Yes |
| Implement caching | "The repository will implement caching" | No |

Developer-action verbs (add, implement, create, write, update, change) describe what the developer did. Repository-capability verbs (parse, handle, support, expose, enable, optimize, simplify, prevent, serialize, validate, extract) describe what the code does.

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

## Surfacing Hidden Context

PRs live in the solution-space: the author has made decisions and the changeset reflects those decisions. The description must surface the context that led to this solution.

### What the Prose Must Capture

The diff shows **what** changed. The description must explain what the diff cannot convey:

- **Expected outcome**: What the change accomplishes (verifiable against the changeset)
- **Intent behind the change**: Why this change, why now
- **Trade-offs accepted**: What was sacrificed and why it was acceptable
- **Alternatives rejected**: Other approaches considered and why they were not chosen
- **Constraints that shaped the solution**: Technical, organizational, or timeline limitations
- **Assumptions made**: What must remain true for this solution to work
- **Future considerations deferred**: What this change explicitly does not address

### Detecting Missing Context

Use intelligence to detect when essential context is missing. When gaps exist, ask targeted questions before drafting:

- "What led to choosing X over Y for this approach?"
- "What constraint prevented the simpler solution?"
- "What should reviewers verify to confirm this works as intended?"

If the user cannot provide the information after being asked, use `[FILL: rationale for approach]` placeholders to indicate where context is needed.

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

PRs are **solution-space** documents. Issues define what needs solving (problem-space); PRs explain why this particular solution was chosen and what outcome it achieves.

The description explains **why** this solution exists and **what outcome** it delivers. The expected outcome must be verifiable: reviewers should be able to confirm the changeset achieves the stated intent.

The first paragraph immediately follows the title without a header. This opening carries the weight of explaining the change purpose.

**When an issue is linked**: The description can be brief since the issue provides problem-space context. Focus on the solution rationale: why this approach, what trade-offs were accepted.

**When no issue exists**: The description must compensate by providing both problem-space context (what prompted the change, who is affected) and solution-space rationale (why this approach over alternatives).

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
| `references/description-structure.md` | Description format, prose flow, issue linking, post-merge patterns |
| `examples/good-pr-examples.md` | Effective PR examples with probe tags showing context discovery |
| `examples/bad-pr-examples.md` | Anti-patterns with detailed rationale for why they fail |

## What to Avoid

<negative>
<pattern>Rehashing commits in bullet lists</pattern>
<reason>The git log shows commits; the description explains intent the diff cannot convey.</reason>
</negative>

<negative>
<pattern>Describing file-by-file changes</pattern>
<reason>The diff shows which files changed. Describe the capability, not the file list.</reason>
</negative>

<negative>
<pattern>Starting with "This PR adds/implements/creates..."</pattern>
<reason>This describes developer action. Start with why this change matters or what outcome it achieves.</reason>
</negative>

<negative>
<pattern>Skipping context when no issue exists</pattern>
<reason>Without a linked issue, the description must provide problem-space context. "Fixes the bug" with no issue is meaningless.</reason>
</negative>

<negative>
<pattern>Using developer-action verbs in titles: add, create, implement, write, update, change</pattern>
<reason>These describe what the developer did, not what the repository now does. See `examples/bad-pr-examples.md` for detailed guidance.</reason>
</negative>

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
