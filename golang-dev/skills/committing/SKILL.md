---
name: committing
description: Writes commit messages following Go team conventions for both Go packages and supporting files (docs, configs, CI, tooling) in Go-centric codebases (go.mod present or known from context).
when_to_use: Triggers on explicit user requests like "write a commit message", "commit these changes", "generate commit", or "author a commit". Loads proactively at the EARLIEST signal that a commit will follow in a Go-centric repo (go.mod present): when Claude is asked to write code, edit files, refactor, fix a bug, implement a feature, or plan code work in such a repo; when starting any task that will produce a diff; when completing such a task; or when preparing to run git commit. Do not wait for the word "commit" to appear — in a Go codebase, commits are inevitable, and loading these conventions up front avoids a late-stage scramble for the right target and verb.
allowed-tools: Bash(git diff:*) Bash(git log:*) Bash(git status:*)
---

# Committing in Go Projects

Write commit messages that match Go project conventions - for Go packages and all supporting files (docs, configs, CI, scripts) in Go-centric codebases.

## Core Principles

Commits tell the story of a codebase. Follow these rules for every commit:

1. Describe HOW the target changes, not WHAT you did as a developer
2. Think: "This change modifies TARGET to _____"
3. Use plaintext only - no Markdown formatting in commit messages
4. Respect local repository conventions while maintaining Go team style
5. Keep the body in its lane: the diff is the WHAT, file comments are the WHY-INTRINSIC, the commit body is the WHY-EXTRINSIC
6. Write as the human engineer making the change, not as the agent executing a task - never echo prompts or instructions

## Workflow

When generating a commit message:

### 1. Inspect Changes

```bash
git diff --cached    # staged changes
git diff             # if nothing staged
```

### 2. Check Local Conventions

Before deciding on target format, check how similar files were committed:

```bash
git log --oneline -10 -- <changed-file>
git log --oneline -20
```

Look for patterns:
- Does this repo use `ci:` or `github:` for workflow files?
- What package path depth is used for Go code?
- Are there domain-specific prefixes?

Respect local conventions when they exist and are consistent.

### 3. Determine Content Type

Classify the changes to load appropriate guidance:

| Content Type | Files | Load Reference |
|--------------|-------|----------------|
| Go packages | `*.go` files in module paths | `references/go-package-commits.md` |
| Non-Go content | docs, configs, CI, scripts | `references/non-go-commits.md` |
| Mixed changes | Both types | Consider splitting into separate commits |

### 4. Identify Target

Apply the decision algorithm from the appropriate reference file.

**Quick reference for targets:**

| Category | Target Format | Example |
|----------|---------------|---------|
| Go package | `pkg` or `pkg/sub` | `net/http:`, `context:` |
| Documentation | `docs:` | All `.md` files, `docs/` |
| GitHub | `github:` | `.github/` directory |
| Claude Code | `claude:` | `CLAUDE.md`, `.claude/`, `plugin.json` |
| Agents | `agents:` | `agents/` directory |
| Git config | `git:` | `.gitignore`, `.gitattributes` |
| Dependencies | `go.mod:` | Module changes |
| Build | `build:` | Makefile, build scripts |
| CI (non-GitHub) | `ci:` | CI configuration |
| Tool config | Tool name | `golangci:`, `docker:` |

### 5. Select Verb

Find the verb that describes WHAT the target does after the change.

**Fill in the blank:** "This change modifies TARGET to _____"

Common verbs by intent:
- **New functionality**: handle, measure, transform, parse, validate, track, compute
- **New declarations**: define, expose
- **Improvements**: enhance, optimize, refactor
- **Fixes**: fix, respect, correct
- **Removal**: remove, drop
- **Config/docs**: configure, explain, clarify, document, automate

**Avoid developer-action verbs:** add, create, write, implement, make

### 6. Handle Uncertainty

When the target area or verb is ambiguous, use AskUserQuestion to prompt interactively:

```
Present prioritized suggestions:
1. Most likely target based on file paths
2. Alternative targets if applicable
3. Let user select or provide custom
```

