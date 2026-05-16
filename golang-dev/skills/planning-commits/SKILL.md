---
name: planning-commits
description: Plans a fine-grained sequence of atomic, incremental commits for a non-trivial changeset before any code is written or any commit message is drafted. Language-agnostic; defers message-writing to a separate skill (such as `golang-dev:committing` for Go-centric repos).
when_to_use: Triggers on explicit user requests like "plan commits", "break this into commits", "how should I split this", "commit incrementally", "atomic commits", "fine-grained commits", or scoldings such as "DON'T commit all X at once". Loads proactively at the EARLIEST signal that a non-trivial changeset is forming, regardless of language: when starting work expected to produce more than one capability, when changes have already accumulated across unrelated concerns, or when about to enter a write-and-commit loop on work spanning multiple files or decisions. Triggers ahead of any commit-message-writing skill — the plan is the input those skills consume. Do not wait for the word "commit" to appear in user prose; in any non-trivial task, commits are inevitable and the sequence is best chosen before the first line of code lands.
allowed-tools: Bash(git diff:*) Bash(git log:*) Bash(git status:*)
---

# Planning Commits

Plan the sequence of commits for any non-trivial changeset before writing code, and before drafting commit messages. The skill's output is a plan: a numbered list where each entry states one commit's scope in a single sentence and the context that motivates it.

Commit-message-writing skills consume this plan one entry at a time. Defer all message phrasing to the appropriate writing skill — in a Go-centric repository, `golang-dev:committing`. Planning stops at scope and context; naming the commit is a separate concern handled later.

## Core Principles

A commit plan satisfies three facets together — atomic, fine-grained, incremental:

- **Atomic.** Group changes by value (user-facing capability, feature, single decision), not by syntactic category (all types, all interfaces, all handlers). Each commit advances one identifiable piece of value that can be reverted, evaluated, or rebased in isolation from its neighbours.
- **Fine-grained.** Each commit lands one reviewable change. The test is reviewability, not file count: a two-line diff can be fine-grained, a fifty-file diff is not, regardless of how small each edit is.
- **Incremental.** Build the final value over a planned sequence. Start with a skeleton; layer capabilities; never forward-reference symbols or behaviours that do not yet exist on the branch.

For the full definitions, including the value-vs-syntactic distinction and the decision-rationale-layering benefit, consult `references/triad.md`.

## Reference Files

| File | Contains | Load When |
|------|----------|-----------|
| `references/triad.md` | Full definitions of atomic, fine-grained, incremental, with the value-vs-syntactic distinction | First time the skill triggers in a session |
| `references/plan-shape.md` | Shape of a plan entry, hand-off to the message-writing skill, worked mini-example | Before producing the plan deliverable |

## When to Plan

Plan commits proactively at the earliest signal that the work ahead is non-trivial:

- A user brief mentions more than one capability, feature, or decision.
- The working tree already contains unstaged changes spanning unrelated concerns.
- The expected diff is larger than what a reviewer can hold in their head as one decision.
- A user has scolded about commit shape, granularity, or sequence in a prior turn.

Do not wait for the word "commit" to appear in user prose. In any non-trivial task, commits are inevitable and the sequence is best chosen before the first line of code lands.

## When to Skip Planning

Some changesets do not warrant a plan:

- **Mechanical edits.** Typo fixes, formatting passes, dependency-only `go.mod tidy`, single-line bug fixes. The plan would have one entry; producing it is overhead.
- **Exploratory work.** The user has signalled they are "playing around" or "just trying something" and no commits are planned for this session. Wait for the user to convert exploration into intent before planning.
- **Single-capability changesets.** When the entire diff is the smallest version of one reviewable change, the plan has one entry — which is to say there is nothing to plan. Hand off to the message-writing skill directly.

When skipping, do not ask. Proceed to writing directly and let the user redirect if they want a plan after all.

## Workflow

When planning commits for a non-trivial changeset:

### 1. Inspect the Working Tree

```bash
git status
git diff
```

Identify what has changed and what remains to be changed. If the work has not started, inspect the brief itself — what the user described, which files will likely change.

### 2. Identify Capabilities and Decisions

Read the changeset or brief for distinct units of value:

- User-facing capabilities (endpoints, commands, public APIs, features).
- Single decisions worth isolating (dependency choices, policy switches, architectural commitments).
- Documentation that travels with each capability.

If the first instinct is to group by symbol kind, abstraction layer, or mechanical role, stop. Consult `examples/antipattern-by-symbol-kind.md`, `examples/antipattern-by-layer.md`, or `examples/antipattern-by-mechanical-layer.md` to recognise the failure mode.

### 3. Draft the Plan

Produce a numbered list in the shape defined by `references/plan-shape.md`. For each entry:

- A single sentence stating the scope.
- A paragraph stating the context: why this commit, why now, what it deliberately does not include.

Start with a skeleton commit when the work introduces a new package, module, or subsystem (see `examples/skeleton-first.md`). Layer capabilities one per commit, each carrying the docs, flags, and tests it justifies.

### 4. Present for Approval

Show the plan to the user. Make it easy to redirect:

- Number each entry so the user can reference individual commits.
- Keep entries brief enough that the whole plan fits in one screen.
- Invite specific corrections rather than open-ended feedback.

The plan is a proposal, not a contract. Adjust it freely as the user redirects.

### 5. Hand Off Each Commit to the Message-Writing Skill

When implementing a commit from the plan:

1. Stage only the changes for that entry's scope.
2. Load the commit-message-writing skill appropriate to the repository — in a Go-centric repository, `golang-dev:committing`.
3. Pass the entry's scope and context as input to that skill, which produces the actual commit message.

The plan entry is the input; the commit message is the output of the message-writing skill, not of this one.

## Example Files

| File | Pattern | Demonstrates |
|------|---------|--------------|
| `examples/skeleton-first.md` | First commit lays the ground | Incremental |
| `examples/flags-grow-with-features.md` | Flags arrive with their feature | Atomic |
| `examples/siblings-by-decision.md` | Sibling endpoints split by contract | Atomic |
| `examples/docs-with-feature.md` | Docs travel with their feature | Incremental |
| `examples/dependency-adoption-isolated.md` | Dependency choice gets its own commit | Atomic (decision layering) |
| `examples/decision-rationale-layering.md` | Decision body carries WHY-EXTRINSIC | Atomic (decision layering) |
| `examples/antipattern-by-symbol-kind.md` | All types, then all methods | Counter-example |
| `examples/antipattern-by-layer.md` | Interfaces, then implementations | Counter-example |
| `examples/antipattern-by-mechanical-layer.md` | All handlers, then routes, then tests | Counter-example |
| `examples/antipattern-flags-up-front.md` | All flags at the start | Counter-example |
| `examples/antipattern-trailing-docs-dump.md` | Docs piled into a final commit | Counter-example |
