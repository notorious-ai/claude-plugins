---
name: planning-commits
description: Plans a fine-grained sequence of atomic, incremental commits for a non-trivial changeset before any code is written or any commit message is drafted. Language-agnostic; defers message-writing to a separate skill (such as `golang-dev:committing` for Go-centric repos).
when_to_use: Triggers on explicit user requests like "plan commits", "break this into commits", "how should I split this", "commit incrementally", "atomic commits", "fine-grained commits", or scoldings such as "DON'T commit all X at once". Loads proactively at the EARLIEST signal that a non-trivial changeset is forming, regardless of language: when starting work expected to produce more than one capability, when changes have already accumulated across unrelated concerns, or when about to enter a write-and-commit loop on work spanning multiple files or decisions. Triggers ahead of any commit-message-writing skill — the plan is the input those skills consume. Do not wait for the word "commit" to appear in user prose; in any non-trivial task, commits are inevitable and the sequence is best chosen before the first line of code lands.
allowed-tools: Bash(git diff:*) Bash(git log:*) Bash(git status:*)
---

# Planning Commits

Plan the sequence of commits for any non-trivial changeset before writing code, and before drafting commit messages. The skill's output is a plan: a numbered list where each entry states one commit's scope in a single sentence and the context that motivates it.

Commit-message-writing skills consume this plan one entry at a time. Defer all message phrasing to the appropriate writing skill — in a Go-centric repository, `golang-dev:committing`. Planning stops at scope and context; naming the commit is a separate concern handled later.
