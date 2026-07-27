# Test helpers, fakes, and dependencies

Load when a test wants a helper, a fake, or a new dependency, or when
tabular cases grow construction logic.

## The earning spectrum

Test helpers are a good thing that must not be abused: a premature helper
saving three lines is a smell that hides bigger misunderstandings. In a
trivial package, only panic recovery earns one: panics take a table plus a
recover helper whose failure message names the inputs and their specific
invalidity from the case struct (exemplar/'s mustPanic is the shape). In
complex packages, case-construction side functions become legitimate: when
each tabular case's definition turns complex and multiline, side functions
that build cases, or single fields of a case, keep the table readable.
Before inventing a shape, find a proper exemplar in the standard library or
golang.org/x.

Helper types typically implement an interface the package consumes, with a
*testing.T field so they assert immediately where the failure is detected
instead of ferrying values back: an http.Handler that checks fields on the
http.Request it receives. *testing.T is concurrent-safe, so asserting
inside the helper is fine wherever it runs.

## Fakes and dependencies

For small dependencies, write a bespoke fake of a few lines: a fake read in
full keeps the test honest, and no mock framework does. No new third-party
test dependency (go-cmp included) enters unless the module already carries
it.

## The method-on-case line

An advanced pattern makes the assertions a method on the case type,
accepting *testing.T and calling the code under test. It is reserved for
packages that are much harder to test and require improvised helpers: in an
ordinary package, even when two functions share a signature, the failure
messages become awkward to wire, masking the actual test code executed and
clouding the test's clarity. Do not reach for it while plain straight-line
bodies suffice.

The line between improvised helpers in the test file and a proper internal
testing package is drawn when the test helpers require tests themselves; at
that point build the internal package rather than let an untested harness
judge the code.

## Placement

Helpers sit after their first usage, never as the opening function: a
convoluted helper opening the file kills the review, and even landing
between two tests is better. The file builds complexity as it reads:
examples first, then the most typical call patterns, the special cases and
their machinery last.
