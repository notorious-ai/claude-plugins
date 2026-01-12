# Packages and Types

Detailed guidance for naming packages, types, structs, and interfaces in Go.

## Package Names

Go package names should be short and contain only lowercase letters.

### Basic Rules

1. **Lowercase only** - No capitals, no underscores, no hyphens
2. **Single word preferred** - Multi-word names should be unbroken
3. **Short and memorable** - Easy to type and remember
4. **Descriptive** - Clearly indicates what the package provides

```go
// Good: short, lowercase, descriptive
package http
package json
package bytes
package tabwriter

// Bad: wrong casing or separators
package tabWriter    // Wrong: has capital
package TabWriter    // Wrong: has capital
package tab_writer   // Wrong: has underscore
```

### Multi-Word Package Names

When multiple words are needed, leave them unbroken in all lowercase:

```go
// Good: unbroken lowercase
package httputil
package tabwriter
package jsonrpc
package sqldriver

// Bad: don't add separators
package http_util
package tab_writer
package json_rpc
```

### Avoid Common Pitfalls

**Don't use generic names:**
```go
// Bad: uninformative
package util
package utility
package common
package helper
package models
```

These names:
- Provide no information about the package's purpose
- Tempt users to rename on import
- Create namespace pollution
- Make code harder to navigate

**Better alternatives:**
```go
// Good: specific and descriptive
package stringutil  // instead of util
package filehelper  // or better: fileio
package usermodel   // or better: user
```

### Consider the Call Site

Choose names that work well when prefixing symbols:

```go
// Good: clear at call site
db := spannertest.NewDatabaseFromFile(...)  // Clear what this is
_, err := f.Seek(0, io.SeekStart)           // Clear: io package constant
b := elliptic.Marshal(curve, x, y)          // Clear: elliptic curve operation

// Bad: unclear at call site
db := test.NewDatabaseFromFile(...)         // Test of what?
_, err := f.Seek(0, common.SeekStart)       // Common to what?
b := helper.Marshal(curve, x, y)            // Helper for what?
```

### Avoid Shadowing Common Names

Don't choose package names likely to shadow commonly used variable names:

```go
// Bad: "count" is a common variable name
package count  // Shadows: count := len(items)

// Good: more specific
package counter
package usercount
```

### Exceptions: Underscores in Package Names

Underscores are allowed **only** in these specific cases:

1. **Test packages** (black box tests):
   ```go
   // Good: testing exported API only
   package linkedlist_test
   ```

2. **Integration test packages**:
   ```go
   // Good: multi-word integration tests
   package linked_list_service_test
   package user_auth_integration_test
   ```

3. **Package-level documentation examples**:
   ```go
   // Good: example code
   package json_test
   ```

4. **Generated or third-party code** (must rename on import):
   ```go
   // Required: rename generated proto packages
   import foopb "path/to/foo_go_proto"
   ```

### Import Renaming

When you must import a package with underscores or poor naming:

```go
// Good: rename to follow conventions
import (
    foopb "path/to/foo_service_go_proto"
    core "github.com/kubernetes/api/core/v1"
    meta "github.com/kubernetes/apimachinery/pkg/apis/meta/v1beta1"
)
```

## Type Names

Type names should be clear, descriptive nouns using MixedCaps.

### Basic Rules

1. **MixedCaps** - No underscores, no hyphens
2. **Singular nouns** - Type represents one instance
3. **Descriptive** - Purpose clear from name alone
4. **Export consideration** - Capitalize first letter if exported

```go
// Good: clear, descriptive, MixedCaps
type User struct {}
type ResponseWriter interface {}
type HTTPClient struct {}

// Bad: wrong format
type user_data struct {}       // Wrong: underscore
type response_writer interface {} // Wrong: underscore
type HTTP_Client struct {}     // Wrong: underscore
```

### Avoid Repetition with Package

Package and type names work together. Don't repeat the package name in type names:

```go
// Bad: in package "ads/targeting/revenue/reporting"
type AdsTargetingRevenueReport struct{}
// Usage: reporting.AdsTargetingRevenueReport (very repetitive)

// Good: package provides context
type Report struct{}
// Usage: reporting.Report (clear and concise)
```

