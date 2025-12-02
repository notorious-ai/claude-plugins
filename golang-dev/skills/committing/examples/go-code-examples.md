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

<examples category="prevent" context="Security, safety, and defensive programming">
<message>runtime: prevent time.Timer.Reset(0) from deadlocking testing/synctest tests</message>
<message>debug/elf: prevent offset overflow</message>
<message>encoding/asn1: prevent memory exhaustion when parsing using internal/saferio</message>
</examples>

<examples category="handle" context="Problem solving, edge cases, special conditions">
<message>cmd/compile: handle loops better during stack allocation of slices</message>
<message>cmd/internal/obj/x86: handle global reference in From3 in dynlink mode</message>
<message>internal/strconv: handle %f with fixedFtoa when possible</message>
<message>cmd/compile: handle rematerialized op for incompatible reg constraint</message>
<message>cmd/link: handle -w flag in external linking mode</message>
</examples>

<examples category="parse" context="Data processing, input handling">
<message>net: parse addresses without separators in ParseMac</message>
<message>mime: parse media types that contain braces</message>
</examples>

<examples category="optimize" context="Performance improvements">
<message>cmd/compile: optimize comparisons with single bit difference</message>
<message>cmd/compile: optimize liveness in stackalloc</message>
<message>cmd/compile: optimize Add64carry with unused carries into plain Add64</message>
<message>strconv: optimize int-to-decimal and use consistently</message>
</examples>

<examples category="remove" context="Cleanup, dead code elimination">
<message>spec: remove restriction on channel element types for close built-in</message>
<message>internal/runtime/cgroup: remove duplicate readString definition</message>
<message>cmd/internal/obj/loong64: remove the incorrect unsigned instructions</message>
<message>encoding/json: remove linknames</message>
<message>net/http: drop unused 'broken' field from persistConn</message>
</examples>

<examples category="simplify" context="Reducing complexity, improving clarity">
<message>internal/runtime/cgroup: simplify escapePath in test</message>
<message>cmd/compile: simplify negative on multiplication</message>
<message>crypto/x509: simplify candidate chain filtering</message>
<message>internal/poll: simplify WriteMsg and ReadMsg on Windows</message>
<message>cmd/link: simplify PE relocations mapping</message>
</examples>

<examples category="eliminate" context="Removing entire concepts or subsystems">
<message>runtime: eliminate _Psyscall</message>
<message>internal/runtime/sys,math/bits: eliminate bounds checks on len8tab</message>
<message>cmd/go: eliminate additional global variable</message>
<message>cmd/compile: eliminate nil checks on .dict arg</message>
<message>all: eliminate unnecessary type conversions</message>
</examples>

<examples category="reduce" context="Efficiency improvements, allocation reduction">
<message>io: reduce intermediate allocations in ReadAll and have a smaller final result</message>
<message>crypto/sha3: reduce cSHAKE allocations</message>
<message>mime: reduce allocs incurred by ParseMediaType</message>
<message>net/url: reduce allocs in Encode</message>
</examples>

<examples category="expose" context="Making internal functionality available">
<message>crypto/hpke: expose crypto/internal/hpke</message>
<message>crypto/tls: expose HelloRetryRequest state</message>
<message>crypto/tls: expose QUIC error events</message>
</examples>

<examples category="track" context="Monitoring, state management">
<message>runtime: track goroutine location until actual STW</message>
<message>runtime: select GC mark workers during start-the-world</message>
</examples>

<examples category="propagate" context="Communication, data flow">
<message>os/signal: propagate cancellation cause from NotifyContext</message>
<message>cmd/compile: propagate unsigned relations for Rsh if arguments are positive</message>
<message>cmd/compile: propagate len([]T{}) to make builtin to allow stack allocation</message>
</examples>

<examples category="enforce" context="Compliance, validation, strictness">
<message>net/url: enforce stricter parsing of bracketed IPv6 hostnames</message>
<message>internal/runtime/cgroup: enforce stricter unescapePath</message>
</examples>

<examples category="define" context="Establishing new types, constants, concepts">
<message>internal/abi: define s390x ABI constants</message>
<message>runtime: define PanicBounds in funcdata.h</message>
</examples>

<examples category="wrap" context="Encapsulation, delegation">
<message>net/http/httputil: wrap ReverseProxy's outbound request body so Close is a noop</message>
<message>go/types,types2: wrap Named.fromRHS into Named.rhs</message>
<message>runtime: wrap procyield assembly and check for 0</message>
</examples>

<examples category="clarify" context="Documentation improvements">
<message>go/types,types2: clarify docs for resolveUnderlying</message>
<message>net/http: clarify panic conditions in Handle, HandleFunc, AddInsecureBypassPattern</message>
<message>cmd/go: clarify the -o testflag is only for copying the binary</message>
<message>fmt: document space behavior of Append</message>
<message>mime: include missing mime type paths in godoc</message>
</examples>

<examples category="deduplicate" context="Code reduction, DRY principle">
<message>runtime: deduplicate pMask resize code</message>
<message>runtime: deduplicate syscall assembly for darwin</message>
</examples>

<examples category="hoist" context="Loop optimization, invariant code motion">
<message>runtime: hoist invariant code out of heapBitsSmallForAddrInline</message>
</examples>

<examples category="validate" context="Verification, correctness checks">
<message>crypto/rsa: check for post-Precompute changes in Validate</message>
<message>debug/elf: validate empty symbol sections consistently</message>
</examples>

<examples category="permit" context="Relaxing restrictions, enabling features">
<message>net/url: permit colons in the host of postgresql:// URLs</message>
<message>spec: permit type parameters on RHS of alias declarations</message>
</examples>

<examples category="refactor" context="Restructuring without functional changes">
<message>cmd/go: refactor usage of requirements</message>
<message>cmd/go: refactor injection of modload.LoaderState</message>
<message>cmd/go: refactor usage of RootMode</message>
</examples>

## Cross-Cutting Changes

<examples category="cross-cutting" context="Changes spanning multiple packages or orthogonal to domain">
<message>all: upgrade vendored dependencies</message>
<message>all: eliminate unnecessary type conversions</message>
</examples>

<examples category="deep-package" context="Packages with paths deeper than two segments - use last two">
<message>internal/runtime/cgroup: enforce stricter unescapePath</message>
<message>runtime/cgroup: resolve path on non-root mount point</message>
<message>crypto/internal/fips140/aes: optimize ctrBlocks8Asm on amd64</message>
</examples>

## Documentation Commits

<examples category="spec" context="Language specification changes">
<message>spec: clarify built-in function new with more precise prose</message>
<message>spec: permit type parameters on RHS of alias declarations</message>
<message>spec: remove restriction on channel element types for close built-in</message>
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
