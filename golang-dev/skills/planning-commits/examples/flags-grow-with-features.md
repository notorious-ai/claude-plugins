# Flags grow with the features they enable

A command-line tool, server, or library accumulates flags as it gains capabilities. The temptation is to land all anticipated flags up front so the wiring is "ready" for later work. Resist this: a flag without a feature behind it has no behaviour to demonstrate, test, or document.

## Plan entry

A multi-step build-out of an HTTP server might plan as:

```
1. Land the server skeleton and the --addr flag
   Wire main(), the listener, and the only flag the skeleton actually
   needs: the bind address. The server logs requests and returns 204
   to everything. Flags for behaviours that do not yet exist
   (--timeout, --rate-limit, --metrics) wait for their respective
   features.

2. Handle the /healthz endpoint and add --health-timeout
   Implement the readiness check this endpoint exposes, and add the
   flag that governs its threshold. The flag arrives with the feature
   that consumes it.

3. Apply per-route rate limiting and add --rate-limit
   The rate-limit token bucket lands together with the flag that
   configures its rate. The default matches the unlimited behaviour
   from commits 1 and 2, so the introduction is non-breaking.
```

## What this demonstrates

The atomic facet, expressed through value-grouping. Each commit's flag is part of the same value increment as the feature it controls. Reading commit 3 alone tells a reviewer everything about why `--rate-limit` exists and what its default means — they do not have to scan an earlier flag block hoping to find the rationale.

It also avoids dead-on-arrival configuration. A flag introduced before its feature has no test coverage, no documentation grounded in observable behaviour, and no way to defend its name or default against later requirements.
