# Plan Shape

The output of planning is a plan — not a series of commit messages. Each entry in the plan describes one upcoming commit in just enough detail to commit to its scope, no more.

## Entry shape

Each entry has two parts:

**Scope.** A single sentence describing what this commit changes. It is a one-liner, not a properly-formed commit message. Choosing the target, the verb, and the phrasing that meets any repository convention happens later, when the commit-message-writing skill takes over.

**Context.** A paragraph explaining why this commit, why now, and what it deliberately does not include. Capture the constraints, decisions, and trade-offs that justify treating these changes as one reviewable unit. This is the rationale a future reader will look for in the commit body — but at planning time it lives in the plan, not in a written message.

## Hand-off to the message-writing skill

The plan is consumed one entry at a time. For each commit:

1. Stage only the changes for that entry's scope.
2. Load the commit-message-writing skill appropriate to the repository. In a Go-centric repository, that is `golang-dev:committing`.
3. Let that skill choose the target, verb, and body voice. Pass the entry's scope and context as input.

Keep planning and naming separate. Solving both at once overwhelms the working set and produces weaker output on both axes. A plan entry that reads like a good commit message is a sign of premature naming — strip it back to plain prose before continuing.

## Mini-example

A change adding rate limiting to an HTTP client might plan as:

```
1. Introduce a token bucket with no callers
   Land the bucket type, its constructor, and its acquire/release
   methods alongside table-driven tests. No production caller wires
   it in yet, so the commit stands alone as a self-contained primitive
   that a reviewer can evaluate without tracing it through the rest
   of the request path.

2. Apply the bucket to outbound requests
   Wrap the existing transport so each request acquires a token before
   issuing the network call. Add an integration test that exercises
   the limit under concurrent load. The bucket from the previous
   commit is now load-bearing.

3. Make the limit configurable via flag
   Expose the rate as a flag with a default that matches current
   behaviour. Document the flag in the package README. The flag
   arrives only now, because there is finally a feature that varies
   with it.
```

Each entry's scope is a single sentence; the lines that follow are the context paragraph. None of these entries is a commit message; the writing skill produces those when each commit is staged.
