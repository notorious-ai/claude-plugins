# Go Standard Library Naming Examples

Good naming examples from the Go standard library organized by category.

## Package Names

<example>
<category>package-naming</category>
<context>Standard library packages demonstrate excellent package naming</context>

<good>
// Single word, lowercase, descriptive
package fmt        // Formatted I/O
package io         // Input/output primitives
package os         // Operating system functionality
package http       // HTTP client and server (in net/http)
package json       // JSON encoding/decoding (in encoding/json)
package time       // Time measurement and display
package bytes      // Byte slice manipulation
package strings    // String manipulation
package errors     // Error handling
</good>

<good>
// Multi-word: unbroken lowercase
package filepath   // File path manipulation (not file_path)
package httputil   // HTTP utilities (not http_util)
package tabwriter  // Tab-aligned writer (not tab_writer)
package strconv    // String conversions (not str_conv)
</good>
</example>

## Type Names

<example>
<category>type-naming</category>
<context>Types paired with their packages show no stuttering</context>

<good>
// Package + type work together
bytes.Buffer        // Not bytes.ByteBuffer
bytes.Reader        // Not bytes.ByteReader
strings.Builder     // Not strings.StringBuilder
strings.Reader      // Not strings.StringReader
http.Server         // Not http.HTTPServer
http.Client         // Not http.HTTPClient
json.Encoder        // Not json.JSONEncoder
json.Decoder        // Not json.JSONDecoder
sql.DB              // Not sql.Database
</good>
</example>

<example>
<category>interface-naming</category>
<context>Single-method interfaces often end in -er</context>

<good>
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

type Closer interface {
    Close() error
}

type Stringer interface {
    String() string
}

type Marshaler interface {
    MarshalJSON() ([]byte, error)
}
</good>
</example>

## Function Names

<example>
<category>function-naming-verbs</category>
<context>Functions doing actions use verb phrases</context>

<good>
// io package - action verbs
func Copy(dst Writer, src Reader) (written int64, err error)
func ReadAll(r Reader) ([]byte, error)
func WriteString(w Writer, s string) (n int, err error)

// strings package - descriptive verbs
func Contains(s, substr string) bool
func HasPrefix(s, prefix string) bool
func TrimSpace(s string) string
func Split(s, sep string) []string
func Join(elems []string, sep string) string

// http package - HTTP verbs
func Get(url string) (resp *Response, err error)
func Post(url, contentType string, body io.Reader) (resp *Response, err error)
</good>
</example>

<example>
<category>function-naming-nouns</category>
<context>Functions returning values use noun-like names</context>

<good>
// os package - nouns for accessors
func Hostname() (name string, err error)
func Getwd() (dir string, err error)

// time package - nouns
func Now() Time
func Since(t Time) Duration

// path package - nouns
func Base(path string) string
func Dir(path string) string
func Ext(path string) string
</good>
</example>

<example>
<category>function-type-suffixes</category>
<context>Similar functions differentiated by type</context>

<good>
// strconv package - type suffix pattern
func ParseBool(str string) (bool, error)
func ParseInt(s string, base int, bitSize int) (i int64, err error)
func ParseUint(s string, base int, bitSize int) (uint64, error)
func ParseFloat(s string, bitSize int) (float64, error)

func FormatBool(b bool) string
func FormatInt(i int64, base int) string
func FormatUint(i uint64, base int) string
func FormatFloat(f float64, fmt byte, prec, bitSize int) string

func AppendBool(dst []byte, b bool) []byte
func AppendInt(dst []byte, i int64, base int) []byte
func AppendUint(dst []byte, i uint64, base int) []byte
func AppendFloat(dst []byte, f float64, fmt byte, prec, bitSize int) []byte
</good>
</example>

## Method Names

<example>
<category>method-naming-no-get</category>
<context>Accessors don't use Get prefix</context>

<good>
// time.Time accessors - no Get prefix
func (t Time) Year() int
func (t Time) Month() Month
func (t Time) Day() int
func (t Time) Hour() int
func (t Time) Minute() int
func (t Time) Second() int

// http.Request accessors
func (r *Request) Cookie(name string) (*Cookie, error)
func (r *Request) Cookies() []*Cookie
func (r *Request) UserAgent() string

// url.URL accessors
func (u *URL) Hostname() string
func (u *URL) Port() string
func (u *URL) Query() Values
</good>
</example>

<example>
<category>method-naming-actions</category>
<context>Methods performing actions use verbs</context>

<good>
// bytes.Buffer - action methods
func (b *Buffer) Write(p []byte) (n int, err error)
func (b *Buffer) Read(p []byte) (n int, err error)
func (b *Buffer) Reset()
func (b *Buffer) Grow(n int)

