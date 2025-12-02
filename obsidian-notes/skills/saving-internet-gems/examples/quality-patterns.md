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

## Key Principles Summary

| Section | Good Pattern | Bad Pattern |
|---------|-------------|-------------|
| TL;DR | Punchy, value-focused, includes context | Generic topic list, no hook |
| Takeaways | First-person insights, personal realizations | Content summaries, generic advice |
| Description | Clean index, structured, preserves quotes | Spam-filled, full copy-paste |
| Related Topics | Selective, relevant, platform only when hosted | Too many, duplicates INFO, wrong platform logic |

### Platform Reference Quick Guide

| Content Type | INFO Field | Related Topics Platform |
|--------------|------------|------------------------|
| Video (any) | Channel: [[Creator]] | Always [[YouTube]] |
| Article (Medium/dev.to) | Site: [[Publication]] | Include [[Medium]] or [[dev.to]] |
| Article (standalone) | Site: [[Site Name]] | NO platform needed |
| Article (domain subsection) | Site: [[Subsection Name]] | NO same-domain backlink |
