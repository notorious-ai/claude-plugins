# Concurrency in tests

Load when a test spawns goroutines, expects panics, hunts races, or the
package under test is concurrent by nature. The skill's base doctrine
stands: synctest bubbles on virtual time, the least orchestration, and a
hang is a valid test failure. Bubble time is exact, so sleep the precise
moment (expire in a minute: sleep the minute) or the very next quantum
(`time.Minute + 1`); overshoot margins are a real-time defense, and inside
a bubble they only signal a hopeful approach to timing.

## Goroutines

Goroutines outside a synctest bubble take a sync.WaitGroup; without one the
test leaks them. Assert inside the goroutine rather than collecting errors
or values for the main goroutine to inspect: *testing.T is concurrent-safe,
and the collection ceremony wastes precious test code. When stressing
promised concurrent use, provision generously, 64 or 128 or 1024
goroutines, because 16 may never contend on some hardware.

## What concurrency coverage means

Never hunt races statistically, exercising the package in ways nobody would
and hoping the detector fires: a misuse that hard to simulate is equally
hard to hit, and four goroutines hammering Close in hope of a panic prove
nothing either way. Coverage in the nebulous sense spans the whole suite's
code, not test titles: a suite whose scenarios run inside synctest bubbles
is the concurrency testing.

Docs that omit concurrency do not negate it. The delete-unpromised-
concurrency rule targets tests that assert promises the docs never made;
an obviously concurrent package, one whose business is goroutines and
blocking, still gets exercised concurrently through the synctest scenarios
the suite already runs.

## Panics and invalid inputs

Panics are valid failure conditions of tests: they throw the harness out of
order and later tests do not progress, but that is a failure, and recovery
is usually futile unless the panic is expected (then use the recover-helper
table). When a bug-panic blocks the rest of the work, comment the
triggering case out to see the work through, and restore it at hand-off,
never dropping it silently.

Test invalid inputs the package technically accepts: a rate large enough to
floor the refill interval to zero is invalid even though the constructor
lets it through.
