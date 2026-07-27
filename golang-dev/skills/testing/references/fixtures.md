# Fixtures and testdata

Load when a test needs file input, long literal data, or malformed cases.

## One reviewable fixture

When a user-facing package does file I/O, keep input and expected output in
one reviewable fixture, preferring testdata/ files over long string
constants; cmd/go's script corpus and x/tools' analysistest keep txtar
fixtures beside their assertions. A fixture must actually exercise the
format it claims to cover: a sample with uniform spacing and no empty lines
proves less than it appears to.

Reuse existing fixture fields over inventing purpose-built ones: to test a
mis-typed value, read an existing name field as an int or a port as a
duration rather than adding a bad_value field. Reuse is more elegant, and
the Go team does it well.

## The fixture file speaks

Fixture comments carry real information for both audiences, users and
maintainers: "Comments are the rest of the line following the # sign",
never "This is a comment". No warning tone; trust the common sense of
contributors. A comment spent on a field nobody cares about is a wasted
comment: when a field is in the fixture for a reason pertaining to the
test, say that reason there.

Malformed-case files want minimal scaffolding and elegant dogfooding: a
separated format whose first line states why the case should fail, printed
when it unexpectedly passes.
