# Quality Patterns

This file shows good vs bad examples for each section type to help Claude make better judgment calls about content quality.

## TL;DR Section

### Good Examples

**Example 1 (Video):**
> This talk revolutionizes how you think about error handling in Go by showing that errors are values to be programmed, not just checked. Rob Pike demonstrates elegant patterns that make error handling feel natural rather than tedious.
>
> Watch again when you're frustrated with repetitive error checking or designing a new Go API.

**Why it works:**
- Opens with compelling hook ("revolutionizes how you think")
- Focuses on unique insight (errors as values)
- Speaks to reader's pain points
- Context sentence gives concrete use case

---

**Example 2 (Article):**
> This article challenges the rush toward microservices, arguing that most teams lack the organizational maturity needed to succeed with distributed architectures. Treat advocates starting with well-structured monoliths and extracting services only when justified by genuine complexity.
>
> Read again when facing the decision on new projects about whether to start with microservices or a monolith. Send this to a colleague who's considering breaking up a system into microservices.

**Why it works:**
- States the contrarian position clearly
- Captures the main argument
- Multiple context sentences for different use cases

---

### Bad Examples

**Example 1:**
> This video covers Go concurrency, channels, goroutines, and synchronization primitives. The speaker discusses various patterns and shows code examples.

**Why it fails:**
- Generic list of topics (no hook)
- No value proposition (why should I care?)
- Missing context sentence
- Could describe hundreds of videos

---

**Example 2:**
> Great article about software architecture.

**Why it fails:**
- Too vague ("great" means nothing)
- No specific insight mentioned
- Missing context sentence entirely
- Tells nothing about what makes it worth reading

---

## Personal Takeaways Section

### Good Examples

**Example 1:**
- I realized I've been rushing into microservices without considering organizational maturity.
- I need to establish observable reasons before distributing systems.
- I am aware of distributed-system's complexity, this reinforces it elegantly (good for sharing with colleagues).

**Why it works:**
- First person voice (I realized, I need, I am)
- Personal insights derived from content
- Connects to own work/experience
- Expresses shifts in thinking

---

**Example 2:**
- I hadn't considered framing failure as iteration before - this shifts my perspective on experimentation.
- The AI progression (LLM → Agent → Agentic) maps to my own journey with these tools.
- I've been making decisions without a framework - the three-question approach could help.

**Why it works:**
- Each takeaway is a personal realization
- Shows how content changed thinking
- Specific to the individual (not generic advice)

---

### Bad Examples

**Example 1:**
- Notice how the speaker explains the difference between concurrency and parallelism.
- Consider using channels instead of mutexes in your code.
- The talk covers important topics about Go's runtime.

**Why it fails:**
- Describes what content says (not personal insight)
- Gives advice to reader (second person "your")
- Third takeaway is just a summary

---

**Example 2:**
- Microservices have trade-offs.
- Monoliths can be good.
- Architecture decisions matter.

**Why it fails:**
- Generic truisms anyone could write
- No personal voice or connection
- Doesn't reflect any actual insight gained

---

## Description Section

### Good Examples

**Example 1 (Video - reconstructed from transcript):**
> ### The Core Argument
>
> Teams suffer from "microservice envy" and rush into complex distributed architectures without understanding the costs. The fundamental principle:
>
> > don't distribute your system until you have an observable reason to.
>
> ### Why Monoliths Aren't the Enemy
>
> Contrary to industry perception, monolithic systems can be modular, maintainable, and resilient.
>
> ### Prerequisites for Success
>
> Microservices require several foundations:
> - Proper continuous-delivery pipelines
> - Competent DevOps teams
> - Prudent service boundaries

**Why it works:**
- Structured with clear headings
- Preserves key quotes
- Creates navigable index
- Helps reader decide whether to watch

---

**Example 2 (Article - cleaned extraction):**
> Treat introduces "service-disoriented architecture" as the pattern that emerges when teams adopt microservices prematurely.
>
> ### Recommended Approach
>
> Start with a monolith, ensure correct data models and service boundaries, and gradually extract finer-grained services as organizational maturity grows.

**Why it works:**
- Clean, focused summary
- No promotional content
- Captures actionable recommendation

---

### Bad Examples

