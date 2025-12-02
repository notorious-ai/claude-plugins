# Go Package Commits

Detailed guidance for commits that modify Go packages (*.go files).

## Target Identification

Use at most TWO leaf segments of the path from the Go module root.

### The Two-Segment Rule

Always use the **last two segments** of the package path:

| Full Package Path | Target |
|-------------------|--------|
| `fmt` | `fmt` |
| `net/http` | `net/http` |
| `encoding/json` | `encoding/json` |
| `internal/pprof/profile` | `pprof/profile` |
| `golang.org/x/tools/internal/event/export/eventtest` | `export/eventtest` |

### Root Package

Some modules have a Go package at their root. Use the package name directly:

| Module | Root Package | Target |
|--------|--------------|--------|
| `golang.org/x/sync` | `sync` | `sync:` |
| `golang.org/x/text` | `text` | `text:` |
| `github.com/org/mylib` | `mylib` | `mylib:` |

Not all repos have a Go package at root - some start with only `cmd/`, `internal/`, or other directories.

### Domain-Specific Prefixes

For cross-cutting changes that span multiple packages:

- `all:` - Refactoring orthogonal to domain values (e.g., renaming across packages)
- `go.mod:` - Module dependency changes (covered in non-go-commits.md)

When changes affect several packages under a shared parent, use the parent as target:
```
device/activity: ...  }
device/state: ...     } Consider: device: ... (if logically unified)
```

### Decision Algorithm

```
IF changes are in a single Go package:
  → Use last two segments of package path
  → Or single segment if package is shallow
IF changes span multiple packages with shared parent:
  → Use shared parent as target
IF truly cross-cutting (no logical grouping):
  → Use "all:" prefix
```

**Sentence completion test:** "This change modifies package TARGET to..."

## Verb Selection for Go Code

Find the verb that describes WHAT the code does after the change.

### For New Exported Symbols

Look deeper into the changeset:

1. **Check for actual functionality:**
   - Read function names (e.g., `HandleEvents` → use **handle**)
   - Check doc comments for functionality descriptions
   - Review package-level documentation updates

2. **If functionality exists, use the functional verb:**
   - **handle** - processes events, requests
   - **measure** - collects metrics, measures performance
   - **transform** - converts, processes data
   - **parse** - parses input, validates format
   - **validate** - checks correctness, enforces rules
   - **track** - monitors state, records events
   - **compute** - calculates, derives values

3. **If no functionality yet (just declarations):**
   - **define** - adding new types/interfaces before implementation
   - **expose** - making unexported symbols public

### For Modifications

- **enhance** - improved existing logic, better implementation
- **fix** - bug fixes, corrections
- **optimize** - performance improvements
- **refactor** - restructuring without functional changes
- **remove** - deleted code, removed features

### For Tests

- **test** - new tests added (when tests are the primary change)
- Use functional verb if tests accompany functionality

## Anti-Patterns to Avoid

### Bad: Developer-Action Verbs

These describe what YOU did, not how the code changes:

| Bad | Why | Good Alternative |
|-----|-----|------------------|
| `add event handler` | Describes your action | `handle events` |
| `create Config type` | Describes your action | `define Config type` |
| `implement login` | Describes your action | `handle login requests` |
| `write parser` | Describes your action | `parse input format` |

### Bad: Vague Verbs

| Bad | Why | Good Alternative |
|-----|-----|------------------|
| `update code` | Too vague | Specific functional verb |
| `change behavior` | Too vague | What behavior specifically? |
| `modify function` | Too vague | What does it do now? |

### Test: "This change modifies TARGET to..."

Every commit message should complete this sentence naturally:

- ✅ "This change modifies `net/http` to **handle HEAD requests with zero-length bodies**"
- ✅ "This change modifies `context` to **expose deadline exceeded error for testing**"
- ❌ "This change modifies `net/http` to **add a new handler**" (developer action)

## Examples from Go Standard Library

```
net/http: handle HEAD requests with zero-length bodies
encoding/json: optimize marshal performance for large structs
context: expose deadline exceeded error for testing
crypto/tls: validate certificate chains against system roots
io: remove deprecated Reader interface methods
sync: fix race condition in WaitGroup counter updates
runtime: avoid zeroing scavenged memory on allocation
runtime: prioritize panic output over race detector finalization
runtime: track scheduling latency for syscall transitions
```

## Examples from Extended Library (golang.org/x)

```
net/http2: respect connection timeout during handshake
sync/errgroup: limit concurrent goroutines with semaphore
crypto/ssh: parse EdDSA host keys correctly
time/rate: expose burst capacity for token bucket inspection
```

## Examples from Internal Packages

```
pprof/profile: optimize Parse memory allocations
bytealg: compare byte slices using vector instructions
export/eventtest: validate event sequence ordering
```

## Examples from Command-Line Tools

```
cmd/go: document purego build tag convention
cmd/compile: eliminate redundant nil checks in SSA pass
cmd/vet: detect incorrect format strings in log calls
```

## Cross-Package Changes

When changes span multiple packages:

1. **Prefer separate commits** when changes are logically distinct
2. **Use shared prefix** when changes share a parent directory
3. **Use `all:`** only for truly orthogonal refactoring:
   ```
   all: rename Config to Settings across packages
   all: update error wrapping to use %w
   ```

## Choosing Target or Verb

When uncertain which target or verb best fits:

1. Check git history for similar packages:
   ```bash
   git log --oneline -10 -- path/to/package/
   ```

2. If still ambiguous, use AskUserQuestion with prioritized options:
   - Most likely target based on primary functionality
   - Alternative targets if changes span areas
   - Let user select or provide custom target/verb

This uncertainty is about **authoring the commit message** - choosing the right words to describe the change. Developer uncertainty about the code itself (design questions, TODOs) belongs in the commit body; see `references/body-guidelines.md`.
