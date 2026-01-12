# Go Naming Anti-Patterns

Common naming mistakes and their corrections.

## Package Names

<anti-pattern>
<category>package-underscores</category>
<context>Using underscores in package names</context>

<bad>
package http_util
package tab_writer
package json_rpc
package user_service
</bad>

<good>
package httputil
package tabwriter
package jsonrpc
package user  // or userservice if needed
</good>

<why>
Go package names should be unbroken lowercase. Underscores make code harder to read and violate Go conventions. The only exceptions are test packages (linkedlist_test) and generated code that must be renamed at import.
</why>
</anti-pattern>

<anti-pattern>
<category>package-capitals</category>
<context>Using capital letters in package names</context>

<bad>
package TabWriter
package httpUtil
package userService
</bad>

<good>
package tabwriter
package httputil
package userservice
</good>

<why>
Package names must be lowercase only. Capitals in package names violate Go conventions and cause confusion.
</why>
</anti-pattern>

<anti-pattern>
<category>package-generic</category>
<context>Using uninformative generic package names</context>

<bad>
package util
package common
package helper
package models
package base
package misc
</bad>

<good>
package stringutil    // Specific: string utilities
package filehelper    // Better: fileio
package user          // Specific domain
package cache         // Specific purpose
</good>

<why>
Generic names provide no information about the package's purpose, tempt users to rename on import, and create confusion. Choose specific, descriptive names that indicate what the package provides.
</why>
</anti-pattern>

<anti-pattern>
<category>package-stuttering</category>
<context>Package name repeated in exported names</context>

<bad>
// In package yaml
func ParseYAML(input string) (*Config, error)
func EncodeYAML(cfg *Config) ([]byte, error)

// Usage:
yaml.ParseYAML(input)   // Repetitive!
yaml.EncodeYAML(cfg)    // Repetitive!
</bad>

<good>
// In package yaml
func Parse(input string) (*Config, error)
func Encode(cfg *Config) ([]byte, error)

// Usage:
yaml.Parse(input)       // Clear and concise
yaml.Encode(cfg)        // Clear and concise
</good>

<why>
The package name is always visible at the call site. Repeating it in the function name creates stuttering: yaml.ParseYAML instead of yaml.Parse.
</why>
</anti-pattern>

## Type Names

<anti-pattern>
<category>type-underscores</category>
<context>Using underscores in type names</context>

<bad>
type User_Data struct{}
type HTTP_Server struct{}
type JSON_Encoder struct{}
type response_writer struct{}
</bad>

<good>
type UserData struct{}
type HTTPServer struct{}
type JSONEncoder struct{}
type responseWriter struct{}
</good>

<why>
Go uses MixedCaps (or mixedCaps), not snake_case. Underscores are not used in type names.
</why>
</anti-pattern>

<anti-pattern>
<category>type-package-repetition</category>
<context>Repeating package name in type name</context>

<bad>
// In package user
type UserManager struct{}
type UserData struct{}
type UserService struct{}

// Usage:
user.UserManager{}  // "user" appears twice
user.UserData{}     // "user" appears twice
</bad>

<good>
// In package user
type Manager struct{}
type Data struct{}
type Service struct{}

// Usage:
user.Manager{}      // Clear from package context
user.Data{}         // Clear from package context
</good>

<why>
The package name provides context. Repeating it in the type name creates stuttering.
</why>
</anti-pattern>

<anti-pattern>
<category>wrong-initialism-casing</category>
<context>Inconsistent initialism casing</context>

<bad>
type Url struct{}           // Wrong: should be URL
type HttpServer struct{}    // Wrong: should be HTTPServer
type JsonEncoder struct{}   // Wrong: should be JSONEncoder
type UserId int            // Wrong: should be UserID
type ApiKey string         // Wrong: should be APIKey
</bad>

<good>
type URL struct{}
type HTTPServer struct{}
type JSONEncoder struct{}
type UserID int
type APIKey string
</good>

<why>
Initialisms should have consistent casing: all caps for exported (URL, HTTP, API) or all lowercase for unexported (url, http, api). Never Url, Http, or Api.
</why>
</anti-pattern>

