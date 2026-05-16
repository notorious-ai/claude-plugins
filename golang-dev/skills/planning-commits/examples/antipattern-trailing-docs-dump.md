# Anti-pattern: trailing docs dump

The temptation arises near the end of a feature series. The agent has shipped the code, written tests, fixed regressions — and "still has to update the docs." The natural-feeling move is to bundle all the doc updates into a single trailing commit.

## The anti-pattern

A feature series that adds three new APIs ends as:

```
1. Land Encoder
2. Land Decoder
3. Land streaming variants
4. Update README, package doc, and examples
   Add the README sections describing Encoder, Decoder, and the
   streaming variants. Update the package doc to mention the new
   types. Add example_test.go entries for all three.
```

## Why this is wrong

Violates the incremental facet:

- For three consecutive commits the public API has existed in a state the documentation does not describe. Anyone running `go doc`, reading the README, or scanning examples sees a stale picture.
- A reader of `git blame` on the README's Encoder section lands on commit 4 — a commit whose primary subject is "docs update" — rather than on commit 1 where the encoder was introduced and the rationale for its shape lived.
- Commit 4 itself is hard to review. Three features-worth of documentation in one diff forces the reviewer to context-switch across all three features simultaneously, in a commit whose stated purpose offers no scaffolding for that context.

## Better

Docs travel with their feature. See `examples/docs-with-feature.md` for the positive shape — each feature commit also lands the documentation that describes it, and the README is built non-linearly as the narrative requires.

## Why this anti-pattern is sticky

The trailing docs dump is rationalised as "I'll write better docs once I see the whole feature working." This sounds disciplined but produces worse docs in two ways:

- The rationale for design choices is freshest at the moment the choice is made. Writing the docs three commits later loses that freshness — the writer has to reconstruct the reasoning and often defaults to describing what the code does rather than why.
- Docs reviewed in their own commit get less scrutiny than docs reviewed alongside the code they describe. The reviewer who saw "Encoder lands here" in commit 1 would have caught a misleading README sentence in that same commit; in commit 4, they skim.
