# Anti-pattern: flags landed up front

The temptation arises when an agent reads a feature brief, anticipates several flags the work will eventually need, and lands them all at the start "so the wiring is ready". This is one of the most consistent failure modes for LLM agents working from a brief.

## The anti-pattern

A multi-step build-out of an HTTP server gets split as:

```
1. Land all the configuration flags
   Register --addr, --timeout, --rate-limit, --health-timeout,
   --metrics-port, and --tls-cert in main.go. Each flag has a
   default and a help string. No features that consume any of
   these flags exist yet.

2. Wire the listener using --addr
   Read the previously-introduced --addr flag and bind the
   listener.

3. Add the /healthz endpoint using --health-timeout
   Implement the readiness check, consuming the --health-timeout
   flag introduced two commits ago.

[...]
```

## Why this is wrong

Violates both the atomic and incremental facets:

- **Atomic.** Commit 1 lands six flags none of which have a feature behind them. Each flag's default, name, and help string is undefended by any test or use site. A reviewer evaluating commit 1 has nothing to evaluate against.
- **Incremental.** Commits 3 and onward each consume a flag introduced by an earlier commit, which is a forward reference in reverse: the flag was a forward reference to the feature when it landed. By the time the feature arrives, the flag's name and default may no longer fit — but they are now "established" and resist revision.

The user guidance behind this pattern is emphatic: never commit all flags at once. Flags are extended across commits as more features are added requiring more flags.

## Better

See `examples/flags-grow-with-features.md` for the correct shape: each flag lands in the same commit as the feature that consumes it, with a default justified by the feature's observable behaviour.
