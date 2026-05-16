# Anti-pattern: grouping by symbol kind

The temptation arises when a feature introduces many declarations of similar shape. An agent — especially an LLM working from a high-level brief — looks at the diff, sees "types here, methods there, functions over yonder" and proposes a "tidy" split along those lines.

## The anti-pattern

A feature that adds a streaming JSON parser to an existing `json` package gets split as:

```
1. Add the new Decoder, TokenReader, and Stream types
   Land all three new type declarations together because they are
   "the types this feature introduces."

2. Add the methods on Decoder, TokenReader, and Stream
   Land Decoder.Decode, TokenReader.Next, Stream.Reset, and so on,
   all together because they are "the methods this feature
   introduces."

3. Add the package-level constructors and helpers
   Land NewDecoder, NewTokenReader, parseValue, and any private
   helpers because they are "the functions this feature
   introduces."
```

## Why this is wrong

Violates the atomic facet. None of these commits stands alone as a unit of value:

- Commit 1 lands three types nobody can call into; a reviewer cannot evaluate whether the shape is right because there is no behaviour to read.
- Commit 2 lands a wall of methods whose intent is impossible to assess without flipping back to commit 1 for the type they hang off and forward to commit 3 for the constructor that creates them.
- Commit 3 lands constructors and helpers whose purpose is buried in the previous two commits.

The split is **syntactic** — by category in the language's grammar. The value it delivers, a working streaming parser, is fractured across three commits, none of which is independently revertable, reviewable, or rebaseable.

## Better

Split by value, not by symbol kind:

```
1. Land Decoder with its construction, Decode method, and tests
   Decoder is the smallest standalone value: parse a JSON document
   from an io.Reader and return a Go value. Type declaration,
   methods, constructor, and table-driven tests for this slice all
   land together.

2. Land TokenReader with its Next/Read methods and tests
   TokenReader adds the streaming-token surface. Same shape as
   commit 1, but the value is the lower-level token API. Type,
   methods, constructor, and tests for this slice land together.

3. Land Stream with its reset semantics and concurrent-use tests
   Stream is the long-lived reusable variant. Its value is
   allocation reuse across multiple parses. Type, methods, and the
   tests that exercise reset land together.
```

Each commit lands a coherent slice of value. A reviewer evaluating commit 2 sees the entire TokenReader story — type, methods, constructor, tests — in one place.