## Function Names

<anti-pattern>
<category>function-get-prefix</category>
<context>Unnecessary Get prefix on accessors</context>

<bad>
func (c *Config) GetTimeout() time.Duration
func (c *Config) GetName() string
func (u *User) GetEmail() string
func GetUserCount() int
</bad>

<good>
func (c *Config) Timeout() time.Duration
func (c *Config) Name() string
func (u *User) Email() string
func UserCount() int
</good>

<why>
In Go, the "Get" prefix is omitted for accessors. Use noun-like names directly. The only exception is when "Get" is part of the concept (like HTTP GET).
</why>
</anti-pattern>

<anti-pattern>
<category>function-receiver-repetition</category>
<context>Repeating receiver type in method name</context>

<bad>
func (c *Config) WriteConfigTo(w io.Writer) error
func (c *Config) LoadConfigFrom(r io.Reader) error
func (u *User) ValidateUser() error
func (s *Server) StartServer() error
</bad>

<good>
func (c *Config) WriteTo(w io.Writer) error
func (c *Config) LoadFrom(r io.Reader) error
func (u *User) Validate() error
func (s *Server) Start() error
</good>

<why>
The receiver type is visible at the call site (config.WriteTo). Including it in the method name creates repetition.
</why>
</anti-pattern>

<anti-pattern>
<category>function-parameter-repetition</category>
<context>Repeating parameter names/types in function name</context>

<bad>
func OverrideFirstWithSecond(dest, source *Config) error
func CopyFromSourceToDestination(dst, src []byte) error
func TransformConfigToJSON(cfg *Config) []byte
</bad>

<good>
func Override(dest, source *Config) error
func Copy(dst, src []byte) error
func Transform(cfg *Config) []byte
</good>

<why>
Parameters are visible at the call site. Their names and positions make the function's behavior clear without encoding them in the function name.
</why>
</anti-pattern>

<anti-pattern>
<category>function-type-in-name</category>
<context>Including type information unnecessarily</context>

<bad>
func ParseIntFromString(s string) (int, error)
func LoadConfigFromFile(path string) (*Config, error)
func ConvertUserToJSON(u *User) ([]byte, error)
</bad>

<good>
func ParseInt(s string) (int, error)
func LoadConfig(path string) (*Config, error)
func MarshalUser(u *User) ([]byte, error)
// Or even better:
func (u *User) MarshalJSON() ([]byte, error)
</good>

<why>
Type information is visible from function signatures and usage. Including it in the name adds noise without value.
</why>
</anti-pattern>

## Variable Names

<anti-pattern>
<category>variable-type-in-name</category>
<context>Including type information in variable names</context>

<bad>
var numUsers int
var usersList []User
var nameString string
var configStruct *Config
var errorVar error
</bad>

<good>
var users int         // Count of users
var userList []User   // List if needed for clarity
var name string
var config *Config
var err error
</good>

<why>
The compiler knows the type. Readers can infer it from usage. Including type information is redundant except when disambiguating multiple forms of the same data.
</why>
</anti-pattern>

<anti-pattern>
<category>variable-context-repetition</category>
<context>Repeating surrounding context in variable names</context>

<bad>
func (db *DB) UserCount() (userCount int, err error) {
    var userCountInt64 int64
    if dbLoadError := db.Load("count(users)", &userCountInt64); dbLoadError != nil {
        return 0, fmt.Errorf("failed to load user count: %s", dbLoadError)
    }
    userCount = int(userCountInt64)
    return userCount, nil
}
</bad>

<good>
func (db *DB) UserCount() (int, error) {
    var count int64
    if err := db.Load("count(users)", &count); err != nil {
        return 0, fmt.Errorf("load user count: %w", err)
    }
    return int(count), nil
}
</good>

<why>
Context is clear from the method name (UserCount), receiver (DB), and usage. Repeating "user" and "count" in variable names adds noise.
</why>
</anti-pattern>