**Example 1 (copy-pasted YouTube description):**
> SUBSCRIBE for more content!
> Follow us on Twitter: @channel
> Join our Discord: discord.gg/xxx
>
> In this video we talk about microservices and stuff.
>
> TIMESTAMPS:
> 0:00 Intro
> 1:23 Chapter 1
> ...
>
> Thanks to our sponsors!
> Use code SAVE20 for 20% off...

**Why it fails:**
- Contains promotional spam
- Social media links irrelevant
- Timestamps without context
- Sponsor messages included

---

**Example 2 (full article copy):**
> [Entire 3000-word article pasted verbatim]

**Why it fails:**
- No summary or index created
- Doesn't help reader decide whether to read
- Defeats purpose of the gem note
- Should complement, not replace, original content

---

## Related Topics Section

### Good Examples

**Example 1 (Video):**
```markdown
> [!INFO]
> **Channel:** [GopherCon](...)

## Related Topics
- [[YouTube]]
- [[Systems Architecture]]
- [[Golang]]
```

**Why it works:**
- Videos ALWAYS include platform ([[YouTube]])
- Channel is in INFO callout, not repeated here
- Relevant concept backlinks
- Selective (only 3 items)

---

**Example 2 (Article on hosting platform - Medium):**
```markdown
> [!INFO]
> **Site:** [[Better Programming]]

## Related Topics
- [[Medium]]
- [[Software Engineering]]
- [[Career]]
```

**Why it works:**
- Site (Better Programming) is the content identity in INFO
- Hosting platform ([[Medium]]) noted in Related Topics
- No duplication - these are different things

---

**Example 3 (Article on standalone site):**
```markdown
> [!INFO]
> **Site:** [[Brave New Geek]]

## Related Topics
- [[microservices]]
- [[Distributed Systems]]
- [[Systems Architecture]]
```

**Why it works:**
- Standalone site = NO hosting platform to mention
- Does NOT include [[Brave New Geek]] (already in INFO)
- Only concept backlinks relevant to content

---

**Example 4 (Article on domain subsection):**
```markdown
> [!INFO]
> **Site:** [[The Go Blog]]

## Related Topics
- [[Golang]]
- [[Concurrency]]
```

**Why it works:**
- Site is [[The Go Blog]], NOT [[go.dev]]
- NO [[go.dev]] in Related Topics (same domain, different section)
- Focused concept backlinks

---

### Bad Examples

**Example 1 (Too generic):**
- [[YouTube]]
- [[Programming]]
- [[Software]]
- [[Technology]]
- [[Computers]]
- [[Engineering]]
- [[Internet]]
- [[Learning]]

**Why it fails:**
- Too many items (8+)
- Most are too generic to be useful
- Forced connections that add no value
- Not selective

---

**Example 2 (Duplicates Site in Related Topics):**
```markdown
> [!INFO]
> **Site:** [[Brave New Geek]]

## Related Topics
- [[Brave New Geek]]  <-- WRONG
- [[microservices]]
```

**Why it fails:**
- Repeats Site backlink from INFO callout
- Creates duplication within the same note

---

**Example 3 (Wrong platform for domain subsection):**
```markdown
> [!INFO]
> **Site:** [[The Go Blog]]

## Related Topics
- [[go.dev]]  <-- WRONG
- [[Golang]]
```

**Why it fails:**
- [[go.dev]] is the same domain as the Site
- This isn't a hosting platform relationship
- The Go Blog IS part of go.dev, just a different section

---

## Further Reading Subsection

This subsection captures external resources that the content author/speaker explicitly recommends or references.

### Good Examples

**Example 1 (Conference talk with code samples):**
```markdown
## Related Topics
- [[YouTube]]
- [[Golang]]
- [[Concurrency]]

### Further Reading
- [sync package](https://pkg.go.dev/sync) - standard library reference for primitives discussed
- [errgroup example](https://github.com/golang/go/blob/master/src/sync/errgroup/errgroup_example_test.go) - code samples from the talk
- [Concurrency is not Parallelism](https://youtu.be/oV9rvDllKEg) - related talk by Rob Pike mentioned
```

**Why it works:**
- Clear subsection header for author-recommended resources
- Brief context after each link explaining WHY the author linked it
- Mix of documentation, code, and related content
- All links are substantive references, not promotional

