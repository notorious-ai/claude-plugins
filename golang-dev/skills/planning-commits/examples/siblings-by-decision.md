# Siblings by decision context

Three endpoints, three RPC methods, three commands, three subscribers — surface-level siblings that look like they belong together. The temptation is to land them as one commit: "add the three health endpoints." Resist this when each sibling carries a distinct decision context, even if their wiring is similar.

## Plan entry

A Kubernetes-facing service exposing the three probe endpoints might plan as:

```
1. Wire /healthz as a liveness signal
   The endpoint returns 200 unconditionally once the process has
   started. Document in code and README that this is the liveness
   contract: the answer is "is the process alive?", not "is the
   process working?". The narrow contract is the decision worth
   isolating.

2. Wire /readyz to gate traffic on dependency reachability
   The endpoint returns 200 only once startup probes against the
   database and message bus have succeeded. The set of checked
   dependencies is the decision worth isolating — it determines
   when this pod accepts traffic from the service mesh, distinct
   from whether it should be restarted.

3. Wire /livez as the kubelet's restart trigger
   The endpoint returns 200 unless an internal watchdog has flagged
   an unrecoverable state (deadlock, exhausted goroutine pool). The
   restart criteria are the decision worth isolating, and they are
   strictly stronger than /healthz's "process alive" check.
```

## What this demonstrates

The atomic facet. The three endpoints share handler shape and routing, but each lands in its own commit because each answers a different question. A reviewer evaluating commit 2 in isolation can debate which dependencies belong in the readiness set without their attention being split across the other two endpoints.

A single "add health endpoints" commit would force the reviewer to either evaluate all three contracts at once (cognitive overload) or skim past contracts they care less about (review hygiene loss). Splitting by decision context makes each contract independently revertable, evaluable, and rebaseable.

## Compare with mechanical splits

Splitting the same work by syntactic role — "all handlers in commit 1, all routes in commit 2, all tests in commit 3" — would produce three commits that nobody can review in isolation, because the value of any one is distributed across all three.