<anti-pattern>
<category>variable-too-short</category>
<context>Overly abbreviated names in large scopes</context>

<bad>
func ProcessUserData(data []byte) error {
    u, err := ParseUser(data)
    if err != nil {
        return err
    }

    // 20 lines of complex processing...

    if u.Active {  // What is 'u' again?
        return u.Save()
    }
    return nil
}
</bad>

<good>
func ProcessUserData(data []byte) error {
    user, err := ParseUser(data)
    if err != nil {
        return err
    }

    // 20 lines of complex processing...

    if user.Active {  // Clear: it's a user
        return user.Save()
    }
    return nil
}
</good>

<why>
In large scopes, overly short names lose clarity. Use descriptive names that remain clear even when the reader has scrolled away from the declaration.
</why>
</anti-pattern>

<anti-pattern>
<category>variable-too-long</category>
<context>Overly verbose names in small scopes</context>

<bad>
func sumSlice(numbers []int) int {
    totalSumOfAllNumbers := 0
    for _, currentNumberInIteration := range numbers {
        totalSumOfAllNumbers += currentNumberInIteration
    }
    return totalSumOfAllNumbers
}
</bad>

<good>
func sumSlice(numbers []int) int {
    sum := 0
    for _, n := range numbers {
        sum += n
    }
    return sum
}
</good>

<why>
In small scopes with simple logic, overly long names add clutter without improving clarity. Short, clear names are preferred.
</why>
</anti-pattern>

## Receiver Names

<anti-pattern>
<category>receiver-this-self</category>
<context>Using generic receiver names from other languages</context>

<bad>
func (this *Config) Load() error
func (self *Config) Save() error
func (me *Config) Validate() error
</bad>

<good>
func (c *Config) Load() error
func (c *Config) Save() error
func (c *Config) Validate() error
</good>

<why>
Go does not use "this" or "self". Use 1-2 letter abbreviations of the type name.
</why>
</anti-pattern>

<anti-pattern>
<category>receiver-inconsistent</category>
<context>Inconsistent receiver names across methods</context>

<bad>
func (c *Config) Load() error
func (cfg *Config) Save() error
func (config *Config) Validate() error
</bad>

<good>
func (c *Config) Load() error
func (c *Config) Save() error
func (c *Config) Validate() error
</good>

<why>
Receiver names must be consistent across all methods of a type. Choose one abbreviation and use it everywhere.
</why>
</anti-pattern>

<anti-pattern>
<category>receiver-too-long</category>
<context>Using full type name or long abbreviation as receiver</context>

<bad>
func (config *Config) Load() error
func (user *User) Validate() error
func (info *ResearchInfo) Process() error
</bad>

<good>
func (c *Config) Load() error
func (u *User) Validate() error
func (ri *ResearchInfo) Process() error
</good>

<why>
Receivers should be 1-2 letters. Full words are too verbose and not idiomatic Go.
</why>
</anti-pattern>

## Constant Names

<anti-pattern>
<category>constant-screaming-case</category>
<context>Using SCREAMING_SNAKE_CASE for constants</context>

<bad>
const MAX_RETRIES = 3
const DEFAULT_TIMEOUT = 30
const CONNECTION_POOL_SIZE = 100
const HTTP_PORT = 8080
</bad>

<good>
const MaxRetries = 3
const DefaultTimeout = 30
const ConnectionPoolSize = 100
const HTTPPort = 8080
</good>

<why>
Go uses MixedCaps for constants, not SCREAMING_SNAKE_CASE. Follow Go conventions, not C/C++ conventions.
</why>
</anti-pattern>

<anti-pattern>
<category>constant-k-prefix</category>
<context>Using k prefix for constants (C++ convention)</context>

<bad>
const kMaxBufferSize = 1024
const kDefaultTimeout = 30
const kMaxRetries = 3
</bad>

<good>
const MaxBufferSize = 1024
const DefaultTimeout = 30
const MaxRetries = 3
</good>

<why>
The "k" prefix is a C++ convention, not used in Go. Use MixedCaps without prefixes.
</why>
</anti-pattern>

