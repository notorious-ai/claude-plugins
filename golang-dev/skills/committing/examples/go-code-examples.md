# Go Code Commit Examples

Real examples from the Go standard library and representative application commits.

## From Go Standard Library

### One-Liners (No Body Needed)

```
net: parse addresses without separators in ParseMac
```

```
crypto/tls: expose QUIC error events
```

```
net/url: permit colons in the host of postgresql:// URLs
```

```
encoding/json: remove linknames
```

```
os/signal: propagate cancellation cause from NotifyContext
```

```
net/http: drop unused 'broken' field from persistConn
```

```
net/http: correctly close fake net.Conns
```

```
runtime: track goroutine location until actual STW
```

```
runtime: select GC mark workers during start-the-world
```

```
cmd/compile: stack allocate backing stores during append
```

```
fmt: document space behavior of Append
```

```
debug/elf: validate empty symbol sections consistently
```

```
mime: include missing mime type paths in godoc
```

```
net/http: deflake TestClientConnReserveAndConsume

# Better
net/http: stabilize TestClientConnReserveAndConsume
```

```
net/http/httputil: wrap ReverseProxy's outbound request body so Close is a noop

# Better
net/http/httputil: ignore Close on ReverseProxy outbound body
```

### With Body (Context Needed)

```
crypto/x509: prevent HostnameError.Error() from consuming excessive resource

The Error method could allocate excessive memory when
formatting a hostname verification failure. Limit the
displayed hostname length to prevent resource exhaustion.
```

```
runtime: disable stack allocation tests on sanitizers

The memory sanitizer interferes with the stack growth
detection logic, causing spurious test failures. Skip
these tests when running under sanitizers.
```

## Cross-Cutting Changes

```
all: upgrade vendored dependencies
```

```
# From internal/runtime/cgroup
internal/runtime/cgroup: enforce stricter unescapePath
runtime/cgroup: resolve path on non-root mount point
```

## Documentation Commits

```
spec: clarify built-in function new with more precise prose
```

```
spec: permit type parameters on RHS of alias declarations
```

```
doc: document go tool pprof -http default change
```

## Bug Fixes

The verb "fix" is widely accepted in the Go community:

**GOOD:**
```
cmd/compile: fix integer overflow in prove pass
```

**BETTER** - describes the resulting behavior:
```
cmd/compile: prevent integer overflow in prove pass
cmd/compile: handle integer overflow in prove pass
cmd/compile: bound integer values in prove pass
```

**GOOD:**
```
sync: fix race condition in WaitGroup counter updates
```

**BETTER:**
```
sync: prevent race condition in WaitGroup counter updates
sync: serialize WaitGroup counter updates
```

**GOOD:**
```
net/http: fix timeout handling during TLS handshake
```

**BETTER:**
```
net/http: respect timeout during TLS handshake
net/http: enforce timeout during TLS handshake
```

## Anti-Pattern Examples (What NOT to Do)

### Bad: Developer-Action Verbs

```
# BAD
net/http: add timeout handling
crypto/tls: create QUICErrorType
encoding/json: implement new decoder
spec: adjust rule for type parameter on RHS of alias declaration

# GOOD
net/http: enforce timeout during TLS handshake
crypto/tls: expose QUIC error events
encoding/json: decode streaming responses
spec: permit type parameters on RHS of alias declarations
```

### Bad: Vague Descriptions

```
# BAD
runtime: update code
net: change behavior
cmd/compile: modify logic
spec: more precise prose for built-in function new

# GOOD
runtime: track goroutine location until actual STW
net: parse addresses without separators in ParseMac
cmd/compile: stack allocate backing stores during append
spec: clarify built-in function new with more precise prose
```