// http.Server - action methods
func (srv *Server) ListenAndServe() error
func (srv *Server) Shutdown(ctx context.Context) error
func (srv *Server) RegisterOnShutdown(f func())

// os.File - action methods
func (f *File) Read(b []byte) (n int, err error)
func (f *File) Write(b []byte) (n int, err error)
func (f *File) Close() error
func (f *File) Sync() error
</good>
</example>

<example>
<category>method-receiver-names</category>
<context>Consistent short receiver names</context>

<good>
// bytes.Buffer - always 'b'
func (b *Buffer) Len() int
func (b *Buffer) Cap() int
func (b *Buffer) Bytes() []byte
func (b *Buffer) String() string

// http.Request - always 'r'
func (r *Request) Context() context.Context
func (r *Request) Cookie(name string) (*Cookie, error)
func (r *Request) FormValue(key string) string

// http.Response - always 'r'
func (r *Response) Cookies() []*Cookie
func (r *Response) Location() (*url.URL, error)

// json.Encoder - always 'enc'
func (enc *Encoder) Encode(v any) error
func (enc *Encoder) SetIndent(prefix, indent string)
</good>
</example>

## Variable Names

<example>
<category>variable-scope-small</category>
<context>Short names in small scopes</context>

<good>
// Loop indices
for i := 0; i < len(items); i++ {
    process(items[i])
}

for i, v := range values {
    fmt.Printf("%d: %v\n", i, v)
}

// Small scope operations
func abs(i int) int {
    if i < 0 {
        i *= -1
    }
    return i
}

// Conventional single letters
func Copy(dst Writer, src Reader) (n int64, err error)
func (b *Buffer) Write(p []byte) (n int, err error)
</good>
</example>

<example>
<category>variable-well-known</category>
<context>Well-known abbreviations stay short in any scope</context>

<good>
// Conventional short forms
ctx := context.Background()
db := sql.Open("postgres", connString)
id := generateID()
buf := new(bytes.Buffer)
msg := "hello world"

// HTTP conventions
func ServeHTTP(w ResponseWriter, r *Request)

// IO conventions
func Copy(dst Writer, src Reader) (written int64, err error)
</good>
</example>

<example>
<category>variable-clear-from-context</category>
<context>Names clear from surrounding context</context>

<good>
// In http.Server.Serve
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
// rw: clearly a read-writer from Accept
// c: clearly a connection in this context
// srv: the server receiver

// In bytes.Buffer.WriteTo
func (b *Buffer) WriteTo(w io.Writer) (n int64, err error) {
    // b: the buffer (receiver)
    // w: the writer (conventional)
    // n: bytes written (conventional return name)
}
</good>
</example>

## Constants

<example>
<category>constant-naming</category>
<context>Constants use MixedCaps, named by role</context>

<good>
// http package - status codes
const (
    StatusOK                  = 200
    StatusCreated             = 201
    StatusNoContent           = 204
    StatusBadRequest          = 400
    StatusNotFound            = 404
    StatusInternalServerError = 500
)

// io package - seek operations
const (
    SeekStart   = 0
    SeekCurrent = 1
    SeekEnd     = 2
)

// time package - durations
const (
    Nanosecond  Duration = 1
    Microsecond          = 1000 * Nanosecond
    Millisecond          = 1000 * Microsecond
    Second               = 1000 * Millisecond
    Minute               = 60 * Second
    Hour                 = 60 * Minute
)

// os package - file modes
const (
    ModeDir        FileMode = 1 << (32 - 1 - iota)
    ModeAppend
    ModeExclusive
    ModeTemporary
)
</good>
</example>

## Initialisms

<example>
<category>initialism-handling</category>
<context>Initialisms keep consistent casing</context>

<good>
// Correct initialism handling
type URL struct{}           // Not Url
type URLParser struct{}     // Not UrlParser
type HTTPServer struct{}    // Not HttpServer
type APIKey struct{}        // Not ApiKey
type UserID int            // Not UserId
type DBConnection struct{} // Not DbConnection
type JSONEncoder struct{}  // Not JsonEncoder
type XMLParser struct{}    // Not XmlParser
type HTMLTemplate struct{} // Not HtmlTemplate

// Functions with initialisms
func ParseURL(s string) (*URL, error)        // Not ParseUrl
func NewHTTPClient() *HTTPClient             // Not NewHttpClient
func (c *Client) GetJSON(url string) error  // Not GetJson
</good>

