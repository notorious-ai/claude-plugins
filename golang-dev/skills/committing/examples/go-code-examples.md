# Go Code Commit Examples

Real examples from the Go standard library organized by work type.

## Examples with Full Context

<example>
<category>feature</category>
<context>
IEEE EUI guidelines state that MAC addresses can be represented as pure hex
without separators (e.g., "00005e005301"). Azure Instance Metadata Service
uses this format. ParseMAC only accepted colon, hyphen, or dot separators.
</context>
<diff>
src/net/mac.go:
- Changed minimum length check from 14 to 12 characters
- Added new branch for separator-less format: validates even length,
  checks for valid sizes (6, 8, or 20 bytes), parses pairs of hex digits
- Updated docstring to show "00005e005301" format

src/net/mac_test.go:
- Added test case "00005e005301" (valid 6-byte)
- Added test case "0123456789ab" (valid)
- Added test case "0123.4567.89ab" (invalid - dots require 4-char groups)
</diff>
<message>
net: parse addresses without separators in ParseMac
</message>
<why_good>
Verb "parse" describes what net package now does. The diff shows new parsing
capability. Completes: "This change modifies net to parse addresses..."
</why_good>
</example>

<example>
<category>security</category>
<context>
CVE-2025-61729: HostnameError.Error() used string concatenation in a loop,
causing O(N^2) runtime. A malicious certificate with thousands of SAN names
could exhaust memory. Reported by Philippe Antoine (Catena cyber).
</context>
<diff>
src/crypto/x509/verify.go:
- Changed from string concatenation to strings.Builder
- Added maxNamesIncluded = 100 constant
- Early return with count when >= 100 names: "valid for %d names, none matched"
- Uses WriteString instead of += for building output

src/crypto/x509/verify_test.go:
- Added test with certificate containing 1000 DNS names
</diff>
<message>
crypto/x509: prevent HostnameError.Error() from consuming excessive resource

Constructing HostnameError.Error() takes O(N^2) runtime due to using
string concatenation in a loop. A malicious certificate with many names
could unfairly consume resources.

Use strings.Builder and limit displayed names to 100.

Fixes CVE-2025-61729
</message>
<why_good>
Security fix needs body explaining the vulnerability. Verb "prevent" describes
defensive behavior. CVE reference provides traceability.
</why_good>
</example>

<example>
<category>performance</category>
<context>
io.ReadAll allocated excessive intermediate memory during slice growth.
Real-world reports showed 60% more bytes allocated than alternatives,
and 5x more than input size for ~5MiB inputs. Issue #50774.
</context>
<diff>
src/io/io.go:
- Changed growth strategy: read into exponentially growing chunks
- Starting read size 256, grows at 1.5x rate
- Final step copies all chunks into perfectly-sized result slice
- Benchmarks show ~50% reduction in allocations, ~50% faster

Key change: instead of append(b, 0)[:len(b)] growth pattern,
uses chunked reads then single final copy.
</diff>
<message>
io: reduce intermediate allocations in ReadAll and have a smaller final result
</message>
<why_good>
Verb "reduce" describes the performance improvement. The phrase "intermediate
allocations" and "smaller final result" precisely describe both wins.
</why_good>
</example>

<example>
<category>cleanup</category>
<context>
Two concurrent CLs (723241 and 723581) both added identical readString
function definitions. After both merged, the file had duplicate code.
</context>
<diff>
src/internal/runtime/cgroup/line_reader_test.go:
- Removed one of two identical readString function definitions
</diff>
<message>
internal/runtime/cgroup: remove duplicate readString definition

Both CL 723241 and CL 723581 added identical definitions.
</message>
<why_good>
Body explains HOW the duplication happened (merge timing). Verb "remove"
is appropriate for cleanup. Future readers understand it wasn't a mistake.
</why_good>
</example>

<example>
<category>testing</category>
<context>
Memory sanitizer interferes with stack growth detection, causing test flakes.
Need to skip these tests when running under sanitizers.
</context>
<diff>
Added build constraint or runtime check to skip stack allocation tests
when MSAN is active.
</diff>
<message>
runtime: disable stack allocation tests on sanitizers

