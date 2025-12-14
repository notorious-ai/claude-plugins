---
name: Writing Issues
description: This skill should be used when the user asks to "create an issue", "open an issue", "file a bug", "report a bug", "request a feature", "write an issue", or when documenting problems or proposing changes on GitHub.
---

# Writing Issues

Effective issues communicate problems clearly, define outcomes precisely, and provide enough context for anyone to understand the work. This skill guides the creation of issues that drive productive collaboration.

## Core Principles

A well-crafted issue answers three questions:
1. **Why** does this matter? (motivation and context)
2. **What** should change? (the desired outcome)
3. **How** will we know it's done? (definition of done)

## Respecting Repository Templates

Before drafting an issue, check for repository-specific templates. Templates encode team conventions and should be respected when they fit the context.

### Locating Templates

Search these paths in order:

1. `.github/ISSUE_TEMPLATE/` (multiple templates with chooser)
2. `.github/ISSUE_TEMPLATE.md`
3. `docs/ISSUE_TEMPLATE.md`
4. `ISSUE_TEMPLATE.md` (root)

```bash
# Quick check for any issue template
find . -maxdepth 3 -iname "*issue_template*" 2>/dev/null
```

### Using Templates

When templates exist, read them and evaluate fit:

- **Good fit**: Follow the template structure, filling sections appropriately
- **Partial fit**: Use relevant sections, adapt others with judgment
- **Poor fit**: Draft freely but note why the template didn't apply

Templates are guides, not rigid forms. A simple documentation fix doesn't need reproduction steps; a strategic proposal doesn't fit a bug report form.

## Issue Title

Write titles that describe the desired outcome or the problem.

### Good Patterns

**Outcome-focused** (for features and improvements):
- "Surfacing historical UE states"
- "Encoding prefix-tree to binary form"
- "Walking digital-twin graph assemblies"

**Problem-focused** (for bugs):
- "Golang linter fails to detect violations based on diff-patch"
- "Testing multiple modules cannot upload multiple artefacts appropriately"

### Avoid

- Vague scope: "Fix issues" (which issues?)
- Implementation details: "Add a mutex to cache" (describe the problem, not the solution)
- Questions as titles: "How do we handle X?" (use Discussions for questions)

## Issue Body

The body provides context, defines scope, and guides implementation. Prefer flowing prose over heavy bullet lists.

### Opening with Context

Start by explaining **why** this matters. Ground the reader in the problem space before diving into details.

**Good**: "While chasing network states across the system, we've noticed that asset-twin currently summarises network-twin's graph into its own world view. This approach violates the digital-twins architecture..."

**Avoid**: Starting with implementation details or jumping straight to requirements.

### Definition of Done

Include a clear outcome statement. The pattern "By the time this Issue is complete, the system will have..." works well for defining scope and completion criteria.

**Examples**:
- "By the time this Issue is complete, the digital twins will have supported manually exporting their graphs to file in a way that supports import later on."
- "By the time this Issue is complete, asset-twin's graph will have contained all meaningful graph components from network-twins, in their expanded form."

This framing forces clarity about what "done" means and helps prevent scope creep.

### Supporting Details

Include details that help implementers understand the work:

- **Examples**: Concrete scenarios that illustrate the problem or desired behavior
- **Diagrams**: Mermaid charts for system interactions or data flows
- **Code snippets**: When they clarify interfaces or expected behavior
- **Links**: Related issues, design docs, specifications

### Closing with References

End with "See also" links to related resources:

```markdown
## See also

- Design document: [link]
- Related issue: #123
- JIRA: [OLB-137](https://...)
- Figma: [link to designs]
```

## Bug Reports

Bug reports need enough information to reproduce and diagnose the problem.

### Essential Elements

1. **What happened** (observed behavior)
2. **What should happen** (expected behavior)
3. **How to reproduce** (steps, environment, data)

### Example

```markdown
The nightly build has been failing the linter job for the last two weeks.

The failure contains the error:
  shadow: declaration of "err" shadows declaration at line 158 (govet)

The issue appeared first when golangci-lint changed to v1.57.0. This version
contains changes to the shadowing settings of govet.

Although shadowing was enabled by one option, it was actually disabled by
another option a few lines below. Up until the new release, the linter resolved
this conflict by not checking for shadowing. The new release changed that logic
so the seemingly "new" error appears.

Thank you @yuvalmendelovich for noticing the unhealthy state of our build.
```

## Feature Requests

Feature requests need motivation, scope, and (often) design context.

### Structure

1. **Motivation**: Why does this matter? What problem does it solve?
2. **Scope**: What should the feature do? What is explicitly out of scope?
3. **Definition of done**: How will we know it's complete?
4. **Design context**: Links to design docs, architecture decisions, or prior discussions

### Example

```markdown
The backbone of the Device Activity feature is the ability of components to
observe changes to discrete properties of each device. We believe these
property changes are a solid foundation upon which we can later build further
business value.

It is now time to enhance the OneLayer Bridge product with events about
discrete property changes of devices as tracked by asset-twin. In the design
document we name the first chain of event processing: change-detection service.

By the time this effort is complete, the system will have had the ability to
consume property change notifications generated by this service.

## See also

- Design document: [link]
- Related frontend work: #160
```

## Follow-up Tasks

When an issue identifies post-completion work, list it clearly:

```markdown
The following tasks are important to tidy after merge:

- [ ] Rename labels on GitHub
- [ ] Port how-to-use-labels.md changes to onelayerhq/docs
```

## References

For detailed issue patterns by type, consult:
- **`references/issue-patterns.md`** - Common issue patterns for bugs, features, and improvements
