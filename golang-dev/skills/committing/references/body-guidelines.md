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

## Before Writing: The Stranger Test

Before drafting any body, list the questions a stranger would still have after reading the diff with no other context. Write only the answers. If the list is empty, omit the body - a precise subject plus a self-documenting diff beats a body that paraphrases the diff.

Useful prompts when generating the list:

- Why now? What triggered this change?
- What alternative was rejected, and why?
- What does this unlock or unblock downstream?
- What constraint, incident, or external decision forced this approach?
- Where does this sit in a longer sequence of commits?

Each answer earns its place in the body. Sentences that do not answer one of these questions usually duplicate the diff.

### Worked Example: Stranger's Questions to Body

Consider a diff that renames `parseSpec` to `parseSchema` across a parser package and updates every caller. A stranger reading the diff sees a clean find-and-replace and a passing test suite.

What the diff cannot tell them:

- Why now? The user-facing term changed from "spec" to "schema" in last week's API revision.
- Why not keep both names with a type alias? The next commit introduces an unrelated `parseSpec` for module specifications; the names would collide.

Write only those answers:

```
parser: rename parseSpec to parseSchema for API alignment

Last week's API revision renamed the user-facing term from "spec"
to "schema". An alias was considered but rejected because the next
commit introduces an unrelated parseSpec for module specifications.
```

A typo fix in a doc comment leaves the stranger with no open questions; its body stays empty.

## Length Echoes Complexity

A body's length should echo the diff's complexity. The body is not a place to demonstrate effort; it is a place to answer the questions the diff leaves open.

Rough calibration:

- One-line typo fix: no body
- Small atomic change with a non-obvious why: one or two sentences
- Larger restructuring or design decision: a paragraph, possibly two
- Multi-area refactor with rejected alternatives: several paragraphs

A two-paragraph body on a three-line diff is suspicious - it is almost certainly paraphrasing the diff or restating what the subject already says. Trim until the body's weight matches the diff's weight.

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

A commit has three layers of meaning, and each lives in its own place:

- **The diff is the WHAT** - the change itself, line by line.
- **File comments are the WHY-INTRINSIC** - doc comments, header blocks, and inline notes that explain the file's own decisions. A reader sees them the moment they look at the diff.
- **The commit body is the WHY-EXTRINSIC** - facts about the world around the diff: where this change sits in a longer sequence, what motivated doing it now, what it unlocks downstream, what alternative was rejected, what constraint forced it.

Keep the body in its lane. Its job is the surrounding story the diff cannot show.

### Never Paraphrase the Diff

When the changed file carries its own rationale - header comments, doc comments, inline explanations - restating that material in the body is dead weight. The reader sees those comments the moment they look at the diff. A self-documenting file deserves a brief, outward-pointing body or no body at all. Never a paraphrase.

#### Worked Example: Paraphrase vs. Surrounding Story

**Before** (paraphrases the file's own header about ko, defaults, base image, and platforms):

```
ko separates what to build from how. Top-level default* keys apply
to every build; a builds: array would only override defaults per
import path. Chainguard's static base is a minimal nonroot
distroless-style image suitable for a fully-static Go binary with
no CGO. Two platforms cover Linux nodes of either architecture and
Apple Silicon developer machines.
```

Every claim above is already in the file the reader is about to scroll through. The body adds nothing.

**After** (says only what the file cannot - its place in the sequence and what follows):

```
First step toward publishing the api-gateway image: the file itself
documents the choices it encodes, and subsequent commits introduce
the ko-based reusable workflow that consumes it plus the per-PR and
continuous-integration wiring that drives it.
```

The replacement is shorter and tells the reader something the diff alone cannot: this is step 1 of N, and here is what step 2 looks like.

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

## Authorial Voice

Commit messages enter the project's permanent record. They must sound like the engineer who made the change, not like an agent narrating the task it was given.

### Write as the Human Engineer

The body uses the voice of the engineer who authored the change. That an agent drafted it is incidental and never belongs in the message.

Bad (agent narrating its task):
```
I was asked to refactor the parser, so this commit replaces...
Per the task brief, validation is now applied to...
Following your instructions, the timeout was raised to...
```

Good (engineer describing the change):
```
Replaces the parser so callers receive structured errors instead of
panicking on malformed input.
```

### Never Echo Instructions

Prompts and instructions are directed AT the agent. They are not part of the project's traceability chain. The git log records what the code does and why, not what someone told the agent to do.

Bad (echoing the prompt):
```
The user asked to add validation to login.
As per the spec at <url>, this change introduces retries.
The TODO file said this should be one commit, so...
```

Distil the *intent behind* the instruction into the body's WHY-EXTRINSIC, then drop the instruction itself. The reader cares why the change exists, not which side of the keyboard authored it.

## What NOT to Include

- Information visible in the diff itself
- Paraphrases of comments, doc comments, or header blocks already in the diff
- File listings or line-by-line implementation details
- Markdown formatting (headers, bullets, code blocks)
- Generic phrases like "this commit does X"
- Agent voice ("I was asked to", "per instructions")
- Echoes of user prompts, task briefs, or instruction documents

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

Authoritative body validation. SKILL.md's summary references this list.

- [ ] Provides context NOT visible in the diff
- [ ] Does NOT paraphrase comments, doc comments, or headers in the diff
- [ ] Length is proportional to diff complexity (no padding)
- [ ] Plaintext only (no Markdown)
- [ ] Lines hard-wrapped at 72 characters
- [ ] Paragraphs separated by blank lines
- [ ] URLs wrapped in angle brackets
- [ ] Explains WHY, not WHAT (diff shows what)
- [ ] Voice is the human engineer's, not the agent's
- [ ] No echo of user instructions, prompts, or task briefs
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