The memory sanitizer interferes with the stack growth
detection logic, causing spurious test failures. Skip
these tests when running under sanitizers.
</message>
<why_good>
Body explains WHY (sanitizer interference) that diff alone cannot convey.
Future readers will understand the skip is intentional, not a gap in coverage.
</why_good>
</example>

## One-Liners by Work Type

### Feature

<examples category="feature" context="New capability, API addition, enabling functionality">
<message>net: parse addresses without separators in ParseMac</message>
<message>mime: parse media types that contain braces</message>
<message>crypto/tls: expose QUIC error events</message>
<message>crypto/tls: expose HelloRetryRequest state</message>
<message>crypto/hpke: expose crypto/internal/hpke</message>
<message>os/signal: propagate cancellation cause from NotifyContext</message>
<message>net/url: permit colons in the host of postgresql:// URLs</message>
<message>spec: permit type parameters on RHS of alias declarations</message>
<message>internal/abi: define s390x ABI constants</message>
<message>runtime: define PanicBounds in funcdata.h</message>
</examples>

### Performance

<examples category="performance" context="Speed, memory, allocation improvements">
<message>io: reduce intermediate allocations in ReadAll and have a smaller final result</message>
<message>crypto/sha3: reduce cSHAKE allocations</message>
<message>mime: reduce allocs incurred by ParseMediaType</message>
<message>net/url: reduce allocs in Encode</message>
<message>cmd/compile: optimize comparisons with single bit difference</message>
<message>cmd/compile: optimize liveness in stackalloc</message>
<message>cmd/compile: optimize Add64carry with unused carries into plain Add64</message>
<message>strconv: optimize int-to-decimal and use consistently</message>
<message>runtime: hoist invariant code out of heapBitsSmallForAddrInline</message>
<message>runtime: eliminate _Psyscall</message>
<message>internal/runtime/sys,math/bits: eliminate bounds checks on len8tab</message>
<message>cmd/compile: eliminate nil checks on .dict arg</message>
</examples>

### Security

<examples category="security" context="Preventing resource exhaustion, fixing vulnerabilities">
<message>crypto/x509: prevent HostnameError.Error() from consuming excessive resource</message>
<message>runtime: prevent time.Timer.Reset(0) from deadlocking testing/synctest tests</message>
<message>debug/elf: prevent offset overflow</message>
<message>encoding/asn1: prevent memory exhaustion when parsing using internal/saferio</message>
</examples>

### Bug Fix

<examples category="bug-fix" context="Correcting incorrect behavior">
<message>cmd/compile: fix integer overflow in prove pass</message>
<message>sync: fix race condition in WaitGroup counter updates</message>
<message>net/http: fix timeout handling during TLS handshake</message>
<message>net/http: correctly close fake net.Conns</message>
<message>internal/runtime/cgroup: resolve path on non-root mount point</message>
</examples>

### Cleanup

<examples category="cleanup" context="Removing dead code, simplifying, deduplicating">
<message>internal/runtime/cgroup: remove duplicate readString definition</message>
<message>cmd/internal/obj/loong64: remove the incorrect unsigned instructions</message>
<message>encoding/json: remove linknames</message>
<message>net/http: drop unused 'broken' field from persistConn</message>
<message>internal/runtime/cgroup: simplify escapePath in test</message>
<message>cmd/compile: simplify negative on multiplication</message>
<message>crypto/x509: simplify candidate chain filtering</message>
<message>internal/poll: simplify WriteMsg and ReadMsg on Windows</message>
<message>cmd/link: simplify PE relocations mapping</message>
<message>runtime: deduplicate pMask resize code</message>
<message>runtime: deduplicate syscall assembly for darwin</message>
<message>all: eliminate unnecessary type conversions</message>
<message>cmd/go: eliminate additional global variable</message>
</examples>

### Correctness