<good>
// Unexported with initialisms
var url string              // Not URL or Url
var httpClient *Client      // Not HTTPClient or httpClient
var apiKey string           // Not APIKey or apikey
var userID int              // Not userID or userId
</good>
</example>

## Avoiding Repetition

<example>
<category>no-package-repetition</category>
<context>Package name provides context, no need to repeat</context>

<good>
// json package functions
func Marshal(v any) ([]byte, error)      // Not MarshalJSON
func Unmarshal(data []byte, v any) error // Not UnmarshalJSON

// json package types
type Encoder struct{}  // Not JSONEncoder
json.NewEncoder(w)     // Clear at call site

// http package
func Get(url string) (*Response, error)     // Not HTTPGet
http.Get(url)                                // Clear: http.Get

// errors package
func New(text string) error   // Not NewError
errors.New("failed")          // Clear: errors.New
</good>
</example>

<example>
<category>no-receiver-repetition</category>
<context>Receiver type visible, don't repeat in method name</context>

<good>
// bytes.Buffer methods
func (b *Buffer) WriteTo(w io.Writer) (n int64, err error)  // Not WriteBufferTo
func (b *Buffer) ReadFrom(r io.Reader) (n int64, err error) // Not ReadFromToBuffer

// http.Request methods
func (r *Request) Cookie(name string) (*Cookie, error)  // Not RequestCookie
func (r *Request) FormValue(key string) string          // Not GetRequestFormValue

// time.Time methods
func (t Time) Add(d Duration) Time        // Not AddToTime
func (t Time) Sub(u Time) Duration        // Not SubtractTime
</good>
</example>

## Complete Examples from Standard Library

<example>
<category>complete-package-io</category>
<context>The io package demonstrates excellent naming throughout</context>

<good>
package io

// Interfaces: single-method ending in -er
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

type Closer interface {
    Close() error
}

// Composed interfaces
type ReadWriter interface {
    Reader
    Writer
}

type ReadCloser interface {
    Reader
    Closer
}

// Functions: verb-based, no package repetition
func Copy(dst Writer, src Reader) (written int64, err error)
func ReadAll(r Reader) ([]byte, error)
func WriteString(w Writer, s string) (n int, err error)

// Constants: role-based names, MixedCaps
const (
    SeekStart   = 0
    SeekCurrent = 1
    SeekEnd     = 2
)
</good>
</example>

<example>
<category>complete-package-bytes</category>
<context>The bytes package shows consistent naming patterns</context>

<good>
package bytes

// Main type: simple name, package provides context
type Buffer struct {
    buf []byte
    off int
}

// Methods: actions are verbs, accessors are nouns, receiver always 'b'
func (b *Buffer) Len() int
func (b *Buffer) Cap() int
func (b *Buffer) Bytes() []byte
func (b *Buffer) String() string
func (b *Buffer) Write(p []byte) (n int, err error)
func (b *Buffer) Read(p []byte) (n int, err error)
func (b *Buffer) WriteTo(w io.Writer) (n int64, err error)
func (b *Buffer) ReadFrom(r io.Reader) (n int64, err error)
func (b *Buffer) Reset()
func (b *Buffer) Grow(n int)

// Package functions: clear verbs, no package repetition
func Contains(b, subslice []byte) bool
func Count(s, sep []byte) int
func Equal(a, b []byte) bool
func Index(s, sep []byte) int
func Join(s [][]byte, sep []byte) []byte
func Split(s, sep []byte) [][]byte
func Trim(s []byte, cutset string) []byte
</good>
</example>

<example>
<category>complete-package-http</category>
<context>The http package demonstrates complex naming well</context>

<good>
package http

// Types: no HTTP prefix (package provides context)
type Request struct{}
type Response struct{}
type Server struct{}
type Client struct{}
type Handler interface{}
type ResponseWriter interface{}

// Top-level functions: HTTP verbs
func Get(url string) (*Response, error)
func Post(url, contentType string, body io.Reader) (*Response, error)
func Head(url string) (*Response, error)

// Server type methods: clear actions, receiver always 'srv'
func (srv *Server) ListenAndServe() error
func (srv *Server) Shutdown(ctx context.Context) error
func (srv *Server) Serve(l net.Listener) error

// Request type methods: accessors no Get prefix, receiver always 'r'
func (r *Request) Cookie(name string) (*Cookie, error)
func (r *Request) Cookies() []*Cookie
func (r *Request) FormValue(key string) string
func (r *Request) UserAgent() string
func (r *Request) Context() context.Context

// Constants: status codes with clear roles
const (
    StatusOK                  = 200
    StatusNotFound            = 404
    StatusInternalServerError = 500
)
</good>
</example>
