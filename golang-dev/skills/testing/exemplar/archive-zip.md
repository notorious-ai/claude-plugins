# archive/zip — buying a whole interface contract with one verifier call

<sample id="verifier-shape" archetypes="contract-conformance,harness" source="testing/fstest/testfs.go">

The surface the next sample exercises.

```go
// TestFS tests a file system implementation.
// It walks the entire tree of files in fsys,
// opening and checking that each file behaves correctly.
// Symbolic links are not followed,
// but their Lstat values are checked
// if the file system implements [fs.ReadLinkFS].
// It also checks that the file system contains at least the expected files.
// As a special case, if no expected files are listed, fsys must be empty.
// Otherwise, fsys must contain at least the listed files; it can also contain others.
// The contents of fsys must not change concurrently with TestFS.
//
// If TestFS finds any misbehaviors, it returns either the first error or a
// list of errors. Use [errors.Is] or [errors.AsType] to inspect.
//
// Typical usage inside a test is:
//
//	if err := fstest.TestFS(myFS, "file/that/should/be/present"); err != nil {
//		t.Fatal(err)
//	}
func TestFS(fsys fs.FS, expected ...string) error {
```

<highlight archetype="contract-conformance">When you implement an interface,
call the owner's verifier before writing any bespoke test; when you own an
interface, ship a verifier in this shape for implementers.</highlight>
<highlight archetype="harness">The verifier shape matters: it takes no
`*testing.T`, returns joined errors, and the caller decides
severity.</highlight>

<note>A published verifier turns an interface's documented contract into one
callable check.</note>

</sample>

<sample id="conformance-call" archetypes="contract-conformance" source="archive/zip/reader_test.go">

```go
func TestFS(t *testing.T) {
	for _, test := range []struct {
		file string
		want []string
	}{
		{
			"testdata/unix.zip",
			[]string{"hello", "dir/bar", "readonly"},
		},
		{
			"testdata/subdir.zip",
			[]string{"a/b/c"},
		},
	} {
		t.Run(test.file, func(t *testing.T) {
			t.Parallel()
			z, err := OpenReader(test.file)
			if err != nil {
				t.Fatal(err)
			}
			defer z.Close()
			if err := fstest.TestFS(z, test.want...); err != nil {
				t.Error(err)
			}
		})
	}
}
```

<highlight archetype="contract-conformance">zip implements `fs.FS`, so one
`fstest.TestFS` call per archive buys the ENTIRE documented file-system
contract — every Open, ReadDir, Stat clause, checked over the whole
tree.</highlight>

<note>The bespoke tests that follow in the source file cover only what `TestFS`
cannot know: zip-specific contents and errors.</note>

</sample>
