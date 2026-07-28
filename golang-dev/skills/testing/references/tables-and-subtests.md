# Tables and sub-tests

Load when cases repeat, a table is forming, or a t.Run is about to appear.

## What a table is for

Tabular tests are for the exact same test code run over every case. The
smell that a table no longer fits: `if` conditions that specialize the test
code based on some field; that signals two separate tests. When two
functions mirror each other, merge their expectations into one case struct,
{s: "hello", n: 3, head: "hel", tail: "llo"}, and drive both from the same
table, either as two sub-tests or as one loop with two subsequent calls.

Name struct fields once a case carries more than two or three; unnamed
literals of that size fail golangci-lint's defaults, while one or two
fields in an anonymous struct earn leniency. Named case types are fine,
even declared inside the function, doc-commented when the type serves
several tests. No global test-case slices: a package-level table earns its
place only when several functions genuinely share it, as when one table
feeds a test, its benchmark, and a sibling codec's test.

When the values themselves say nothing, name them or unroll them. A row of
{0} beside {-1} tells a reader only that two numbers were tried, so either
pair each value with the word for what makes it invalid ({"zero", 0},
{"negative", -1}) or drop the table for two explicit calls.

## When a sub-test is worth it

Sub-tests are most appropriate when their names fit, feel, and read like
top-level test names, reinforced by the fact that they render as Go symbol
names with no spaces. Prose-like sub-test names are a smell that these
should be one long continuous test, or that the names need rephrasing; the
Field=Value syntax names them best: TestReflectionWorks/Kind=integers.
Inline trivial sub-tests into one linear test, and simplify cumbersome test
code even at the cost of repeated lines: more lines are preferred when all
of them are meaningful.

Sub-test names built from descriptions are not always worth it: naming the
inputs is often enough, never repeated into log names the runner prints
anyway, and the best names complete a logged sentence ("Load(%q) succeeded
for a config with %s"). Name a malformed input instead of dumping it,
because a multiline quoted string in a test log is hard for human eyes to
parse. Underscores mean nothing in test names except in examples. Failure
messages follow the Go wiki's TestComments; many cases of one behavior,
TableDrivenTests.