```go
// Bad: in package "sqldb"
type DBConnection struct{}
// Usage: sqldb.DBConnection (DB appears twice)

// Good: package provides context
type Connection struct{}
// Usage: sqldb.Connection (clear)
```

### Interface Names

Follow standard Go conventions:

**Single-method interfaces:** Often end in "-er"
```go
// Good: standard interface patterns
type Reader interface { Read([]byte) (int, error) }
type Writer interface { Write([]byte) (int, error) }
type Closer interface { Close() error }
type Stringer interface { String() string }
```

**Multi-method interfaces:** Descriptive noun
```go
// Good: clear purpose
type Server interface {
    Start() error
    Stop() error
    Addr() string
}

type FileSystem interface {
    Open(name string) (File, error)
    Create(name string) (File, error)
    Remove(name string) error
}
```

### Struct Names

Use clear, singular nouns:

```go
// Good: singular, descriptive
type User struct {
    ID   int
    Name string
}

type Config struct {
    Timeout time.Duration
    MaxRetries int
}

type HTTPServer struct {
    Addr    string
    Handler Handler
}
```

### Type Parameters (Generics)

Use single capital letters or short, descriptive names:

```go
// Good: conventional single letters
func Keys[K comparable, V any](m map[K]V) []K

// Good: descriptive when needed
func Transform[Input, Output any](in Input, fn func(Input) Output) Output

// Bad: overly long type parameters
func Process[InputType, OutputType any](in InputType) OutputType
```

## Initialisms and Acronyms

Words that are initialisms or acronyms should have consistent casing within the word.

### The Rule

Initialisms should appear as `URL` or `url`, never `Url`:

```go
// Good: consistent casing within initialism
URL           // Exported
url           // Unexported
urlPony       // Unexported variable
URLPony       // Exported type/function

// Bad: inconsistent casing
Url           // Wrong
UrlPony       // Wrong
```

### Common Initialisms

| Initialism | Exported | Unexported | In Name |
|------------|----------|------------|---------|
| URL | `URL` | `url` | `URLParser`, `parseURL` |
| HTTP | `HTTP` | `http` | `HTTPServer`, `httpClient` |
| API | `API` | `api` | `APIKey`, `apiVersion` |
| ID | `ID` | `id` | `UserID`, `userId` |
| DB | `DB` | `db` | `DBConnection`, `dbConfig` |
| JSON | `JSON` | `json` | `JSONEncoder`, `jsonData` |
| XML | `XML` | `xml` | `XMLParser`, `xmlDoc` |
| HTML | `HTML` | `html` | `HTMLTemplate`, `htmlData` |
| SQL | `SQL` | `sql` | `SQLQuery`, `sqlDB` |
| TCP | `TCP` | `tcp` | `TCPConn`, `tcpAddr` |
| UDP | `UDP` | `udp` | `UDPConn`, `udpPort` |
| TLS | `TLS` | `tls` | `TLSConfig`, `tlsCert` |

### Multiple Initialisms

Each initialism should have consistent internal casing:

```go
// Good: each initialism internally consistent
XMLAPI        // XML + API
XMLapi        // Wrong: API should be API or api
xmlAPI        // Good: if unexported

HTTPURL       // HTTP + URL
HTTPUrl       // Wrong: URL should be URL or url
httpURL       // Good: if unexported
```

### Special Cases: Mixed-Case Initialisms

Some initialisms contain lowercase letters (e.g., `iOS`, `gRPC`, `DDoS`):

```go
// Good: preserve standard capitalization
IOS           // Exported (not iOS for export)
iOS           // Unexported
GRPC          // Exported
gRPC          // Unexported
DDoS          // Exported (capital D, lowercase d, capital S)
ddos          // Unexported (all lowercase)
```

