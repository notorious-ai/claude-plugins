# Functions and Methods

Detailed guidance for naming functions and methods in Go.

## Core Principle: Avoid Repetition

When choosing names for functions and methods, consider the context in which the name will be read. Avoid excess repetition at the call site.

### What Can Be Omitted

The following can generally be omitted from function and method names:

1. **Types of inputs and outputs** (when there's no collision)
2. **Type of a method's receiver**
3. **Whether an input or output is a pointer**
4. **Names of variables passed as parameters**
5. **Names and types of return values**

### For Functions: Don't Repeat Package Name

```go
// Bad: package name repeated
package yamlconfig

func ParseYAMLConfig(input string) (*Config, error)
```

```go
// Good: package provides context
package yamlconfig

func Parse(input string) (*Config, error)
```

**At call site:**
- Bad: `yamlconfig.ParseYAMLConfig(input)` - repetitive
- Good: `yamlconfig.Parse(input)` - clear and concise

### For Methods: Don't Repeat Receiver Type

```go
// Bad: receiver type repeated
func (c *Config) WriteConfigTo(w io.Writer) (int64, error)
```

```go
// Good: receiver type implied
func (c *Config) WriteTo(w io.Writer) (int64, error)
```

**At call site:**
- Bad: `config.WriteConfigTo(writer)` - "Config" appears twice
- Good: `config.WriteTo(writer)` - receiver type already visible

### Don't Repeat Parameter Names

```go
// Bad: parameter names in function name
func OverrideFirstWithSecond(dest, source *Config) error
```

```go
// Good: parameters speak for themselves
func Override(dest, source *Config) error
```

**At call site:**
- Bad: `OverrideFirstWithSecond(defaultConfig, userConfig)` - redundant direction
- Good: `Override(defaultConfig, userConfig)` - clear from parameter order

### Don't Repeat Return Value Information

```go
// Bad: return type in function name
func TransformToJSON(input *Config) *jsonconfig.Config
```

```go
// Good: return type visible at call site
func Transform(input *Config) *jsonconfig.Config
```

**At call site:**
```go
// The return type is visible from usage:
jsonCfg := config.Transform(input)
```

## When to Include Extra Information

When disambiguating functions of a similar name, it's acceptable to include extra information:

```go
// Good: type suffix clarifies which format
func (c *Config) WriteTextTo(w io.Writer) (int64, error)
func (c *Config) WriteBinaryTo(w io.Writer) (int64, error)
```

```go
// Good: specificity needed for multiple similar operations
func (c *Config) MarshalJSON() ([]byte, error)
func (c *Config) MarshalXML() ([]byte, error)
func (c *Config) MarshalYAML() ([]byte, error)
```

## Naming Conventions

### Functions That Return Something: Noun-Like Names

```go
// Good: returns a value, uses noun
func (c *Config) JobName(key string) (value string, ok bool)
func (c *Config) Timeout() time.Duration
func (c *Config) Address() string
```

**Corollary: Avoid "Get" Prefix**

```go
// Bad: unnecessary Get prefix
func (c *Config) GetJobName(key string) (value string, ok bool)
func (c *Config) GetTimeout() time.Duration
```

```go
// Good: noun alone is clear
func (c *Config) JobName(key string) (value string, ok bool)
func (c *Config) Timeout() time.Duration
```

**Exception:** When the concept inherently involves "getting" (e.g., HTTP GET), the prefix may be appropriate:
```go
// Good: GET is part of HTTP semantics
func (c *HTTPClient) Get(url string) (*Response, error)
```

### Functions That Do Something: Verb-Like Names

```go
// Good: performs an action, uses verb
func (c *Config) WriteDetail(w io.Writer) (int64, error)
func (c *Config) Save(path string) error
func (c *Config) Process(input []byte) error
func (c *Config) Validate() error
```

### Identical Functions Differing Only by Type

Include the type name at the end:

```go
// Good: type suffix disambiguates
func ParseInt(input string) (int, error)
func ParseInt64(input string) (int64, error)
func ParseFloat(input string) (float64, error)

func AppendInt(buf []byte, value int) []byte
func AppendInt64(buf []byte, value int64) []byte
func AppendBool(buf []byte, value bool) []byte
```

### When There's a Clear "Primary" Version

The type can be omitted from the primary version:

```go
// Good: Marshal is the primary version
func (c *Config) Marshal() ([]byte, error)
func (c *Config) MarshalText() (string, error)
func (c *Config) MarshalBinary() ([]byte, error)
```

## Common Verb Patterns

Choose verbs that describe what the function does:

| Pattern | Verbs | Examples |
|---------|-------|----------|
| Transform data | Parse, Format, Encode, Decode, Marshal, Unmarshal | `ParseInt`, `FormatTime` |
| Read/Write | Read, Write, Load, Save, Fetch, Store | `ReadFile`, `WriteTo` |
| Modify state | Add, Remove, Update, Delete, Set, Reset | `AddHeader`, `RemoveItem` |
| Check/Validate | Validate, Check, Verify, Ensure, Contains | `ValidateEmail`, `Contains` |
| Create/Initialize | New, Make, Create, Build, Init | `NewReader`, `MakeSlice` |
| Process | Process, Handle, Execute, Run, Apply | `HandleRequest`, `Execute` |

## Anti-Patterns to Avoid

### 1. Type Information in Variable Names

```go
// Bad: types already visible
func LoadFromDatabase(dbConnection *sql.DB) error
func ProcessUserSlice(userSlice []User) error
```

```go
// Good: types clear from usage
func Load(db *sql.DB) error
func ProcessUsers(users []User) error
```

### 2. Redundant Context

```go
// Bad: in package "ads/targeting"
func ProcessAdsTargetingRequest(req *Request) error
```

```go
// Good: package provides context
func ProcessRequest(req *Request) error
// Call site: targeting.ProcessRequest(req)
```

### 3. Unnecessary Qualifiers

```go
// Bad: qualifiers don't add information
func DoWork() error
func PerformCalculation() int
func ExecuteOperation() error
```

```go
// Good: direct and specific
func Work() error
func Calculate() int
func Execute() error
```

## Method Receiver Naming

See `variables-and-constants.md` for detailed receiver naming guidance.

Quick reference:
- Use 1-2 letter abbreviation of the type
- Be consistent across all methods
- Avoid generic names like `this` or `self`

```go
// Good: consistent receiver naming
func (c *Config) Load() error
func (c *Config) Save() error
func (c *Config) Validate() error
```

## Real-World Examples

### Standard Library Patterns

```go
// io package: direct verb names
func Copy(dst Writer, src Reader) (int64, error)
func ReadAll(r Reader) ([]byte, error)
func WriteString(w Writer, s string) (int, error)

// strings package: verb describes action
func Contains(s, substr string) bool
func HasPrefix(s, prefix string) bool
func TrimSpace(s string) string

// time package: noun-like accessors
func (t Time) Year() int
func (t Time) Month() Month
func (t Time) Day() int

// http package: HTTP verbs as methods
func (c *Client) Get(url string) (*Response, error)
func (c *Client) Post(url, contentType string, body io.Reader) (*Response, error)
```

### When to Disambiguate

```go
// Good: format clarifies the output
func (c *Config) String() string
func (c *Config) GoString() string

// Good: protocol version differentiation
func (s *Server) ServeHTTP(w ResponseWriter, r *Request)
func (s *Server) ServeHTTP2(w ResponseWriter, r *Request)

// Good: encoding format specified
func (m *Message) MarshalJSON() ([]byte, error)
func (m *Message) MarshalXML() ([]byte, error)
func (m *Message) MarshalBinary() ([]byte, error)
```

## Decision Tree

When naming a function or method:

```
1. What does it do?
   → Returns value: Use noun (JobName, Timeout, Address)
   → Performs action: Use verb (Write, Process, Validate)

2. Is there context to remove?
   → Package name in function: Remove it
   → Receiver type in method: Remove it
   → Parameter names/types: Remove them
   → Return type: Usually remove it

3. Are there similar functions?
   → Add type suffix (ParseInt, ParseInt64)
   → Add format suffix (MarshalJSON, MarshalXML)
   → Add qualifier (ServeHTTP, ServeHTTP2)

4. Validate:
   → Read at call site: Clear and concise?
   → No "Get" prefix for accessors?
   → Follows stdlib patterns?
```
