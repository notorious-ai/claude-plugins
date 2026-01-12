# Variables and Constants

Detailed guidance for naming variables, constants, parameters, and method receivers in Go.

## Variable Names

The general rule: **Name length should be proportional to scope size and inversely proportional to usage frequency.**

### Scope-Based Naming Guidelines

| Scope Size | Line Count | Name Length | Examples |
|------------|------------|-------------|----------|
| Small | 1-7 lines | Single letter or very short | `i`, `c`, `n`, `ok` |
| Medium | 8-15 lines | Single word | `count`, `user`, `config` |
| Large | 16-25 lines | Descriptive phrase | `userCount`, `activeUsers` |
| Very Large | 25+ lines | Full context | `httpServerConfig`, `maxRetryAttempts` |

These are guidelines, not strict rules. Apply judgment based on context, clarity, and conciseness.

### General Principles

**Start simple:**
```go
// Good: single words are often sufficient
count := len(items)
users := fetchUsers()
config := loadConfig()
```

**Add words to disambiguate:**
```go
// Good: context makes similar names distinct
userCount := len(users)
projectCount := len(projects)
activeUserCount := len(activeUsers)
```

**Don't drop letters:**
```go
// Bad: trying to save typing
Sbx := getSandbox()

// Good: clear and complete
Sandbox := getSandbox()
```

### Omit Types and Type-Like Words

The compiler knows types; readers usually can infer them from usage:

```go
// Bad: type information redundant
var numUsers int
var usersInt int
var userSlice []User
var ageString string

// Good: type clear from context
var users int        // Count of users
var age string       // Age as string (maybe before parsing)
var names []string   // List of names
```

**Exception:** When two versions exist in scope, type qualifiers help:
```go
// Good: distinguishing forms of same data
ageString := r.FormValue("age")
age, err := strconv.Atoi(ageString)

// Also good: representation qualifiers
limitRaw := r.FormValue("limit")
limit, err := strconv.Atoi(limitRaw)
```

### Omit Information From Surrounding Context

Variable names should reflect content and usage in current context, not origin:

```go
// Bad: in UserCount method
func (s *Service) UserCount() int {
    var userCount int
    // userCount is redundant with method name
}

// Good: context clear from method
func (s *Service) UserCount() int {
    var count int
    // or even just:
    return len(s.users)
}
```

```go
// Bad: repeats surrounding context
func (db *DB) UserCount() (userCount int, err error) {
    var userCountInt64 int64
    if dbLoadError := db.Load("count(distinct users)", &userCountInt64); dbLoadError != nil {
        return 0, fmt.Errorf("failed to load user count: %s", dbLoadError)
    }
    userCount = int(userCountInt64)
    return userCount, nil
}

// Good: context clear from usage
func (db *DB) UserCount() (int, error) {
    var count int64
    if err := db.Load("count(distinct users)", &count); err != nil {
        return 0, fmt.Errorf("load user count: %w", err)
    }
    return int(count), nil
}
```

### Local Variable Name vs. Origin

The best local variable name often differs from the struct field or API name:

```go
// API returns: UserResponse{PreferredName: "Alice"}

// Bad: slavishly following API field name
preferredName := response.PreferredName
fmt.Printf("Hello, %s\n", preferredName)

// Good: local context determines name
name := response.PreferredName
fmt.Printf("Hello, %s\n", name)
```

### Well-Known Abbreviations

Some names are so standard they can be short even in larger scopes:

```go
// Good: universally understood
db := sql.Open("postgres", connStr)
ctx := context.Background()
id := generateID()

// These don't need to be:
database := sql.Open("postgres", connStr)
context := context.Background()
identifier := generateID()
```

## Single-Letter Variable Names

Use single letters sparingly when the full word would be repetitive and meaning is obvious.

### When to Use Single Letters

**Method receiver variables (1-2 letters preferred):**
```go
// Good: receiver abbreviations
func (c *Config) Load() error
func (u *User) Validate() error
func (rw *ResponseWriter) Write([]byte) (int, error)
```

**Familiar variables for common types:**
```go
// Good: conventional single letters
r for io.Reader or *http.Request
w for io.Writer or http.ResponseWriter
b for []byte or *bytes.Buffer
```

**Integer loop variables:**
```go
// Good: indices and coordinates
for i := 0; i < len(items); i++ { }
for i, item := range items { }
for x := 0; x < width; x++ {
    for y := 0; y < height; y++ { }
}
```

