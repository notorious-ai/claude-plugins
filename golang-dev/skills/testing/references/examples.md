# Runnable examples

Load when an Example function is written, reviewed, or judged. The base
doctrine stands: a representative runnable example of the anticipated call
pattern is mandatory per package, and example comments speak to users about
the attributed symbol and scenario, never narrating code. This file carries
the rest, because the example archetype matches EVERY package and its
harness is unlike the test harness: the only assertion is the printed
output.

## Every character serves users

Doc comment, code, in-function comments, and the Output block all render on
pkgsite, so an example is user documentation first and a test second: every
character earns its place by teaching an importer something. Speak about
USAGE of the package, never about its exported symbols: even a
single-symbol demo leads into how an importer uses the package, because
users arrive to compose the API, not to browse a symbol index.

## The Output must demonstrate the claim

An example announces its intent through its doc comment, its name, and its
inline comments. Whoever judges it validates that the expected Output
actually demonstrates that intent, because an example whose comment
promises expiry while its Output shows only insertion publishes a lie on
pkgsite. (A round-4 catch the maintainer praised: "the example's comment
promises what its code never shows.")

## All failures must reach the output

The harness has one sense, the printed output compared exactly against the
expected block, so every possible failure must manifest as output other
than exactly the expected text: an example that can fail while still
printing the expected output is worthless to the harness. Route error paths
to visible prints, and never let a swallowed error leave the happy-path
text intact.

## Unordered output is a narrow fit

`// Unordered output:` fits very specific cases only, and it is not a
concurrency magic bullet: it relaxes line ORDER and nothing else, so it
fits an API whose documented contract fully determines the SET of printed
values while leaving their order unspecified. The standard tree uses it in
three packages in total.

<sample id="unordered-output-contract" archetypes="example" source="index/suffixarray/example_test.go" lines="12-22">

Source: `index/suffixarray/example_test.go` lines 12-22 (Go development
tree, 1.27 dev, 2026-06). Verbatim.

```go
func ExampleIndex_Lookup() {
	index := suffixarray.New([]byte("banana"))
	offsets := index.Lookup([]byte("ana"), -1)
	for _, off := range offsets {
		fmt.Println(off)
	}

	// Unordered output:
	// 1
	// 3
}
```

<highlight archetype="example">Lookup's doc promises "an unsorted list" of
every occurrence, so the contract itself fully determines the value set
("ana" sits at 1 and 3 in "banana") and leaves only the order open. That is
the whole fit: deterministic values, unspecified order. math/rand/v2's
ExamplePerm (`example_test.go` lines 99-107) is the same shape: Perm(3)
must print exactly 0, 1, and 2, in a random order.</highlight>

<note>Neither specimen involves a goroutine. Concurrent failure modes,
deadlock, lost work, partial output, do not become expected-output
mismatches just because line order is forgiven, so unordered output buys a
concurrent example nothing but false confidence.</note>

</sample>

## Real time, in the safe direction

Examples cannot enter synctest bubbles, so their sleeps are real. A sleep
is valid when it errs only in the safe direction: overshooting a deadline
fixed in the past cannot flake, and the generous margin that is a noob move
inside a bubble is exactly right out here, where the scheduler owns the
clock. Never use a sleep as a synchronization primitive between goroutines,
because window timing flakes in both directions; a concurrent-heavy pattern
belongs in a test with a bubble, not in an example. The whole example
completes within about a second, because it runs in every `go test` of the
package and pkgsite readers take it as typical usage, not a stress rig.

## Panics may be examples

A trivial panic demonstration can be a runnable example: recover in a
deferred function, print the recovered value, and the Output block shows a
user exactly what the misuse costs. The downside is real, because that
Output block pins the panic text into the contract; the trade works for
some libraries and not others, so where the message is not a promise, keep
panics in the test-side panic table instead.