| English Usage | Scope | Correct | Incorrect |
|---------------|-------|---------|-----------|
| iOS | Exported | `IOS` | `Ios`, `IoS` |
| iOS | Unexported | `iOS` | `ios` |
| gRPC | Exported | `GRPC` | `Grpc` |
| gRPC | Unexported | `gRPC` | `grpc` |
| DDoS | Exported | `DDoS` | `DDOS`, `Ddos` |
| DDoS | Unexported | `ddos` | `dDoS`, `dDOS` |

### Not All Abbreviations Are Initialisms

Some abbreviations are not initialisms and should use normal MixedCaps:

```go
// Good: not initialisms, use normal MixedCaps
Txn           // Transaction (not TXN)
Auth          // Authentication (not AUTH)
Config        // Configuration (not CONFIG)
Ctx           // Context (not CTX)

// But these ARE initialisms:
ID            // Identification
DB            // Database
API           // Application Programming Interface
```

## Avoiding Repetition Between Package and Type

The package name and type name work together to create the full identifier. Avoid redundancy:

### Package vs. Exported Symbol

```go
// Bad: repetition
widget.NewWidget           // "widget" appears twice
widget.NewWidgetWithName   // Even worse
db.LoadFromDatabase        // "db" and "Database" redundant
goatteleportutil.CountGoatsTeleported  // Way too much

// Good: package provides context
widget.New
widget.NewWithName
db.Load
gtutil.CountGoatsTeleported  // Or better: goatteleport.Count
```

### External Context vs. Local Names

Names should not repeat information from their surrounding context:

```go
// Bad: in package "ads/targeting"
func Process(in *pb.FooProto) *Report {
    adsTargetingID := in.GetAdsTargetingID()  // "ads/targeting" already in package
}

// Good: package provides context
func Process(in *pb.FooProto) *Report {
    id := in.GetAdsTargetingID()  // Clear from usage
}
```

### The Package Provides the Namespace

Think of the package name as part of the identifier:

```go
// Package: encoding/json
type Encoder struct{}        // json.Encoder (not json.JSONEncoder)
func Marshal(v any) []byte   // json.Marshal (not json.MarshalJSON)

// Package: net/http
type Server struct{}         // http.Server (not http.HTTPServer)
type Client struct{}         // http.Client (not http.HTTPClient)
func Get(url string)         // http.Get (already clear it's HTTP)

// Package: database/sql
type DB struct{}             // sql.DB (not sql.Database)
func Open(driver string)     // sql.Open (clear from package)
```

## Real-World Examples from Standard Library

### Good Package + Type Combinations

```go
// Package: bytes
bytes.Buffer           // Not bytes.ByteBuffer
bytes.Reader           // Not bytes.ByteReader

// Package: strings
strings.Builder        // Not strings.StringBuilder
strings.Reader         // Not strings.StringReader

// Package: context
context.Context        // Exception: Context repeated (it's the main type)
context.CancelFunc     // Not context.ContextCancelFunc

// Package: time
time.Time              // Exception: Time repeated (it's the main type)
time.Duration          // Not time.TimeDuration

// Package: io
io.Reader              // Interface, not io.IOReader
io.Writer              // Not io.IOWriter
io.ReadWriter          // Combines two concepts, justified
```

### Package Naming Lessons

```go
// Good: specific, not generic
package httputil       // HTTP utilities (not util or httphelper)
package tabwriter      // Tab writing (not writer or formatter)
package sqldriver      // SQL drivers (not driver)

// Good: domain-focused
package user           // Not usermodel or users
package account        // Not accountmanager
package payment        // Not paymentservice
```

## Decision Tree

When naming a package or type:

```
Package:
1. Single word if possible (http, json, user)
2. Compound word: lowercase, unbroken (httputil, tabwriter)
3. Avoid: util, helper, common, models
4. Test: Does pkg.Type read well at call site?

Type:
1. Singular noun (User, Config, Server)
2. MixedCaps (no underscores)
3. Don't repeat package name
4. Test: Does pkg.Type avoid stuttering?

Initialism:
1. Identify if it's an initialism (URL, ID, API)
2. Exported: all caps (URL, ID, HTTPServer)
3. Unexported: all lowercase (url, id, httpServer)
4. In names: keep together (URLParser not UrlParser)
```
