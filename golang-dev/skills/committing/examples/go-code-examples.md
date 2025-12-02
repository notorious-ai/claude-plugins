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

<examples category="feature" context="Adding new behavior or capability to a package">
<message>net/url: permit colons in the host of postgresql:// URLs</message>
<message>os/signal: propagate cancellation cause from NotifyContext</message>
<message>runtime: track goroutine location until actual STW</message>
<message>runtime: select GC mark workers during start-the-world</message>
<message>cmd/compile: stack allocate backing stores during append</message>
</examples>

<examples category="cleanup" context="Removing unused code, dead fields, deprecated symbols">
<message>encoding/json: remove linknames</message>
<message>net/http: drop unused 'broken' field from persistConn</message>
</examples>

<examples category="correctness" context="Fixing incorrect behavior without major restructuring">
<message>net/http: correctly close fake net.Conns</message>
<message>debug/elf: validate empty symbol sections consistently</message>
</examples>

<examples category="documentation" context="Improving godoc, comments, or inline documentation">
<message>fmt: document space behavior of Append</message>
<message>mime: include missing mime type paths in godoc</message>
</examples>

<examples category="test-stability" context="Making flaky tests reliable">
<message>net/http: deflake TestClientConnReserveAndConsume</message>
<message-better>net/http: stabilize TestClientConnReserveAndConsume</message-better>
</examples>

<examples category="simplification" context="Reducing complexity or verbosity">
<message>net/http/httputil: wrap ReverseProxy's outbound request body so Close is a noop</message>
<message-better>net/http/httputil: ignore Close on ReverseProxy outbound body</message-better>
</examples>

## Cross-Cutting Changes

<examples category="cross-cutting" context="Changes spanning multiple packages or orthogonal to domain">
<message>all: upgrade vendored dependencies</message>
</examples>

<examples category="deep-package" context="Packages with paths deeper than two segments - use last two">
<message>internal/runtime/cgroup: enforce stricter unescapePath</message>
<message>runtime/cgroup: resolve path on non-root mount point</message>
</examples>

## Documentation Commits

<examples category="spec" context="Language specification changes">
<message>spec: clarify built-in function new with more precise prose</message>
<message>spec: permit type parameters on RHS of alias declarations</message>
</examples>

<examples category="doc" context="Project-level documentation outside godoc">
<message>doc: document go tool pprof -http default change</message>
</examples>

## Bug Fixes

<examples category="bug-fix" context="Correcting incorrect behavior - 'fix' is accepted, alternatives describe resulting behavior">
<message>cmd/compile: fix integer overflow in prove pass</message>
<message-better>cmd/compile: prevent integer overflow in prove pass</message-better>
<message-better>cmd/compile: handle integer overflow in prove pass</message-better>
<message-better>cmd/compile: bound integer values in prove pass</message-better>
</examples>

<examples category="bug-fix" context="Race condition fixes">
<message>sync: fix race condition in WaitGroup counter updates</message>
<message-better>sync: prevent race condition in WaitGroup counter updates</message-better>
<message-better>sync: serialize WaitGroup counter updates</message-better>
</examples>

<examples category="bug-fix" context="Timeout and deadline handling">
<message>net/http: fix timeout handling during TLS handshake</message>
<message-better>net/http: respect timeout during TLS handshake</message-better>
<message-better>net/http: enforce timeout during TLS handshake</message-better>
</examples>

## Anti-Patterns

### ❌ Developer-Action Verbs

<anti-pattern>
<bad>net/http: add timeout handling</bad>
<why_bad>Verb "add" describes what the developer did, not what net/http now does.</why_bad>
<good>net/http: enforce timeout during TLS handshake</good>
</anti-pattern>

<anti-pattern>
<bad>crypto/tls: create QUICErrorType</bad>
<why_bad>Verb "create" describes developer action, not package behavior.</why_bad>
<good>crypto/tls: expose QUIC error events</good>
</anti-pattern>

<anti-pattern>
<bad>encoding/json: implement new decoder</bad>
<why_bad>Verb "implement" describes developer work, not what encoding/json does.</why_bad>
<good>encoding/json: decode streaming responses</good>
</anti-pattern>

<anti-pattern>
<bad>spec: adjust rule for type parameter on RHS of alias declaration</bad>
<why_bad>Verb "adjust" describes editorial action, not what spec now permits.</why_bad>
<good>spec: permit type parameters on RHS of alias declarations</good>
</anti-pattern>

### ❌ Vague Descriptions

<anti-pattern>
<bad>runtime: update code</bad>
<why_bad>Verb "update" says nothing about what runtime does differently.</why_bad>
<good>runtime: track goroutine location until actual STW</good>
</anti-pattern>

<anti-pattern>
<bad>net: change behavior</bad>
<why_bad>Verb "change" provides no information about the new behavior.</why_bad>
<good>net: parse addresses without separators in ParseMac</good>
</anti-pattern>

<anti-pattern>
<bad>cmd/compile: modify logic</bad>
<why_bad>Verb "modify" is generic and doesn't describe the optimization.</why_bad>
<good>cmd/compile: stack allocate backing stores during append</good>
</anti-pattern>

<anti-pattern>
<bad>spec: more precise prose for built-in function new</bad>
<why_bad>Describes the prose style, not what spec now clarifies.</why_bad>
<good>spec: clarify built-in function new with more precise prose</good>
</anti-pattern>