<examples category="correctness" context="Consistent behavior, handling edge cases">
<message>cmd/compile: handle loops better during stack allocation of slices</message>
<message>cmd/internal/obj/x86: handle global reference in From3 in dynlink mode</message>
<message>internal/strconv: format %f with fixedFtoa when possible</message>
<message>cmd/compile: support rematerialized op for incompatible reg constraint</message>
<message>cmd/link: respect -w flag in external linking mode</message>
<message>net/url: enforce stricter parsing of bracketed IPv6 hostnames</message>
<message>internal/runtime/cgroup: enforce stricter unescapePath</message>
<message>debug/elf: validate empty symbol sections consistently</message>
<message>crypto/rsa: check for post-Precompute changes in Validate</message>
<message>runtime: track goroutine location until actual STW</message>
<message>runtime: select GC mark workers during start-the-world</message>
</examples>

### Documentation

<examples category="documentation" context="Godoc, comments, specs, release notes">
<message>go/types,types2: clarify docs for resolveUnderlying</message>
<message>net/http: clarify panic conditions in Handle, HandleFunc, AddInsecureBypassPattern</message>
<message>cmd/go: clarify the -o testflag is only for copying the binary</message>
<message>fmt: document space behavior of Append</message>
<message>mime: include missing mime type paths in godoc</message>
<message>spec: clarify built-in function new with more precise prose</message>
<message>spec: remove restriction on channel element types for close built-in</message>
<message>doc: document go tool pprof -http default change</message>
</examples>

### Testing

<examples category="testing" context="New tests, test fixes, test infrastructure">
<message>runtime: disable stack allocation tests on sanitizers</message>
<message>cmd/link: test that moduledata is in its own section</message>
<message>cmd/link: test that findfunctab is in gopclntab section</message>
<message>cmd/link: test that funcdata values are in gopclntab section</message>
<message>cmd/go: improve TestScript/reuse_git</message>
</examples>

### Refactoring

<examples category="refactoring" context="Restructuring without functional change">
<message>cmd/go: refactor usage of requirements</message>
<message>cmd/go: refactor injection of modload.LoaderState</message>
<message>cmd/go: refactor usage of RootMode</message>
<message>cmd/go: refactor usage of modRoots</message>
<message>cmd/go: refactor usage of workFilePath</message>
<message>go/types,types2: wrap Named.fromRHS into Named.rhs</message>
<message>runtime: wrap procyield assembly and check for 0</message>
<message>net/http/httputil: wrap ReverseProxy's outbound request body so Close is a noop</message>
</examples>

## Cross-Cutting Changes

<examples category="cross-cutting" context="Changes spanning multiple packages">
<message>all: upgrade vendored dependencies</message>
<message>all: eliminate unnecessary type conversions</message>
</examples>

<examples category="deep-package" context="Packages with paths deeper than two segments - use last two">
<message>internal/runtime/cgroup: enforce stricter unescapePath</message>
<message>crypto/internal/fips140/aes: optimize ctrBlocks8Asm on amd64</message>
</examples>

## Bug Fix Verb Alternatives

The verb "fix" is widely accepted, but alternatives can be more descriptive:

<examples category="bug-fix-alternatives" context="'fix' is acceptable, alternatives describe resulting behavior">
<message>cmd/compile: fix integer overflow in prove pass</message>
<better>cmd/compile: prevent integer overflow in prove pass</better>
<better>cmd/compile: bound integer values in prove pass</better>
</examples>

<examples category="bug-fix-alternatives" context="Race condition fixes">
<message>sync: fix race condition in WaitGroup counter updates</message>
<better>sync: serialize WaitGroup counter updates</better>
</examples>

<examples category="bug-fix-alternatives" context="Timeout handling">
<message>net/http: fix timeout handling during TLS handshake</message>
<better>net/http: respect timeout during TLS handshake</better>
<better>net/http: enforce timeout during TLS handshake</better>
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
<good>cmd/compile: optimize comparisons with single bit difference</good>
</anti-pattern>

<anti-pattern>
<bad>spec: more precise prose for built-in function new</bad>
<why_bad>Describes the prose style, not what spec now clarifies.</why_bad>
<good>spec: clarify built-in function new with more precise prose</good>
</anti-pattern>
