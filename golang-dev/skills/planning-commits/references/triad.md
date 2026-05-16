# The Triad: Atomic, Fine-Grained, Incremental

A single coherent rule with three facets, not three independent adjectives. A commit plan satisfies all three together.

## Atomic

Group changes by value — by user-facing capability, by feature, by single decision — never by syntactic category. The test: each commit advances one identifiable piece of value that can be reverted, evaluated, or rebased in isolation from its neighbours.

This rules out the groupings an LLM agent tends to default to:

- All types in one commit, then all functions in the next
- All interfaces first, then all implementations
- All handlers, then all routes, then all tests

Three sibling endpoints `/healthz`, `/readyz`, `/livez` belong in three separate commits because each carries a distinct decision context — not in one "add health endpoints" commit, and not split by handler/route/test layer.

When a commit captures a single decision, its body carries the WHY-EXTRINSIC rationale on top of the code's WHY-INTRINSIC comments. The decision is then revertable in isolation and its downstream effects are easier to evaluate.

## Fine-grained

One reviewable change per commit. An enhancement may touch several files or several fields if they belong to the same value increment; the test is reviewability, not file count.

A two-line diff is fine-grained if it lands one cohesive change. A fifty-file diff is not fine-grained even when every individual edit is small — the reviewer cannot hold the change in their head as a single decision.

## Incremental

Build the final value over a planned sequence of commits. Start with a skeleton — package doc, README outline, type sketch, no-op functions with intent — that names the goal without forward-referencing implementations that do not yet exist on the branch. Then layer capabilities, one per commit.

Flags grow with the features that need them; never land flags up front. Docs travel with the commit that introduces the feature they describe; never accumulate into a trailing docs-dump commit. Tests interleave with the code they exercise; never batch them at the end.
