# hash/maphash — property-claim names, scenario grain

Samples: property-claim-names, one-invariant-many-paths

Surface exercised:

```go
func MakeSeed() Seed
func Bytes(seed Seed, b []byte) uint64
func String(seed Seed, s string) uint64
type Hash struct{ ... }
    func (h *Hash) Seed() Seed
    func (h *Hash) SetSeed(seed Seed)
    func (h *Hash) Sum64() uint64
```

<sample id="property-claim-names" archetypes="transform" source="hash/maphash/maphash_test.go">

```go
func TestUnseededHash(t *testing.T) {
	m := map[uint64]struct{}{}
	for i := 0; i < 1000; i++ {
		h := new(Hash)
		m[h.Sum64()] = struct{}{}
	}
	if len(m) < 900 {
		t.Errorf("empty hash not sufficiently random: got %d, want 1000", len(m))
	}
}

func TestSeededHash(t *testing.T) {
	s := MakeSeed()
	m := map[uint64]struct{}{}
	for i := 0; i < 1000; i++ {
		h := new(Hash)
		h.SetSeed(s)
		m[h.Sum64()] = struct{}{}
	}
	if len(m) != 1 {
		t.Errorf("seeded hash is random: got %d, want 1", len(m))
	}
}
```

<highlight archetype="transform">Each name is a claim about the package, not a
pointer to a symbol: contrasting properties (fresh instances differ; a shared
seed collapses them to one sum).</highlight>

<note>If you cannot state what breaks when the test fails, the test is
misnamed.</note>

</sample>

<sample id="one-invariant-many-paths" archetypes="stream,transform" source="hash/maphash/maphash_test.go">

```go
func TestHashGrouping(t *testing.T) {
	b := bytes.Repeat([]byte("foo"), 100)
	hh := make([]*Hash, 7)
	for i := range hh {
		hh[i] = new(Hash)
	}
	for _, h := range hh[1:] {
		h.SetSeed(hh[0].Seed())
	}
	hh[0].Write(b)
	hh[1].WriteString(string(b))

	writeByte := func(h *Hash, b byte) {
		err := h.WriteByte(b)
		if err != nil {
			t.Fatalf("WriteByte: %v", err)
		}
	}
	writeSingleByte := func(h *Hash, b byte) {
		_, err := h.Write([]byte{b})
		if err != nil {
			t.Fatalf("Write single byte: %v", err)
		}
	}
	writeStringSingleByte := func(h *Hash, b byte) {
		_, err := h.WriteString(string([]byte{b}))
		if err != nil {
			t.Fatalf("WriteString single byte: %v", err)
		}
	}

	for i, x := range b {
		writeByte(hh[2], x)
		writeSingleByte(hh[3], x)
		if i == 0 {
			writeByte(hh[4], x)
		} else {
			writeSingleByte(hh[4], x)
		}
		writeStringSingleByte(hh[5], x)
		if i == 0 {
			writeByte(hh[6], x)
		} else {
			writeStringSingleByte(hh[6], x)
		}
	}

	sum := hh[0].Sum64()
	for i, h := range hh {
		if sum != h.Sum64() {
			t.Errorf("hash %d not identical to a single Write", i)
		}
	}

	if sum1 := Bytes(hh[0].Seed(), b); sum1 != hh[0].Sum64() {
		t.Errorf("hash using Bytes not identical to a single Write")
	}

	if sum1 := String(hh[0].Seed(), string(b)); sum1 != hh[0].Sum64() {
		t.Errorf("hash using String not identical to a single Write")
	}
}
```

<highlight archetype="stream">ONE test drives seven write paths — mixes of
`Write`, `WriteString`, and `WriteByte` — and demands they all equal a single
`Write`'s `Sum64`; the failure message names which path diverged.</highlight>
<highlight archetype="transform">Top-level `Bytes` and `String` join the same
invariant, so the pure entry points and the incremental writer are held to one
answer.</highlight>

<note>The scenario grain to aspire to: the unit of testing is the invariant,
not the function. No table, no `t.Run`, no comment explaining test mechanics —
the code reads top to bottom.</note>

</sample>