Do not guess - ask when:
- Multiple valid targets exist (e.g., file touches both `pkg/` and `docs/`)
- Verb choice significantly affects meaning
- Local conventions conflict with standard patterns

### 7. Construct One-Liner

**Format:** `target: verb phrase`

**Rules:**
- Does NOT start with capital letter
- Is NOT a complete sentence (no period)
- Completes: "This change modifies TARGET to..."
- Aim for 72 characters or less

### 8. Write Body (If Needed)

Three principles govern every body. Apply them in order:

1. **Stranger test** - list the questions a reader who has only the diff would still have. Write only the answers. An empty list means omit the body.
2. **Length echoes complexity** - a two-paragraph body on a three-line diff is suspicious. Trim until the body's weight matches the diff's weight.
3. **Never paraphrase the diff** - if the file's own comments already explain the choices, do not restate them. The body's job is the surrounding story the diff cannot show.

Include body when:
- One-liner alone lacks sufficient context
- Non-obvious design decisions were made
- Future readers need explanation

Skip body when:
- Change is self-explanatory from one-liner + diff
- Simple, mechanical changes (tidy, formatting)

For voice, structure, and worked examples, consult `references/body-guidelines.md`.

### 9. Present for Review

Format the complete message:

```
target: verb phrase

Body paragraph explaining context and reasoning.
Hard wrap at 72 characters per line.
```

## Message Structure

```
target: verb phrase completing "This change modifies TARGET to..."
[blank line]
Paragraph explaining key implications and reasoning.
Include context that helps future readers understand why.
[blank line]
[optional project-tracking references]
```

**Line length limits:**
- One-liner: 72 characters (soft limit)
- Body: 72 characters hard wrap
- Separate paragraphs with blank lines

## Validation Checklist

Before presenting the commit message:

**One-liner:**
- [ ] Target correctly identified (checked local conventions)
- [ ] Verb describes HOW target changes (not what you did)
- [ ] Completes: "This change modifies TARGET to..."
- [ ] No capital letter at start
- [ ] No period at end
- [ ] Within 72 characters

**Body (if present):** Authoritative checklist lives in `references/body-guidelines.md`. At minimum verify:
- [ ] Provides context NOT visible in diff
- [ ] Length proportional to diff complexity
- [ ] Plaintext, 72-char wrap, no Markdown

**Overall:**
- [ ] Will make sense in 6 months during git blame
- [ ] Respects local repository conventions
- [ ] Professional and precise language
- [ ] Voice is the human engineer's, not the agent's
- [ ] No echo of user instructions, prompts, or task briefs

## Reference Files

Load these as needed based on content type:

| File | Contains | Load When |
|------|----------|-----------|
| `references/go-package-commits.md` | Go package targeting, verb selection, examples | Changes include `*.go` files |
| `references/non-go-commits.md` | Non-Go target identification, category-specific guidance | Changes include docs, configs, CI |
| `references/body-guidelines.md` | Body writing guidelines, when to include | Need to write commit body |

## Example Files

| File | Contains |
|------|----------|
| `examples/go-code-examples.md` | Real Go package commit examples |
| `examples/non-go-examples.md` | Docs, config, CI commit examples |

**When to load examples:**

1. **Trivial changes** - Skip examples. The workflow above suffices for straightforward commits.
2. **Ambiguous target or verb** - Grep examples for similar patterns:
   ```bash
   grep -i "verb-keyword" examples/go-code-examples.md
   ```
3. **Sparse repository history** - Load examples in full when the working repo lacks samples to learn from.

Each example file documents its XML tag conventions at the top.

## Special Cases

### Mixed Changes

When changes span both Go code and non-Go files:

1. Consider splitting into separate commits (preferred)
2. If logically unified, choose the PRIMARY functional impact as target
3. Use `all:` only for truly cross-cutting refactoring

### Cross-Package Changes

When Go changes span multiple packages:

1. Check if changes should be separate commits
2. If unified: use shared prefix or `all:`
3. Document reasoning in commit body

### Following Existing Patterns

Always check the repository's commit history first. If the project has established conventions that differ slightly from these guidelines, follow local conventions for consistency.
