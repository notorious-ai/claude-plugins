# encoding/json — the example doc-comment voice

<sample id="example-user-voice" archetypes="example" source="encoding/json/example_test.go">

```go
// This example uses a Decoder to decode a stream of distinct JSON values.
func ExampleDecoder() {
	const jsonStream = `
	{"Name": "Ed", "Text": "Knock knock."}
	{"Name": "Sam", "Text": "Who's there?"}
	{"Name": "Ed", "Text": "Go fmt."}
	{"Name": "Sam", "Text": "Go fmt who?"}
	{"Name": "Ed", "Text": "Go fmt yourself!"}
`
	type Message struct {
		Name, Text string
	}
	dec := json.NewDecoder(strings.NewReader(jsonStream))
	for {
		var m Message
		if err := dec.Decode(&m); err == io.EOF {
			break
		} else if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("%s: %s\n", m.Name, m.Text)
	}
	// Output:
	// Ed: Knock knock.
	// Sam: Who's there?
	// Ed: Go fmt.
	// Sam: Go fmt who?
	// Ed: Go fmt yourself!
}
```

<highlight archetype="example">The doc comment reads "This example uses a
Decoder to decode a stream of distinct JSON values." — it speaks to USERS on
pkgsite, about the attributed symbol and the scenario, and it does NOT open
with the function's own name. It never narrates the code, never addresses
maintainers, never describes the example function itself.</highlight>

<note>The example is also full-length: a five-message stream, a realistic
decode loop with the `io.EOF` termination idiom users must learn. Do not
shorten examples to their minimum token count.</note>

</sample>

<sample id="example-self-naming-violation" archetypes="example" source="bufio/example_test.go">

The violation, NOT to copy.

```go
// ExampleWriter_ReadFrom demonstrates how to use the ReadFrom method of Writer.
func ExampleWriter_ReadFrom() {
```

<highlight archetype="example">The stdlib itself slips: this doc comment opens
with the function's own name and narrates the example ("demonstrates how to
use..."), telling a pkgsite reader nothing the signature does not.</highlight>

<note>Canon is what the Go team practices at its best, not everything it ever
committed — when you find this shape, write the json form instead.</note>

</sample>