---

**Example 2 (Technical article with Wikipedia references):**
```markdown
## Related Topics
- [[Medium]]
- [[Distributed Systems]]
- [[CAP Theorem]]

### Further Reading
- [CAP theorem on Wikipedia](https://en.wikipedia.org/wiki/CAP_theorem) - background on the impossibility result
- [Jepsen Analyses](https://jepsen.io/analyses) - testing reports mentioned for verifying consistency claims
- [Designing Data-Intensive Applications](https://dataintensive.net/) - book recommended for deeper study
```

**Why it works:**
- Wikipedia link provides background context for technical concept
- Each resource has clear relevance to article topic
- Descriptions explain the resource's role in the original content
- Links to specific pages (analyses), not just homepage

---

**Example 3 (Video with slides and further reading):**
```markdown
## Related Topics
- [[YouTube]]
- [[Systems Architecture]]

### Further Reading
- [Slides (PDF)](https://speakerdeck.com/author/talk-slides) - presentation slides
- [Author's Blog Post](https://blog.example.com/deeper-dive) - expanded version of this talk
- [DDIA Chapter 5](https://dataintensive.net/ch05.html) - recommended reading on replication
```

**Why it works:**
- Includes complementary resources (slides for visual reference)
- Links to author's expanded writing on the topic
- Specific chapter reference, not just generic book link

---

### Bad Examples

**Example 1 (Self-promotional links):**
```markdown
### Further Reading
- [Follow me on Twitter](https://twitter.com/author)
- [Subscribe to my newsletter](https://author.substack.com)
- [My course on Udemy](https://udemy.com/author-course)
- [Buy my book](https://amazon.com/author-book)
```

**Why it fails:**
- All links are self-promotional
- These should be SKIPPED entirely
- No substantive external resources
- The subsection should not exist if these are the only links

---

**Example 2 (Missing context and formatting):**
```markdown
### Further Reading
- https://en.wikipedia.org/wiki/Consensus_(computer_science)
- https://github.com/etcd-io/etcd
- https://raft.github.io/
```

**Why it fails:**
- Raw URLs without descriptive titles
- Missing the "- context" explanation after each link
- Reader can't understand relevance without clicking
- Should use markdown link format with meaningful titles

---

**Example 3 (Generic domain links):**
```markdown
### Further Reading
- [Go website](https://golang.org)
- [GitHub](https://github.com)
- [Stack Overflow](https://stackoverflow.com)
```

**Why it fails:**
- Links to generic homepages, not specific resources
- No clear connection to content topics
- Should link to SPECIFIC pages, repos, or questions
- These add no value - reader already knows these sites exist

---

**Example 4 (Claude's suggestions, not author's):**
```markdown
### Further Reading
- [Related concept on Wikipedia](https://en.wikipedia.org/wiki/Some_term) - you might find this interesting
- [Popular repo](https://github.com/popular/repo) - this could help with implementation
- [Tutorial](https://example.com/tutorial) - good starting point for beginners
```

**Why it fails:**
- Phrasing suggests Claude's recommendations ("you might find", "could help")
- Author never mentioned these resources
- This subsection is for resources the author recommended only
- Claude's suggestions belong elsewhere (or not at all)

---

## Key Principles Summary

| Section | Good Pattern | Bad Pattern |
|---------|-------------|-------------|
| TL;DR | Punchy, value-focused, includes context | Generic topic list, no hook |
| Takeaways | First-person insights, personal realizations | Content summaries, generic advice |
| Description | Clean index, structured, preserves quotes | Spam-filled, full copy-paste |
| Related Topics | Selective, relevant, platform only when hosted | Too many, duplicates INFO, wrong platform logic |
| Further Reading | Specific resources author linked, with context | Promotional, generic homepages, Claude suggestions |

### Platform Reference Quick Guide

| Content Type | INFO Field | Related Topics Platform |
|--------------|------------|------------------------|
| Video (any) | Channel: [[Creator]] | Always [[YouTube]] |
| Article (Medium/dev.to) | Site: [[Publication]] | Include [[Medium]] or [[dev.to]] |
| Article (standalone) | Site: [[Site Name]] | NO platform needed |
| Article (domain subsection) | Site: [[Subsection Name]] | NO same-domain backlink |
