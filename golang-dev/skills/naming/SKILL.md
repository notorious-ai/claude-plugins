---
name: naming
description: This skill helps name Go identifiers (packages, functions, methods, types, variables, constants, receivers) following Go team conventions and industry best practices. Triggers on user requests like "name this function", "what should I call this", "help me name this variable/type/package", "review these names", or "suggest a better name". Also triggers proactively when the agent creates new Go code elements (functions, types, variables, packages, methods, constants), when reviewing or refactoring existing names for Go idiomaticity, when creating new Go files or packages, or when names appear unclear or violate Go conventions.
---

# Naming in Go

Name Go identifiers following Go team conventions - for packages, functions, methods, types, variables, constants, and receivers.

## Core Principles

Names are the primary documentation readers encounter. Follow these rules for every identifier:

1. **Clarity over brevity** - Names should be clear from their context of use
2. **Context awareness** - Avoid repeating information visible from surrounding context
3. **Scope-proportional length** - Smaller scope → shorter names; larger scope → longer names
4. **Consistency** - Use the same name for the same concept throughout the codebase

## Workflow

When naming a Go identifier:

### 1. Determine the Identifier Type

Classify what you're naming to load appropriate guidance:

| Identifier Type | Examples | Load Reference |
|----------------|----------|----------------|
| Functions/Methods | Public/private functions, methods | `references/functions-and-methods.md` |
| Packages/Types | Package names, structs, interfaces | `references/packages-and-types.md` |
| Variables/Constants | Local vars, parameters, constants | `references/variables-and-constants.md` |
| Test doubles | Stubs, fakes, mocks, test helpers | `references/test-doubles.md` |

### 2. Check Context

Before choosing a name, understand the context where it will be read:

```
Package name:    Visible at every call site (pkg.Function)
Type name:       Visible at declaration and usage
Function name:   Read with package prefix (pkg.DoThing)
Method name:     Read with receiver type (receiver.Method)
Variable name:   Read within scope (usually local)
```

**Key question:** What information is already visible to the reader?

### 3. Apply Naming Rules

**For all identifiers:**
- Use MixedCaps or mixedCaps (no underscores except in test functions)
- Handle initialisms correctly (URL not Url, ID not Id)
- Avoid stuttering (repetition between context and name)

**Quick reference:**

| Category | Format | Example |
|----------|--------|---------|
| Packages | lowercase, no underscores | `encoding`, `httputil` |
| Exported functions | MixedCaps, noun or verb phrase | `Marshal`, `WriteTo` |
| Unexported functions | mixedCaps | `parseHeader`, `readAll` |
| Types | MixedCaps, singular noun | `Reader`, `ResponseWriter` |
| Variables | mixedCaps, scope-proportional | `count`, `c`, `userID` |
| Constants | MixedCaps (not SCREAMING_CASE) | `MaxRetries`, `defaultTimeout` |
| Receivers | 1-2 letters, type abbreviation | `c *Config`, `rw *ResponseWriter` |

### 4. Avoid Common Anti-Patterns

**Repetition:**
```go
// Bad: package name + exported name repeat
package yaml
func ParseYAML(input string) // yaml.ParseYAML()

// Good: package provides context
package yaml
func Parse(input string) // yaml.Parse()
```

**Unnecessary words:**
```go
// Bad: type visible from usage
var nameString string
var usersList []User

// Good: type clear from context
var name string
var users []User
```

**Get prefix:**
```go
// Bad: unnecessary Get prefix
func (c *Config) GetJobName() string

// Good: noun-like name for accessor
func (c *Config) JobName() string
```

### 5. Handle Special Cases

**When functions differ only by type:**
```go
// Good: type suffix for disambiguation
func ParseInt(s string) (int, error)
func ParseInt64(s string) (int64, error)
func AppendInt(buf []byte, i int) []byte
func AppendInt64(buf []byte, i int64) []byte
```

**When variable appears in multiple forms:**
```go
// Good: clarify with representation
limitStr := r.FormValue("limit")
limit, err := strconv.Atoi(limitStr)

// Also good: clarify with raw/parsed
limitRaw := r.FormValue("limit")
limit, err := strconv.Atoi(limitRaw)
```

**When scope has similar concepts:**
```go
// Good: disambiguate with context
userCount := countUsers()
projectCount := countProjects()
```

### 6. Consider Scope

Name length should reflect scope size:

| Scope Size | Line Count | Name Length Guidance |
|------------|------------|---------------------|
| Small | 1-7 lines | Single letter often sufficient (`i`, `c`, `n`) |
| Medium | 8-15 lines | Single word (`count`, `user`, `config`) |
| Large | 16-25 lines | Descriptive phrase (`userCount`, `activeUsers`) |
| Very Large | 25+ lines | Full context (`httpServerConfig`, `maxRetryAttempts`) |

**Exceptions:**
- Well-known abbreviations stay short in any scope (`db`, `ctx`, `id`)
- Specific concepts stay clear regardless of scope (`buffer` not `b` in large scope)

### 7. Validate the Name

Before finalizing, check:

- [ ] No repetition between context and name
- [ ] MixedCaps (or mixedCaps) format, no underscores
- [ ] Initialisms capitalized correctly (URL, ID, API, HTTP)
- [ ] Length proportional to scope
- [ ] Clear from context of use
- [ ] Matches Go stdlib patterns for similar concepts
- [ ] Consistent with existing codebase conventions

