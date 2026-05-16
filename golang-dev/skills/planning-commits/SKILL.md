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
