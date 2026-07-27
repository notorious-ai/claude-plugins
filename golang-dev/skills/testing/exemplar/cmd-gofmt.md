# cmd/gofmt — golden beside fixture, -update, idempotence

Samples: update-flag-diff, corpus-glob-idempotence, flag-in-fixture

Source: `cmd/gofmt/gofmt_test.go` and `cmd/gofmt/testdata/rewrite1.input` (Go
development tree, 1.27 dev, 2026-06). Verbatim.
Note: `package main`, in-process — the gofmt binary is never executed.

<sample id="update-flag-diff" archetypes="golden-fixture" source="cmd/gofmt/gofmt_test.go">

Source: `cmd/gofmt/gofmt_test.go` (Go 1.27 dev). Verbatim.
The tail of `runTest(t, in, out string)`; flag parsing and
processing elided.

```go
	expected, err := os.ReadFile(out)
	if err != nil {
		t.Error(err)
		return
	}

	if got := buf.Bytes(); !bytes.Equal(got, expected) {
		if *update {
			if in != out {
				if err := os.WriteFile(out, got, 0666); err != nil {
					t.Error(err)
				}
				return
			}
			// in == out: don't accidentally destroy input
			t.Errorf("WARNING: -update did not rewrite input file %s", in)
		}

		t.Errorf("(gofmt %s) != %s (see %s.gofmt)\n%s", in, out, in,
			diff.Diff("expected", expected, "got", got))
		if err := os.WriteFile(in+".gofmt", got, 0666); err != nil {
			t.Error(err)
		}
	}
}
```

<highlight archetype="golden-fixture">The golden discipline in one screen:
`-update` rewrites the golden (but refuses to destroy an input), failures print
a unified diff — never `%q` dumps — and the got-bytes land beside the fixture
as `.gofmt` debris for inspection.</highlight>

<note>Changing the formatter MUST edit a golden; that friction is the
feature.</note>

</sample>

<sample id="corpus-glob-idempotence" archetypes="golden-fixture,harness" source="cmd/gofmt/gofmt_test.go">

Source: `cmd/gofmt/gofmt_test.go` (Go 1.27 dev). Verbatim.

```go
// TestRewrite processes testdata/*.input files and compares them to the
// corresponding testdata/*.golden files. The gofmt flags used to process
// a file must be provided via a comment of the form
//
//	//gofmt flags
//
// in the processed file within the first 20 lines, if any.
func TestRewrite(t *testing.T) {
	// determine input files
	match, err := filepath.Glob("testdata/*.input")
	if err != nil {
		t.Fatal(err)
	}

	// add larger examples
	match = append(match, "gofmt.go", "gofmt_test.go")

	for _, in := range match {
		name := filepath.Base(in)
		t.Run(name, func(t *testing.T) {
			out := in // for files where input and output are identical
			if strings.HasSuffix(in, ".input") {
				out = in[:len(in)-len(".input")] + ".golden"
			}
			runTest(t, in, out)
			if in != out && !t.Failed() {
				// Check idempotence.
				runTest(t, out, out)
			}
		})
	}
}
```

<highlight archetype="golden-fixture">Expectations live beside fixtures: each
`testdata/*.input` pairs with a `*.golden` sibling, per-fixture flags ride
INSIDE the fixture as a `//gofmt` comment, and the package's own sources join
the corpus as large examples.</highlight>
<highlight archetype="harness">The cheapest strong property a formatter can pin
closes the loop: re-run the formatter on its own golden and demand a fixed
point (`runTest(t, out, out)`).</highlight>

<note>Glob the corpus, name each sub-test by its fixture, and let one runner
carry every case.</note>

</sample>

<sample id="flag-in-fixture" archetypes="golden-fixture" source="cmd/gofmt/testdata/rewrite1.input">

Source: `cmd/gofmt/testdata/rewrite1.input` (copyright header elided;
Go 1.27 dev). Verbatim.
The paired rewrite1.golden is identical with `Foo` rewritten to
`Bar`.

```go
//gofmt -r=Foo->Bar

// (standard Go copyright header elided)

package main

type Foo int
```

<highlight archetype="golden-fixture">One case is one reviewable pair of files;
the flag that produced the golden sits at the top of the input.</highlight>

<note>Nothing about the case lives at helper-call distance in Go code.</note>

</sample>
