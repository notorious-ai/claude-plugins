# Go Code Commit Examples

Real examples from the Go standard library and representative application commits.

## Examples with Full Context

<example>
<context>
Adding support for MAC address formats without colons or hyphens (e.g., "0123456789ab").
</context>
<diff>
src/net/mac.go: Added new case in ParseMAC for 12-character strings without
separators. Validates length, parses as hex, returns 6-byte hardware address.
Added format to docstring.

src/net/mac_test.go: Added test cases for "0123456789ab" (valid) and
"0123.4567.89ab" (invalid - dots not supported).
</diff>
<message>
net: parse addresses without separators in ParseMac
</message>
<why_good>
Verb "parse" describes what the package now does. Completes: "This change
modifies net to parse addresses without separators in ParseMac."
</why_good>
</example>

<example>
<context>
HostnameError.Error() method concatenates many SAN names, causing memory
exhaustion with malicious certificates containing thousands of names.
</context>
<diff>
src/crypto/x509/verify.go: Changed Error() to use strings.Builder instead of
repeated concatenation. Added 100-name limit with "... (and N more)" suffix.

src/crypto/x509/verify_test.go: Added test with 1000 DNS names verifying the
limit is enforced.
</diff>
<message>
crypto/x509: prevent HostnameError.Error() from consuming excessive resource

The Error method could allocate excessive memory when
formatting a hostname verification failure. Limit the
displayed hostname length to prevent resource exhaustion.
</message>
<why_good>
Body explains the security motivation not visible in diff. Verb "prevent"
describes resulting behavior (defense against resource exhaustion).
</why_good>
</example>

<example>
<context>
QUIC implementation needs to surface TLS errors to application layer.
</context>
<diff>
(Diff unavailable - reconstructed from commit message context)
New exported type QUICEncryptionLevel and QUICEvent types added. QUICConn
gains methods to retrieve error events during handshake.
</diff>
<message>
crypto/tls: expose QUIC error events
</message>
<why_good>
Verb "expose" indicates making internal functionality available externally.
Avoids "add QUIC error support" which describes developer action.
</why_good>
</example>

<example>
<context>
Memory sanitizer interferes with stack growth detection, causing test flakes.
</context>
<diff>
(Diff unavailable - reconstructed from commit message context)
Added build constraint or runtime check to skip stack allocation tests when
MSAN is active.
</diff>
<message>
runtime: disable stack allocation tests on sanitizers

The memory sanitizer interferes with the stack growth
detection logic, causing spurious test failures. Skip
these tests when running under sanitizers.
</message>
<why_good>
Body provides context about WHY (sanitizer interference) that diff alone
cannot convey. Future readers will understand the skip is intentional.
</why_good>
</example>

## One-Liners (No Body Needed)

These commits are self-explanatory from the one-liner plus diff:

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

**With alternatives:**

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

## Cross-Cutting Changes

```
all: upgrade vendored dependencies
```

```
# From internal/runtime/cgroup - two-segment rule applied
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