<anti-pattern>
<category>constant-value-based</category>
<context>Naming constants after their values instead of roles</context>

<bad>
const Three = 3
const TwoHundred = 200
const UserNameString = "username"
</bad>

<good>
const MaxAttempts = 3
const StatusOK = 200
const DefaultUserNameColumn = "username"
</good>

<why>
Constant names should explain what the value represents (its role), not describe the value itself.
</why>
</anti-pattern>

## Complete Anti-Pattern Examples

<anti-pattern>
<category>complete-bad-package</category>
<context>A package demonstrating multiple naming issues</context>

<bad>
// Bad: everything wrong in one package
package user_management

type UserManager struct{}

func (this *UserManager) GetUserById(userId int) (*User, error) {
    // ...
}

func (mgr *UserManager) CreateNewUser(userName string) error {
    // ...
}

func CreateUserFromUserName(userName string) *User {
    // ...
}

const MAX_USERS_PER_PAGE = 50
const DEFAULT_USER_TIMEOUT = 30

var usersList []User
var userCount int
</bad>

<good>
// Good: following Go conventions
package user

type Manager struct{}

func (m *Manager) Find(id int) (*User, error) {
    // ...
}

func (m *Manager) Create(name string) error {
    // ...
}

func New(name string) *User {
    // ...
}

const MaxPerPage = 50
const DefaultTimeout = 30

var users []User
var count int
</good>

<why>
Fixed issues:
1. Package: user_management → user (no underscore, concise)
2. Type: UserManager → Manager (no package repetition)
3. Receiver: this/mgr → m (consistent, 1-letter)
4. Method: GetUserById → Find (no Get prefix, no type repetition)
5. Method: CreateNewUser → Create (no redundant "New")
6. Function: CreateUserFromUserName → New (no repetition)
7. Constants: MAX_USERS_PER_PAGE → MaxPerPage (MixedCaps)
8. Variables: usersList → users (no type suffix)
9. Variables: userCount → count (context clear from package)
</why>
</anti-pattern>

<anti-pattern>
<category>shadowing-bug</category>
<context>Accidental variable shadowing causing bugs</context>

<bad>
func (s *Server) handle(ctx context.Context, req *Request) error {
    if *shortenDeadlines {
        // BUG: This creates a NEW ctx in this scope
        ctx, cancel := context.WithTimeout(ctx, 3*time.Second)
        defer cancel()
    }

    // This ctx is the ORIGINAL, not the timeout version!
    return s.process(ctx, req)
}
</bad>

<good>
func (s *Server) handle(ctx context.Context, req *Request) error {
    if *shortenDeadlines {
        var cancel func()
        // This modifies the outer ctx, not creating a new one
        ctx, cancel = context.WithTimeout(ctx, 3*time.Second)
        defer cancel()
    }

    // This ctx is the timeout version if condition was true
    return s.process(ctx, req)
}
</good>

<why>
Using := in a nested scope creates a NEW variable, shadowing the outer one. Use = with var declaration to modify the outer variable.
</why>
</anti-pattern>

## Test Naming Anti-Patterns

<anti-pattern>
<category>test-package-underscores</category>
<context>Unnecessary underscores in test helper package names</context>

<bad>
package user_test_helpers
package credit_card_test
package http_test_utils
</bad>

<good>
package usertest
package creditcardtest
package httptest
</good>

<why>
Test helper packages should append "test" without underscores. The underscore is only used for test FILE names (user_test.go) and black-box test PACKAGE names (package user_test for black-box testing).
</why>
</anti-pattern>

<anti-pattern>
<category>test-double-generic</category>
<context>Using generic "Mock" instead of behavior-based names</context>

<bad>
type Mock struct{}
type MockCreditCard struct{}
type TestDouble struct{}
</bad>

<good>
type AlwaysSucceeds struct{}
type AlwaysFails struct{}
type RecordsCalls struct{}
</good>

<why>
Test double names should describe behavior, making tests self-documenting. "Mock" tells you nothing about what the double does.
</why>
</anti-pattern>