## Validation Checklist

Before committing to a name:

**Context awareness:**
- [ ] Name doesn't repeat package name (for exported symbols)
- [ ] Name doesn't repeat type name (for methods)
- [ ] Name doesn't repeat parameter types (for functions)
- [ ] Name doesn't include information visible from surrounding code

**Format:**
- [ ] Uses MixedCaps or mixedCaps (no snake_case)
- [ ] Initialisms use consistent casing (URL not Url)
- [ ] No unnecessary underscores (except test functions)
- [ ] Constants use MixedCaps (not SCREAMING_CASE)

**Clarity:**
- [ ] Length matches scope size
- [ ] Purpose clear to reader at call site
- [ ] Follows Go stdlib patterns for similar concepts
- [ ] Consistent with existing codebase conventions

**Special rules:**
- [ ] Functions returning values use noun-like names
- [ ] Functions doing actions use verb-like names
- [ ] No "Get" prefix (use noun directly)
- [ ] Receivers are 1-2 letters consistently used

## Reference Files

Load these as needed based on identifier type:

| File | Contains | Load When |
|------|----------|-----------|
| `references/functions-and-methods.md` | Function/method naming rules, verb selection, repetition avoidance | Naming functions or methods |
| `references/packages-and-types.md` | Package naming, type naming, struct naming, initialisms | Naming packages, types, interfaces, structs |
| `references/variables-and-constants.md` | Variable scope rules, constant naming, single-letter usage, receivers | Naming variables, parameters, constants, receivers |
| `references/test-doubles.md` | Test package naming, stub/fake/spy naming, local test variables | Creating test helpers or doubles |

## Example Files

| File | Contains |
|------|----------|
| `examples/stdlib-examples.md` | Good naming examples from Go standard library |
| `examples/anti-patterns.md` | Common naming mistakes with corrections |

**When to load examples:**

1. **Straightforward naming** - Skip examples. The workflow above and reference files provide sufficient guidance.

2. **Ambiguous or unfamiliar patterns** - Search examples for similar cases:
   ```bash
   # Search for similar naming patterns
   grep -i "keyword" examples/stdlib-examples.md
   ```

3. **Learning Go naming conventions** - Load examples in full to understand Go team patterns and idioms.

**XML tags for selective searching:**

| Tag | Purpose | Context |
|-----|---------|---------|
| `<example>` | Full example with context and explanation | Detailed learning |
| `<good>` | Correct naming pattern | Best practices |
| `<bad>` | Incorrect naming pattern | Anti-patterns |
| `<better>` | Improved alternative | Refactoring guidance |

## Special Cases

### Test Functions

Test, benchmark, and example functions in `_test.go` files **may** include underscores:

```go
// Good: underscores for readability in test names
func TestConfig_Load_WithInvalidPath(t *testing.T)
func BenchmarkHTTPServer_HandleRequest(b *testing.B)
```

### Package Names with Underscores

Only generated or third-party packages may have underscores. When importing:

```go
// Must rename at import
import foopb "path/to/foo_go_proto"
```

Generated test packages use underscores:
```go
// Good: black box tests
package linkedlist_test

// Good: integration tests
package linked_list_service_test
```

### Single-Letter Variables

Use single letters sparingly and only when meaning is obvious:

```go
// Good: common conventions
r for io.Reader or *http.Request
w for io.Writer or http.ResponseWriter
i, j, k for loop indices
x, y for coordinates
c for counters in very small scope
```

### Shadowing vs. Stomping

**Stomping** (reusing variable in same scope):
```go
// Good: original value no longer needed
ctx, cancel := context.WithTimeout(ctx, 3*time.Second)
defer cancel()
```

**Shadowing** (new variable in nested scope):
```go
// Bad: shadows outer ctx
if condition {
    ctx, cancel := context.WithTimeout(ctx, time.Second)
    defer cancel()
    // ...
}
// ctx here is still the original - BUG!

// Good: use assignment, not declaration
if condition {
    var cancel func()
    ctx, cancel = context.WithTimeout(ctx, time.Second)
    defer cancel()
    // ...
}
```

### Util Packages

Avoid `util`, `helper`, `common` as sole package names. These are uninformative and tempt import renaming.

```go
// Bad: unclear at call site
db := test.NewDatabaseFromFile(...)

// Good: clear what package provides
db := spannertest.NewDatabaseFromFile(...)
```

## When to Ask for User Input

Use AskUserQuestion when:

1. **Multiple valid approaches exist** - Present options for user to choose:
   - Should this be `userConfig` or `config` given the scope?
   - Type name: `Handler` vs `Processor` vs `Manager`?
   - Package name for auth + authorization: `auth` or `authz` or `security`?

2. **Codebase has conflicting conventions** - Let user decide:
   - Existing code uses both `Get` prefix and direct nouns - which to follow?
   - Should we match existing `helper` package name or refactor?

3. **Domain-specific terminology** - User knows domain better:
   - Is this a "session" or "connection" in your domain?
   - Should this match industry term "provisioning" or internal term "setup"?

Do not guess - ask when the name choice significantly affects code clarity or consistency.
