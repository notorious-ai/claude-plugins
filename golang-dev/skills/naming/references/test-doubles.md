# Test Doubles and Test Helpers

Detailed guidance for naming test packages, test doubles (stubs, fakes, mocks, spies), and test helper functions.

## Test Double Terminology

A **test double** is a testing pattern that stands in for production code:

- **Stub:** Returns predetermined responses, no behavior logic
- **Fake:** Working implementation with shortcuts (e.g., in-memory database)
- **Mock:** Records calls and verifies expectations
- **Spy:** Records calls for later inspection

This guide uses "stub" in examples, but principles apply to all test double types.

## Creating Test Helper Packages

When creating a package for test doubles, follow these conventions.

### Package Naming Pattern

Append "test" to the production package name:

```go
// Production package
package creditcard

// Test helper package
package creditcardtest
```

**Why this works:**
- Clear relationship to production code
- "test" suffix indicates testing purpose
- No underscores (except in package path)

**Examples:**
```go
package user           → package usertest
package payment        → package paymenttest
package authentication → package authenticationtest
```

### Do NOT Use Underscores

```go
// Bad: underscores in test helper package names
package credit_card_test
package user_test
package payment_helper_test

// Good: append "test" without underscore
package creditcardtest
package usertest
package paymenttest
```

**Exception:** Test files themselves may use underscore suffixes:
```go
// These are FILE names, not PACKAGE names:
creditcard_test.go           // black box tests (package creditcard_test)
linked_list_service_test.go  // integration tests
```

## Naming Test Doubles for Single Type

When providing test doubles for one primary type, use concise names based on behavior.

### Simple Case: Single Stub

```go
// Production code
package creditcard

type Service struct { }
func (s *Service) Charge(c *Card, amount money.Money) error { }

// Test package
package creditcardtest

// Good: concise, type clear from package
type Stub struct{}
func (Stub) Charge(*creditcard.Card, money.Money) error { return nil }

// Bad: unnecessarily verbose
type StubService struct{}           // "Service" already implied
type StubCreditCardService struct{} // Way too verbose
```

**At call site:**
```go
import "path/to/creditcardtest"

stub := creditcardtest.Stub{}
// Clear: it's a stub of the creditcard.Service
```

### Multiple Behaviors: Behavior-Based Names

When one stub isn't enough, name based on behavior:

```go
// Good: names describe behavior
type AlwaysCharges struct{}
func (AlwaysCharges) Charge(*creditcard.Card, money.Money) error {
    return nil
}

type AlwaysDeclines struct{}
func (AlwaysDeclines) Charge(*creditcard.Card, money.Money) error {
    return creditcard.ErrDeclined
}

type RecordsCharges struct {
    Charges []Charge
}
func (r *RecordsCharges) Charge(c *creditcard.Card, amt money.Money) error {
    r.Charges = append(r.Charges, Charge{Card: c, Amount: amt})
    return nil
}
```

**At call site:**
```go
stub := creditcardtest.AlwaysCharges{}
stub := creditcardtest.AlwaysDeclines{}
spy := &creditcardtest.RecordsCharges{}
```

## Naming Test Doubles for Multiple Types

When a package has multiple types needing doubles, be more explicit.

### Production Code with Multiple Services

```go
package creditcard

type Service struct { }
func (s *Service) Charge(c *Card, amount money.Money) error { }

type Card struct { }

type StoredValue struct { }
func (s *StoredValue) Credit(c *Card, amount money.Money) error { }
```

### Test Package with Explicit Names

```go
package creditcardtest

// Good: type name included for clarity
type StubService struct{}
func (StubService) Charge(*creditcard.Card, money.Money) error {
    return nil
}

type StubStoredValue struct{}
func (StubStoredValue) Credit(*creditcard.Card, money.Money) error {
    return nil
}
```

**Why explicit?**
- Multiple types being stubbed
- Clear which production type each stub replaces
- No ambiguity at call site

**At call site:**
```go
svc := creditcardtest.StubService{}
store := creditcardtest.StubStoredValue{}
// Clear which production type each replaces
```

## Local Variables in Tests

When using test doubles in test functions, choose names that differentiate doubles from production types.

### Production Code to Test

```go
package payment

import (
    "path/to/creditcard"
    "path/to/money"
)

type CreditCard interface {
    Charge(*creditcard.Card, money.Money) error
}

type Processor struct {
    CC CreditCard
}

func (p *Processor) Process(c *creditcard.Card, amount money.Money) error {
    if c.Expired() {
        return ErrBadInstrument
    }
    return p.CC.Charge(c, amount)
}
```

### Test Code with Clear Double Naming

```go
// Good: prefix clarifies it's a test double
package payment

import "path/to/creditcardtest"

func TestProcessor(t *testing.T) {
    var spyCC creditcardtest.Spy
    proc := &Processor{CC: spyCC}

    // Test code using proc...

    // Verify spy recorded correctly
    if got, want := spyCC.Charges, expectedCharges; !cmp.Equal(got, want) {
        t.Errorf("spyCC.Charges = %v, want %v", got, want)
    }
}
```

**Why prefix helps:**
- `spyCC` clearly distinguishes from production `CreditCard`
- Reader immediately knows `spyCC` is a test double
- No confusion with production types

### Without Prefix (Less Clear)

```go
// Bad: ambiguous whether cc is production or test code
func TestProcessor(t *testing.T) {
    var cc creditcardtest.Spy
    proc := &Processor{CC: cc}

    // Is cc a real credit card processor or a spy?
    // Have to look up the type to know
}
```

## Test Package Patterns

### Black Box Tests (Testing Public API)

Test the exported API using a `_test` package suffix:

