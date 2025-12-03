# Commit Body Guidelines

When and how to write commit message bodies.

## When to Include a Body

Include a body when:
- The one-liner alone doesn't provide sufficient context
- Future readers (6 months from now) would benefit from explanation
- There are non-obvious design decisions
- The change has important implications

## When to Skip the Body

Skip the body when:
- The change is self-explanatory from one-liner + diff
- Simple, straightforward changes with obvious motivation
- Mechanical changes (tidy, formatting, renames)

## Format Rules

**Plaintext only** - NO Markdown formatting. Terminals don't render it.

**Line length:**
- Hard wrap at 72 characters per line
- Separate paragraphs with blank lines

**URLs:** Wrap in angle brackets for clarity:
```
See <https://docs.example.com/architecture.html> for details.
```

## Writing Multiline Commit Messages

**NEVER use multiple `-m` flags:**
```bash
# BAD - no control over line width
git commit -m "subject" -m "first paragraph" -m "second paragraph"
```

Use line breaks within quotes instead - the shell respects newlines:
```bash
git commit -m "target: verb phrase

Body paragraph with proper hard wrapping at 72 characters.
This gives full control over formatting and line breaks.

Additional paragraphs as needed."
```

Use `fmt -w 72` or `fold -s -w 72` to verify body text is properly wrapped.

## What to Include

The body's purpose is to capture the **WHY** - context from the conversation and thought process that led to this change.

### Motivation

Why this change was necessary:
```
The previous implementation caused timeouts under high load
because connections weren't being pooled correctly.
```

### Decision Rationale

Why this approach over alternatives:
```
Chose buffered channels over sync.WaitGroup because the
producer needs backpressure when consumers fall behind.
```

### Timing Context

What this leads to, what comes next:
```
This commit lays out the type system. The following commits
will expose these constructs in a more usable interface.
```

### Validation

Commands or tools used to verify:
```
Tested with: go test -race ./...
Benchmarked with: go test -bench=. -benchmem
```

### References

Links to architecture docs, related work:
```
See <https://docs.example.com/architecture.html> for details.
```

### Open Questions and TODOs

When committing while work is still in progress, and the conversation contains unresolved questions or remaining tasks, capture them in the body:

```
QUESTION: Should this validation also apply to legacy devices?
TODO: Add metrics for monitoring attack patterns.
```

Only include these when they are strictly present in the conversation context.

## What NOT to Include

- Information visible in the diff itself
- File listings or line-by-line implementation details
- Markdown formatting (headers, bullets, code blocks)
- Generic phrases like "this commit does X"

## Issue References

**When available:**
- Embed within sentences for natural context
- Use short form: `owner/repo#123` (not just `#123`)
- Transform full URLs: `https://github.com/acme/repo/issues/123` → `acme/repo#123`
- Show relationship: "Contributes to...", "Addresses..."

```
As mentioned in acme-corp/roadmap#123, we need to track
device mobility patterns for the network twin feature.

This addresses the performance issue reported in
acme-corp/backend#456 where large message reassembly
caused timeouts.
```

**Do NOT:**
- Add arbitrary issue numbers if you don't have them
- Create fake references
- Use generic "Fixes #N" without context

## Body Checklist

- [ ] Provides context NOT visible in the diff
- [ ] Plaintext only (no Markdown)
- [ ] Lines hard-wrapped at 72 characters
- [ ] Paragraphs separated by blank lines
- [ ] URLs wrapped in angle brackets
- [ ] Explains WHY, not WHAT (diff shows what)
- [ ] Will make sense in 6 months during git blame

**Before finalizing:** Re-read the diff alongside the body. Delete any sentence that just describes what changed (e.g., "renamed function X to Y") - the diff already shows that. Keep only what the diff cannot tell: why, what alternatives were rejected, what comes next.

## Examples

### Architectural Context

```
device/activity: expose UE state property

This property will be used by the upcoming mobility tracking
feature to determine when devices transition between active
and inactive states. The property design follows the same
pattern as existing state tracking to maintain consistency.

Tested with: go test ./device/activity/...
Next: Add property validation and update documentation.
```

### Complex Problem Explanation

```
gopacket: register application-specific layer types without collisions

When application-specific packages need to register a layer,
it requires coordination between all packages in the
executable. Unfortunately, this isn't always possible since
packages can't know about each other in advance.

The new function registers layer types using the first
available index. This means the layer ID may change between
different users of the same package. Users must pay attention
to this detail.
```

### Timing and Sequence

```
fingerprint/classification: reify architecture constructs into Go

This commit lays out a type system that mirrors the
architectural concepts for fingerprinting. Most names and
doc comments are taken literally from the architecture
document.

The following commits will expose these constructs in a more
usable interface for consumers.

See <https://docs.acme-corp.dev/fingerprint-sad.html> for
the detailed architecture.
```
