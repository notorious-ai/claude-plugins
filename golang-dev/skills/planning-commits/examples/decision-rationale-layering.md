# Decision rationale layered across two layers

A meaningful decision — an architectural choice, a policy switch, an API contract — deserves its own commit even when it does not introduce or remove a dependency. Such a commit creates two layers of rationale:

- The **WHY-INTRINSIC**, embedded as comments or docstrings on the code that implements the decision.
- The **WHY-EXTRINSIC**, captured in the commit body, recording the surrounding story the code itself cannot show.

These two layers serve different readers. Code comments help the reader of the file as it stands today. The commit body helps the reader of `git blame` reconstructing why the decision was taken at that point in time, and which alternatives were considered.

## Plan entry

A team adding a retry policy to its HTTP client might plan as:

```
1. Introduce a retry policy with exponential backoff and full jitter
   Add the retry wrapper around the existing client transport. The
   inline comments name the algorithm and the cap. The commit body
   documents the alternatives that were considered — decorrelated
   jitter, no jitter, fixed delay — and why full jitter won for
   this workload (downstream service tolerates burstiness poorly,
   all clients are long-lived).

2. Apply the retry policy to the payments call site
   Wrap only the payments client call site. Other call sites retain
   their current behaviour and migrate in later commits as their
   owners validate the policy's fit.
```

## What this demonstrates

The atomic facet, in its decision-layering form. Commit 1's diff is small but its commit body is where the next engineer reading `git blame` learns why the team did not pick decorrelated jitter, fixed delay, or any other reasonable alternative. That knowledge survives long after the original conversation is forgotten.

The isolation has two practical consequences:

- **Granular revert.** If the chosen policy proves wrong, the revert affects only commit 1. The call-site applications in commit 2 (and onward) can be retargeted to a different policy without losing the migration progress.
- **Isolated effect evaluation.** Performance, error-rate, and latency comparisons can be attributed to commit 1 specifically. A reviewer or operator investigating a regression bisects to the decision commit, not to a mixed commit where the policy choice and its applications are tangled together.

## Where this differs from the dependency example

The dependency-adoption pattern (see `examples/dependency-adoption-isolated.md`) is the narrow case of this rule, limited to "which library do we depend on". This example is the general form: any decision that future readers will need to defend or revisit benefits from its own commit and the layered rationale.
