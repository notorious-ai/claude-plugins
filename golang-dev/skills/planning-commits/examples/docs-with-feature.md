# Docs ship with the feature they describe

Documentation belongs in the commit that introduces the feature it describes — not in a trailing "documentation" commit at the end of the series. The same rule applies to package overviews, README sections, code comments, and any user-facing guide.

## Plan entry

A library that grows three new public APIs across a series might plan as:

```
1. Expose Encoder with the encoding overview
   Land the Encoder type, its methods, and the package doc section
   that frames "what this package does and when to reach for it".
   The README's introductory paragraph also lands now, because it
   describes the encoder as the entry point.

2. Expose Decoder with its reciprocity guarantees
   Add the Decoder type alongside the README section describing how
   it pairs with Encoder, including the round-trip guarantee. The
   doc text exists because the guarantee exists; both arrive in this
   commit.

3. Add streaming support with the performance section
   Land the streaming variants of both Encoder and Decoder, plus the
   README's "performance characteristics" section that documents the
   memory profile of the streaming path versus the buffered path.
   This is the first commit where comparative performance is a real
   distinction in the API.
```

## What this demonstrates

The incremental facet. Each commit's documentation describes only what exists on the branch as of that commit, never forward-references unwritten features, and grows the user-facing narrative one capability at a time. A reader of `git blame` on the README's streaming section finds the commit where streaming was introduced — not a separate docs commit two weeks later.

## Non-linear is fine

The README is built in logical narrative order, not top-to-bottom file order. Commit 1 might land the introduction and the encoder section. Commit 2 might insert a "round-trip" section between them. Commit 3 might append the streaming section while also revising the introduction to mention performance trade-offs. The README's final paragraph order need not match the order of the commits that produced it.

What stays invariant: every commit's README state describes a working product whose features all exist as of that commit. Never write a sentence that depends on a future commit to be true.