**Short-scope loop identifiers:**
```go
// Good: obvious from iteration
for _, n := range nodes {
    process(n)
}

for _, u := range users {
    validate(u)
}
```

### When NOT to Use Single Letters

```go
// Bad: unclear meaning
func process(s string, n int, b bool) error {
    if b {
        return handle(s, n)
    }
    return nil
}

// Good: parameters deserve clear names
func process(config string, maxRetries int, verbose bool) error {
    if verbose {
        return handle(config, maxRetries)
    }
    return nil
}
```

## Receiver Names

Method receiver variables must follow specific rules:

### Rules

1. **Short** - Usually 1-2 letters
2. **Abbreviation of the type** - Not generic like `this` or `self`
3. **Consistent across all methods** - Use same receiver name for all methods of a type

### Examples

```go
// Good: consistent, short, type-based
type Config struct { }

func (c *Config) Load() error { }
func (c *Config) Save() error { }
func (c *Config) Validate() error { }
```

```go
// Good: 2-letter abbreviation when needed
type ResearchInfo struct { }

func (ri *ResearchInfo) Process() error { }
func (ri *ResearchInfo) Export() error { }
```

```go
// Good: first letter of each word
type ResponseWriter struct { }

func (rw *ResponseWriter) Write([]byte) (int, error) { }
func (rw *ResponseWriter) WriteHeader(int) { }
```

### Common Mistakes

| Bad | Why Wrong | Good |
|-----|-----------|------|
| `func (tray Tray)` | Full type name | `func (t Tray)` |
| `func (this *Scanner)` | Generic, not Go idiom | `func (s *Scanner)` |
| `func (self *Scanner)` | Generic, not Go idiom | `func (s *Scanner)` |
| `func (info *ResearchInfo)` | Full word, too long | `func (ri *ResearchInfo)` |

### Consistency is Critical

```go
// Bad: inconsistent receiver names
func (c *Config) Load() error { }
func (cfg *Config) Save() error { }      // Wrong: should be 'c'
func (config *Config) Validate() error { } // Wrong: should be 'c'

// Good: always use 'c' for Config
func (c *Config) Load() error { }
func (c *Config) Save() error { }
func (c *Config) Validate() error { }
```

## Constant Names

Constants use MixedCaps, **never SCREAMING_SNAKE_CASE**.

### Basic Rules

```go
// Good: MixedCaps for constants
const MaxPacketSize = 512
const DefaultTimeout = 5 * time.Second
const maxRetries = 3  // unexported

const (
    ExecuteBit = 1 << iota
    WriteBit
    ReadBit
)
```

```go
// Bad: non-Go conventions
const MAX_PACKET_SIZE = 512       // Wrong: SCREAMING_SNAKE_CASE
const kMaxBufferSize = 1024       // Wrong: k prefix
const KMaxUsersPerGroup = 500     // Wrong: K prefix
```

### Exported vs. Unexported

**Exported** constants start with a capital letter:
```go
// Good: exported constants
const (
    StatusOK           = 200
    StatusNotFound     = 404
    StatusServerError  = 500
)
```

**Unexported** constants start with a lowercase letter:
```go
// Good: unexported constants
const (
    defaultTimeout     = 30 * time.Second
    maxRetries         = 3
    bufferSize         = 4096
)
```

### Name Based on Role, Not Value

Constants should explain what the value represents:

```go
// Bad: name derived from value
const Twelve = 12
const (
    UserNameColumn = "username"
    GroupColumn    = "group"
)

// Good: name explains role
const MonthsPerYear = 12
const (
    DefaultPort = 8080
    MaxConnections = 100
)
```

**If a constant has no role beyond its value, don't create it:**
```go
// Bad: unnecessary constant
const Three = 3
if retries < Three { }

// Good: use the literal
if retries < 3 { }
```

### Initialism Handling in Constants

Initialisms in constants follow the same rules as other identifiers:

```go
// Good: initialism rules apply
const MaxHTTPRetries = 3
const DefaultAPITimeout = 30 * time.Second
const maxURLLength = 2048

// Bad: inconsistent casing
const MaxHttpRetries = 3      // Wrong: Http should be HTTP
const DefaultApiTimeout = 30  // Wrong: Api should be API
```

## Shadowing vs. Stomping

Go allows reusing variable names in specific ways. Understanding the difference prevents bugs.

### Stomping (Same Scope Reuse)

**Stomping:** Using `:=` where at least one variable is new, reusing others in the same scope:

```go
// Good: ctx is intentionally replaced
ctx, cancel := context.WithTimeout(ctx, 3*time.Second)
defer cancel()
// Original ctx is no longer accessible (intended)
```

