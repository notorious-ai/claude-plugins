# Evaluator calibration cases

For REVIEW and EVALUATION agents only; writers never load this file. Each
rule states a ruling in one line (maintainer quotes are verbatim), a `<good>`
shape a grader must NOT flag, and a `<bad>` near-neighbor it MUST flag, with
why graders have missed the line before. `file#id` names a `<sample id>` in
`exemplar/`; invariants match: tags at column 0, `id` first.

<rule id="self-naming-comment">
"They literally echo the function's name and begins with the test's name - no value added - wasted my time." (maintainer) — no test or example doc comment ever opens with its own function's name.
<good>encoding-json#example-user-voice — the doc comment opens with the scenario ("This example uses a Decoder..."), never with the function's name.</good>
<bad>
// TestReplayPreservesOrder verifies that entries come back in the
// order they were appended, even across a drain and reload.
func TestReplayPreservesOrder(t *testing.T) {
Miss: the comment's content is genuinely useful, so a critic quotes it approvingly as rationale and reads past the opening word; the defect is the first word, not the story. Even the stdlib slips: encoding-json#example-self-naming-violation.
</bad>
</rule>

<rule id="rationale-only-nontrivial">
"Only for the non-trivial tests." (maintainer, striking a grader's every-function doc-comment checkbox) — rationale doc comments are owed by non-trivial tests; a trivial test's silence is correct.
<good>hash-maphash#property-claim-names — two canon tests, zero doc comments; the claiming names carry it all.</good>
<bad>
// TestParseEmpty checks that Parse handles the empty string.
func TestParseEmpty(t *testing.T) {
	if _, err := Parse(""); err == nil {
Miss: a comment on every test reads as diligence, so graders score absence as the defect; flag the vacuous padding, never the silence.
</bad>
</rule>

<rule id="package-scenario-name">
"Go supports package tests, not all of them must be tied to a symbol." (maintainer) — a test named for the whole package, walking the anticipated user flow, is the welcomed scenario shape, not a naming defect.
<good>
// One sitting as the anticipated user: enroll, look up, revoke.
func TestRoster(t *testing.T) {
	r := roster.New()
</good>
<bad>
func TestRosterEnroll(t *testing.T) {
func TestRosterLookup(t *testing.T) {
func TestRosterRevoke(t *testing.T) {
Miss: the package-named scenario and the receiver-stutter scan look alike; one claims the whole flow, the others staple the type to one method each — a grader has failed the good shape as "a bare type name claiming no property".
</bad>
</rule>

<rule id="panic-table-recover">
"tested panics the best with a **table-driven test** and a **helper** to recover from panics" (maintainer) — the panic table plus recover helper is a sanctioned shape; "bodies are straight-line" does not ban it.
<good>
for _, tt := range []struct {
	n       int
	invalid string
}{{0, "zero depth"}, {-1, "negative depth"}} {
	mustPanic(t, tt.invalid, func() { New(tt.n) })
}
</good>
<bad>
t.Run(fmt.Sprintf("New(%d)", tt.n), func(t *testing.T) {
	defer func() { recover() }()
	New(tt.n)
Miss: graders reading "straight-line hard-coded bodies" have banned every table; the ban aims at algorithmic bodies and t.Run ceremony repeating inputs in names, not at a table whose failure messages name the input and its invalidity.
</bad>
</rule>

<rule id="bubble-sleep">
"The sleep inside `testing/synctest` is exactly as expected and accurate" (maintainer) — inside a bubble time is virtual, so sleeping is idiomatic, instant, and stable.
<good>database-sql#bubble-sleep-expiry — `synctest.Sleep(11 * time.Second)` crosses a 10-second threshold instantly inside the bubble.</good>
<bad>
go func() { done <- worker.Run() }()
time.Sleep(50 * time.Millisecond) // let the goroutine get going
<-done
Miss: a flat no-sleeps reflex flags both shapes; only the out-of-bubble sleep is synchronization-by-hope — a grader failed a whole suite for sleeps that sat correctly inside bubbles.
</bad>
</rule>

<rule id="bubble-exact-timing">
"inside synctest bubbles, overshooting is a noob move... a hopeful approach to timing" (maintainer) — bubble time is virtual and exact, so sleep the precise moment (expire in a minute: sleep the minute) or the very next quantum (`time.Minute + 1`); wide margins are for real time only.
<good>
// Entries live one minute; this is the first instant after expiry.
time.Sleep(time.Minute + 1)
if _, ok := c.Get("badge"); ok {
</good>
<bad>
time.Sleep(2 * time.Minute) // generous margin so expiry has surely run
if _, ok := c.Get("badge"); ok {
Miss: real-time reflexes credit the margin as flake-proofing (and example-real-sleep rightly blesses it OUTSIDE bubbles), so graders praise as prudence what inside a bubble buys nothing and misstates when the behavior occurs.
</bad>
</rule>

<rule id="example-real-sleep">
Example functions cannot enter synctest bubbles, so a real sleep in an example is correct when it errs only in the safe direction: overshooting a deadline fixed in the past cannot flake. Judge direction, not presence.
<good>
// The entry expires 1ms after Put; sleeping 10ms only overshoots,
// so the miss below cannot flake.
time.Sleep(10 * time.Millisecond)
</good>
<bad>
time.Sleep(5 * time.Millisecond) // hope the sweep has not run yet
if _, ok := store.Get("badge"); !ok {
Miss: "any sleep sits inside a bubble" applied to the letter fails correct examples — a grader failed an otherwise-clean run on exactly this; the flag belongs on window-timing sleeps that must land before or between events, which flake both ways.
</bad>
</rule>

<rule id="goroutine-leak">
A bubble waits for every goroutine inside it to exit, so a Close that only SIGNALS its janitor is not a leak finding in a bubbled suite; a goroutine nobody signals fails the test with "panic: deadlock: main bubble goroutine has exited but blocked goroutines remain". Bubble exit is the leak detector, and outside a bubble the detector is a sync.WaitGroup.
<good>
// Close signals the janitor; the bubble waits for it to exit.
close(c.quit)
</good>
<bad>
go func() { c.drain() }() // no bubble, so nothing reaps this
if got := c.Len(); got != 0 {
Miss: the ceremony reads as rigour, so graders have demanded a janitorDone.Wait() from a suite whose bubbles already wait, then passed an unreaped goroutine out here because the run happened to come back green — in a bubble the wait is free, and only outside one does a WaitGroup earn its lines.
</bad>
</rule>

<rule id="example-audience">
"it **narrates** the Go code - which I DESPISE!" (maintainer) — example comments, doc and in-function, render on pkgsite: they speak to users about the attributed symbol and scenario, never narrate code, never address maintainers.
<good>encoding-json#example-user-voice — scenario-voiced doc comment; the in-function idiom (decode until io.EOF) is what a user must learn.</good>
<bad>
// ExampleParse creates a parser, feeds it two records, and
// prints each one. Keep this in sync with the reader tests.
func ExampleParse() {
Miss: the comment is accurate and tidy, so it reads as good documentation; the test is audience, not accuracy — narration and maintainer chatter pass any truthfulness check.
</bad>
</rule>

<rule id="prose-subtests">
"When using sub-tests with more prose-like names, its a smell that these should be one long continuous test" (maintainer) — sub-test names must read like top-level Go test names.
<good>database-sql#bubble-sleep-expiry — sub-test names render the case as `expired=%t,badReset=%t`: Field=Value, no prose.</good>
<bad>
t.Run("returns an error when the stream ends early", func(t *testing.T) {
t.Run("keeps reading after a blank record", func(t *testing.T) {
t.Run("stops at the first bad byte", func(t *testing.T) {
Miss: descriptive prose names look reader-friendly, so graders credit them as clarity; the tell is a name that could never be a Go identifier — those bodies belong inlined into one continuous test.
</bad>
</rule>

<rule id="authoring-time-values">
"that math is performed at coding time and written as results" (maintainer) — bodies hard-code expectations, with an adjacent comment when the arithmetic is delicate.
<good>strings#case-table — every row writes the answer down ({"oofofoofooo", "foo", 4}); nothing is computed at run time.</good>
<bad>
want := workers * perWorker
for range workers * perWorker {
	got += <-results
Miss: derived expectations look DRY and rigorous, but they re-run the arithmetic the code under test performs and inherit its bugs; graders praise the mirroring as thoroughness.
</bad>
</rule>

<rule id="owner-only">
A reviewer or reviser of tests never edits exported source or prose — those are owner-only, whatever any exemplar or fixture shape suggests; drift goes to the report, not the code.
<good>
report.md: the doc promises a nil return on empty input; the code
panics. The suite sides with the prose and stays red; the one-line
guard is named here. Every non-test file left byte-identical.
</good>
<bad>
-// New panics if depth is not positive.
+// New panics if depth is not between 1 and 1e9, or if width is
+// negative.
Miss: the edit completes the very fix the critique demanded and can even match an exemplar's shape — a looped run rewrote owner prose citing one; ownership, not correctness, is the test, so diff every non-test file against its input.
</bad>
</rule>
