# database/sql — synctest bubbles: matrix runner, wait-before-read, bubble sleeps

<sample id="matrix-runner" archetypes="harness,lifecycle" source="database/sql/sql_test.go">

Body elided; it runs each driver variant under `t.Run` +
`synctest.Test`, with `t.Cleanup` closing the DB inside the bubble.

```go
type requireFeature string

// testDatabase executes f in a synctest bubble.
//
// It executes several subtests, each with a database driver supporting
// a different set of optional interfaces (QueryerContext, etc.).
//
// Limit a test to drivers implementing a certain feature by passing
// a requireFeature option. For example:
//
//	// testFunc only executes with drivers which implement Validator.
//	testDatabase(t, testFunc, requireFeature("Validator"))
func testDatabase(t *testing.T, f func(t *testing.T, db *DB), opts ...any) {
```

<highlight archetype="harness">One matrix runner keeps one test body across
driver variants; options arrive as `...any` resolved by a type switch, and
`requireFeature` filters variants instead of skipping inside
bodies.</highlight>
<highlight archetype="lifecycle">Every test opens its bubble through this one
composition point, and `t.Cleanup` closes the DB inside the
bubble.</highlight>

<note>Suite-wide synctest use IS the concurrency testing.</note>

</sample>

<sample id="wait-before-read" archetypes="lifecycle,async-assert" source="database/sql/sql_test.go">

```go
func (db *DB) numFreeConns() int {
	synctest.Wait()
	db.mu.Lock()
	defer db.mu.Unlock()
	return len(db.freeConn)
}
```

<highlight archetype="lifecycle">`synctest.Wait()` runs before the read, so the
bubble's goroutines settle first; the accessor never races the
pool.</highlight>
<highlight archetype="async-assert">Async-state assertions become deterministic
one-liners; no poll loops, no sleeps.</highlight>

<note>The wait-before-read accessor: wait, then an ordinary locked read.</note>

</sample>

<sample id="bubble-sleep-expiry" archetypes="lifecycle,async-assert" source="database/sql/sql_test.go">

```go
func synctestSubtest(t *testing.T, name string, f func(t *testing.T)) {
	t.Run(name, func(t *testing.T) {
		synctest.Test(t, f)
	})
}

// Issue32530 encounters an issue where a connection may
// expire right after it comes out of a used connection pool
// even when a new connection is requested.
func TestConnExpiresFreshOutOfPool(t *testing.T) {
	execCases := []struct {
		expired  bool
		badReset bool
	}{
		{false, false},
		{true, false},
		{false, true},
	}

	for _, ec := range execCases {
		name := fmt.Sprintf("expired=%t,badReset=%t", ec.expired, ec.badReset)
		synctestSubtest(t, name, func(t *testing.T) {
			ctx := t.Context()

			db := newTestDB(t, "magicquery")

			db.SetMaxOpenConns(1)

			db.clearAllConns(t)

			db.SetMaxIdleConns(1)
			db.SetConnMaxLifetime(10 * time.Second)

			conn, err := db.conn(ctx, alwaysNewConn)
			if err != nil {
				t.Fatal(err)
			}

			afterPutConn := make(chan struct{})

			go func() {
				defer close(afterPutConn)

				conn, err := db.conn(ctx, alwaysNewConn)
				if err == nil {
					db.putConn(conn, err, false)
				} else {
					t.Errorf("db.conn: %v", err)
				}
			}()
			synctest.Wait()

			if t.Failed() {
				return
			}

			synctest.Sleep(11 * time.Second)

			getFakeConn(conn.ci).stickyBad = ec.badReset

			db.putConn(conn, err, true)

			<-afterPutConn
		})
	}
}
```

<highlight archetype="lifecycle">The body takes `t.Context()`, and the
goroutine asserts with `t.Errorf` itself (*testing.T is
concurrency-safe).</highlight>
<highlight archetype="async-assert">`synctest.Sleep(11 * time.Second)` crosses
the 10-second lifetime threshold instantly, without real time
passing.</highlight>

<note>Every move is canonical: the name states the property, `Issue32530`
demotes to the comment; sub-test names render the case as `Field=Value`.</note>

</sample>