Use stomping when the original value is no longer needed.

### Shadowing (New Scope, New Variable)

**Shadowing:** Using `:=` in a nested scope creates a NEW variable:

```go
// Bad: shadows outer ctx
func (s *Server) innerHandler(ctx context.Context, req *Request) *Response {
    if *shortenDeadlines {
        ctx, cancel := context.WithTimeout(ctx, 3*time.Second)  // New ctx!
        defer cancel()
        // ...
    }
    // BUG: ctx here is still the ORIGINAL, not the timeout version!
    return s.process(ctx, req)
}
```

**Fix: Use assignment, not declaration:**
```go
// Good: modifies outer ctx
func (s *Server) innerHandler(ctx context.Context, req *Request) *Response {
    if *shortenDeadlines {
        var cancel func()
        ctx, cancel = context.WithTimeout(ctx, 3*time.Second)  // Reuses ctx
        defer cancel()
        // ...
    }
    // ctx is correctly the timeout version if condition was true
    return s.process(ctx, req)
}
```

### Avoiding Accidental Shadowing

```go
// Bad: accidentally shadows err
func process() error {
    err := setup()
    if err != nil {
        return err
    }

    if condition {
        data, err := fetch()  // New err! Shadows outer err
        if err != nil {
            return err
        }
        // ...
    }

    // This err is the OUTER err, not the one from fetch()
    log.Println("Error:", err)  // Might be nil even if fetch() failed!
    return nil
}

// Good: reuse err with assignment
func process() error {
    var data Data
    var err error

    err = setup()
    if err != nil {
        return err
    }

    if condition {
        data, err = fetch()  // Reuses err
        if err != nil {
            return err
        }
        // ...
    }

    return nil
}
```

## Repetition Anti-Patterns

### Variable Name vs. Type

```go
// Bad: type in variable name
var numUsers int
var nameString string
var primaryProject *Project

// Good: type clear from usage
var users int
var name string
var primary *Project
```

### External Context in Names

```go
// Bad: repeating package/function context
func (db *DB) LoadUserFromDatabase(userID int) (*User, error)
func (http *HTTPServer) StartHTTPServer() error

// Good: context already visible
func (db *DB) LoadUser(userID int) (*User, error)
func (http *Server) Start() error
```

## Decision Tree

When naming a variable, constant, or receiver:

```
Variable:
1. How large is the scope?
   Small (< 8 lines): Short name (i, c, n, user)
   Large (> 25 lines): Descriptive name (activeUserCount)

2. Is it a well-known abbreviation?
   Yes: Keep short (db, ctx, id)
   No: Use full word

3. Does it repeat context?
   Package name: Remove it
   Method name: Remove it
   Type: Remove it unless disambiguating

Constant:
1. Use MixedCaps (not SCREAMING_SNAKE_CASE)
2. Name explains role (not value)
3. Exported: capital first letter
4. Unexported: lowercase first letter

Receiver:
1. 1-2 letter abbreviation of type
2. Same name across ALL methods
3. Never "this" or "self"
```

## Real-World Examples

### Good Variable Naming

```go
// Standard library: context clear from scope
func (b *Buffer) Write(p []byte) (n int, err error) {
    // p, n, err: obvious from scope
}

// Standard library: conventional names
func Copy(dst Writer, src Reader) (written int64, err error) {
    // dst, src: conventional abbreviations
}

// Standard library: scope-appropriate length
func (srv *Server) Serve(l net.Listener) error {
    for {
        rw, err := l.Accept()
        if err != nil {
            return err
        }
        c := srv.newConn(rw)
        go c.serve(ctx)
    }
}
```

### Good Constant Naming

```go
// http package: MixedCaps, role-based names
const (
    StatusOK                  = 200
    StatusNotFound            = 404
    StatusInternalServerError = 500
)

// time package: clear role
const (
    Nanosecond  Duration = 1
    Microsecond          = 1000 * Nanosecond
    Millisecond          = 1000 * Microsecond
    Second               = 1000 * Millisecond
)
```

### Good Receiver Naming

```go
// bytes.Buffer: consistent 'b'
func (b *Buffer) Write(p []byte) (n int, err error) { }
func (b *Buffer) Read(p []byte) (n int, err error) { }
func (b *Buffer) Len() int { }

// http.Request: consistent 'r'
func (r *Request) Cookie(name string) (*Cookie, error) { }
func (r *Request) Header() http.Header { }
func (r *Request) URL() *url.URL { }
```
