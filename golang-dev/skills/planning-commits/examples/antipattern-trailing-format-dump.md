# Anti-pattern: trailing format or tidy dump

The temptation arises at the end of a feature series. The agent has shipped the code, made it work, and is "about to clean up". The natural-feeling move is to run `gofmt`, `go mod tidy`, the lint auto-fixer, and any code generator once at the end, bundling the result into a single trailing tidy commit.

## The anti-pattern

A feature series ends as:

```
1. Add the new Encoder type
2. Add the streaming Decoder
3. Wire both into the public API
4. Run go mod tidy, gofmt, and lint auto-fixes
   Apply the formatter to all files touched in the series, then
   `go mod tidy` to remove any unused entries, then `golangci-lint
   run --fix`. The diff spans files from commits 1, 2, and 3.
```

## Why this is wrong

Violates the atomic facet on two axes:

- **CI is broken between intermediate commits.** For three consecutive commits, the source tree fails `gofmt -l .` and `go mod tidy && git diff --exit-code`. Any CI step or bisect run against commits 1, 2, or 3 sees failures that have nothing to do with that commit's actual change.
- **The trailing commit is a dumping ground.** Commit 4's diff mixes mechanical edits across files from three different feature commits. Bisecting a regression that landed in commit 2 has to read through commit 4's noise to see the change in its original context. Worse, the "tidy" commit accretes whatever auto-fixes the tooling can find, so it ends up doing several unrelated cleanups under one label.

## Better

Every commit cleans up after itself:

- Commit 1's diff is `gofmt`-clean; if it added a module, `go mod tidy` was run before staging.
- Commit 2's diff is `gofmt`-clean; same hygiene contract.
- Commit 3's diff is `gofmt`-clean.

No trailing commit is needed because no debt was accumulated.

If the working tree starts contaminated — drift from an earlier branch, leftover entries from a reverted spike — see `examples/go-mod-tidy-first.md` for the right shape: a single cleanup commit at the head of the series, with no feature work mixed in. After that one-time cleanup, every subsequent commit holds the line.

## Why this anti-pattern is sticky

The trailing tidy is rationalised as "I will format once at the end so I do not waste effort formatting code I might still rewrite." The cost-benefit changes once the work is reviewed:

- Reviewers running CI locally against any intermediate commit see breakage.
- Bisects across the series cross a noisy commit that did not exist when the changes were originally made.
- The trailing commit's body cannot give a coherent rationale, because the diff has nothing in common across its files except that "tooling said so."

Format and tidy as you go. The cost per commit is trivial; the cost of the trailing dump compounds.
