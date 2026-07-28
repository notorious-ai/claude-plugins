# io — bespoke fakes, contract stated in prose above the assertion

Samples: one-behavior-fakes, regression-to-property

Both files are external tests (`package io_test` with `. "io"`).

<sample id="one-behavior-fakes" archetypes="stream" source="io/io_test.go">

```go
// Version of bytes.Buffer that checks whether WriteTo was called or not
type writeToChecker struct {
	bytes.Buffer
	writeToCalled bool
}

func (wt *writeToChecker) WriteTo(w Writer) (int64, error) {
	wt.writeToCalled = true
	return wt.Buffer.WriteTo(w)
}

// It's preferable to choose WriterTo over ReaderFrom, since a WriterTo can issue one large write,
// while the ReaderFrom must read until EOF, potentially allocating when running out of buffer.
// Make sure that we choose WriterTo when both are implemented.
func TestCopyPriority(t *testing.T) {
	rb := new(writeToChecker)
	wb := new(bytes.Buffer)
	rb.WriteString("hello, world.")
	Copy(wb, rb)
	if wb.String() != "hello, world." {
		t.Errorf("Copy did not work properly")
	} else if !rb.writeToCalled {
		t.Errorf("WriteTo was not prioritized over ReadFrom")
	}
}

type zeroErrReader struct {
	err error
}

func (r zeroErrReader) Read(p []byte) (int, error) {
	return copy(p, []byte{0}), r.err
}

type errWriter struct {
	err error
}

func (w errWriter) Write([]byte) (int, error) {
	return 0, w.err
}

// In case a Read results in an error with non-zero bytes read, and
// the subsequent Write also results in an error, the error from Write
// is returned, as it is the one that prevented progressing further.
func TestCopyReadErrWriteErr(t *testing.T) {
	er, ew := errors.New("readError"), errors.New("writeError")
	r, w := zeroErrReader{err: er}, errWriter{err: ew}
	n, err := Copy(w, r)
	if n != 0 || err != ew {
		t.Errorf("Copy(zeroErrReader, errWriter) = %d, %v; want 0, writeError", n, err)
	}
}
```

<highlight archetype="stream">Three fakes, each 3-8 lines, each misbehaving in
exactly one documented way: `writeToChecker` records dispatch, `zeroErrReader`
reads one byte and errs, `errWriter` only errs. No mock framework earns its
import against this. And read where the contract lives: the
WriterTo-over-ReaderFrom priority and the write-error-beats-read-error rule are
stated in prose immediately above the test that holds them, WITH the rationale
("a WriterTo can issue one large write").</highlight>

<note>When an assertion is non-obvious, restate the contract clause right
there.</note>

</sample>

<sample id="regression-to-property" archetypes="stream" source="io/multi_test.go">

```go
// byteAndEOFReader is a Reader which reads one byte (the underlying
// byte) and EOF at once in its Read call.
type byteAndEOFReader byte

func (b byteAndEOFReader) Read(p []byte) (n int, err error) {
	if len(p) == 0 {
		// Read(0 bytes) is useless. We expect no such useless
		// calls in this test.
		panic("unexpected call")
	}
	p[0] = byte(b)
	return 1, EOF
}

// This used to yield bytes forever; issue 16795.
func TestMultiReaderSingleByteWithEOF(t *testing.T) {
	got, err := ReadAll(LimitReader(MultiReader(byteAndEOFReader('a'), byteAndEOFReader('b')), 10))
	if err != nil {
		t.Fatal(err)
	}
	const want = "ab"
	if string(got) != want {
		t.Errorf("got %q; want %q", got, want)
	}
}

// Test that a reader returning (n, EOF) at the end of a MultiReader
// chain continues to return EOF on its final read, rather than
// yielding a (0, EOF).
func TestMultiReaderFinalEOF(t *testing.T) {
	r := MultiReader(bytes.NewReader(nil), byteAndEOFReader('a'))
	buf := make([]byte, 2)
	n, err := r.Read(buf)
	if n != 1 || err != EOF {
		t.Errorf("got %v, %v; want 1, EOF", n, err)
	}
}
```

<highlight archetype="stream">`byteAndEOFReader` is a complete Reader fake in
one type declaration; the panic inside documents an assumption instead of
silently tolerating it. `TestMultiReaderFinalEOF` pins the subtle
`(n, EOF)`-not-`(0, EOF)` clause in prose first, then four lines of
code.</highlight>

<note>`TestMultiReaderSingleByteWithEOF` is a regression promoted to a
property: the name states what holds, and "This used to yield bytes forever;
issue 16795." demotes the bug reference to a comment.</note>

</sample>