```go
// File: linkedlist_test.go
package linkedlist_test  // Note: package name with _test suffix

import (
    "testing"
    "path/to/linkedlist"
)

func TestList_Add(t *testing.T) {
    list := linkedlist.New()
    list.Add(5)
    // ...
}
```

**Key points:**
- **Package name** uses underscore: `linkedlist_test`
- Tests only exported API (like external users would)
- Forces good API design

### White Box Tests (Testing Internal Implementation)

Test internal implementation in the same package:

```go
// File: linkedlist_internal_test.go
package linkedlist  // Same package as production code

import "testing"

func TestInternalNodeStructure(t *testing.T) {
    list := &List{}
    list.head = &node{value: 5}
    // Can access unexported fields
}
```

### Integration Tests

Use descriptive multi-word names with underscores:

```go
// File: linked_list_service_test.go
package linked_list_service_test

// File: user_authentication_integration_test.go
package user_auth_integration_test
```

## Test Function Naming

Test functions **may** use underscores for readability:

```go
// Good: underscores improve test name readability
func TestConfig_Load(t *testing.T)
func TestConfig_Load_WithInvalidPath(t *testing.T)
func TestConfig_Load_ReturnsErrorOnMissingFile(t *testing.T)

func TestHTTPServer_HandleRequest(t *testing.T)
func TestHTTPServer_HandleRequest_WithTimeout(t *testing.T)

func BenchmarkParser_Parse(b *testing.B)
func BenchmarkParser_Parse_LargeInput(b *testing.B)
```

**Pattern:** `Test[Type]_[Method][_OptionalScenario]`

## Common Anti-Patterns

### 1. Generic "Mock" Names

```go
// Bad: no indication of behavior
type Mock struct{}
type MockCreditCard struct{}

// Good: behavior-based names
type AlwaysSucceeds struct{}
type AlwaysFails struct{}
type RecordsCalls struct{}
```

### 2. Overly Complex Stub Names

```go
// Bad: too verbose
type CreditCardServiceStubForTesting struct{}

// Good: package provides context
type Stub struct{}  // In creditcardtest package
```

### 3. Not Prefixing Test Doubles in Test Code

```go
// Bad: looks like production code
func TestProcessor(t *testing.T) {
    cc := creditcardtest.Spy{}
    proc := &Processor{CC: cc}
    // ...
}

// Good: clearly a test double
func TestProcessor(t *testing.T) {
    spyCC := creditcardtest.Spy{}
    proc := &Processor{CC: spyCC}
    // ...
}
```

### 4. Helper Package Name Conflicts

```go
// Bad: "test" alone conflicts with testing package
package test

// Good: specific domain + test
package usertest
package authtest
package paymenttest
```

## Real-World Examples

### Example: HTTP Client Testing

```go
// Production code
package httpclient

type Client interface {
    Get(url string) (*Response, error)
    Post(url string, body []byte) (*Response, error)
}

// Test helper package
package httpclienttest

// Simple stub for basic tests
type Stub struct{}
func (Stub) Get(url string) (*Response, error) { return &Response{}, nil }
func (Stub) Post(url string, body []byte) (*Response, error) { return &Response{}, nil }

// Recording spy for verification
type Spy struct {
    GetCalls  []string
    PostCalls []PostCall
}
func (s *Spy) Get(url string) (*Response, error) {
    s.GetCalls = append(s.GetCalls, url)
    return &Response{}, nil
}
func (s *Spy) Post(url string, body []byte) (*Response, error) {
    s.PostCalls = append(s.PostCalls, PostCall{URL: url, Body: body})
    return &Response{}, nil
}

// Failing stub for error cases
type AlwaysFails struct{}
func (AlwaysFails) Get(url string) (*Response, error) {
    return nil, errors.New("network error")
}
func (AlwaysFails) Post(url string, body []byte) (*Response, error) {
    return nil, errors.New("network error")
}
```

### Example: Database Testing

```go
// Production code
package database

type DB interface {
    Query(sql string) (*Rows, error)
    Exec(sql string) error
}

// Test helper package
package databasetest

// In-memory fake for integration tests
type InMemory struct {
    data map[string][]Row
}
func (db *InMemory) Query(sql string) (*Rows, error) {
    // Simplified implementation
    return &Rows{data: db.data["table"]}, nil
}
func (db *InMemory) Exec(sql string) error {
    // Simplified implementation
    return nil
}

// Stub for unit tests
type Stub struct{}
func (Stub) Query(sql string) (*Rows, error) {
    return &Rows{}, nil
}
func (Stub) Exec(sql string) error {
    return nil
}
```

## Decision Tree

When naming test doubles:

```
1. Creating test helper package?
   → Production package: "creditcard"
   → Test package: "creditcardtest"
   → Never use underscores in package name

2. Single type being doubled?
   → One behavior: type Stub
   → Multiple behaviors: type AlwaysCharges, AlwaysDeclines

3. Multiple types being doubled?
   → Include type: StubService, StubStoredValue

4. Local variable in test?
   → Prefix with double type: spyCC, stubDB, fakeCache

5. Test function name?
   → May use underscores: TestConfig_Load_WithError

6. Integration test package?
   → Descriptive with underscores: user_auth_integration_test
```

## Guidelines Summary

1. **Test package names:** Append "test" (no underscore)
2. **Single type doubles:** Use behavior-based names (`AlwaysSucceeds`)
3. **Multiple type doubles:** Include type name (`StubService`)
4. **Local test variables:** Prefix with double type (`spyCC`)
5. **Test functions:** May use underscores (`TestConfig_Load`)
6. **Integration tests:** May use underscores (`user_auth_test`)
7. **Clear over clever:** Name should make purpose obvious
