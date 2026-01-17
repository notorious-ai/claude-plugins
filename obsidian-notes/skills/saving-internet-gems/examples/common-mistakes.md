# Common Mistakes to Avoid

This file consolidates common mistakes across all gem types with explanations of why they're wrong and the correct approach.

## TL;DR Section Mistakes

### Mistake: Generic topic listing
**What's wrong:**
> This video covers Go concurrency, channels, and goroutines.

**Why it's wrong:** Lists topics without any hook or value proposition. Could describe hundreds of videos.

**Correct approach:** Lead with the compelling insight or unique perspective. Focus on WHY to watch, not WHAT it covers.

---

### Mistake: Missing context sentence
**What's wrong:**
> Great talk about error handling in Go that shows elegant patterns.

**Why it's wrong:** Doesn't tell reader when this would be valuable to revisit.

**Correct approach:** Always include "Watch again when..." (videos) or "Read again when..." / "Send this to a friend who..." (articles).

---

### Mistake: Comprehensive summary
**What's wrong:**
> This 45-minute talk first introduces the basics, then covers intermediate patterns, then advanced techniques, and concludes with best practices...

**Why it's wrong:** Too long, reads like a table of contents, not punchy.

**Correct approach:** Keep TL;DR to 3-4 sentences total. Be punchy and focused on value, not comprehensive.

---

## Personal Takeaways Mistakes

### Mistake: Describing content instead of personal insight
**What's wrong:**
- Notice how the speaker explains the difference between concurrency and parallelism.
- The talk demonstrates important patterns for error handling.

**Why it's wrong:** These describe what the content says, not what YOU learned from it.

**Correct approach:** Express personal realizations: "I realized I've been confusing concurrency with parallelism in my own code."

---

### Mistake: Writing in second or third person
**What's wrong:**
- You should consider using channels instead of mutexes.
- Developers often make this mistake with goroutines.

**Why it's wrong:** Takeaways should be the USER's voice, not advice to the user or general observations.

**Correct approach:** Use first person (I/my): "I need to reconsider my use of mutexes - channels might simplify my code."

---

### Mistake: Generic truisms
**What's wrong:**
- Architecture decisions are important.
- Good code is maintainable.

**Why it's wrong:** These could be written without reading the content. They're not actual insights.

**Correct approach:** Be specific about what YOU learned that changed YOUR thinking.

---

### Mistake: Skipping the interactive workflow
**What's wrong:** Writing takeaways without asking the user to select/customize them.

**Why it's wrong:** Takeaways should reflect the USER's actual insights, not Claude's assumptions.

**Correct approach:** Always use AskUserQuestion with multiSelect to let user choose, customize, or reject suggestions.

---

## Description Section Mistakes

### Mistake: Including promotional content
**What's wrong:**
> SUBSCRIBE for more! Follow us on Twitter @channel. Use code SAVE20...

**Why it's wrong:** This is spam that adds no value to the gem note.

**Correct approach:** Strip all promotional content, social links, sponsor messages, newsletter signups.

---

### Mistake: Full content copy-paste
**What's wrong:** Pasting the entire article text or full video transcript.

**Why it's wrong:** Defeats the purpose of the gem note. Should complement, not replace, original content.

**Correct approach:** Create a navigable summary/index that helps decide whether to watch/read the full content.

---

### Mistake: No structure
**What's wrong:**
> The video talks about several things related to distributed systems and microservices and monoliths and there are some good points about architecture.

**Why it's wrong:** Stream of consciousness without organization.

**Correct approach:** Use headers to structure the description. Create an index of main topics/arguments.

---

## Related Topics Mistakes

### Mistake: Repeating Site backlink (articles only)
**What's wrong:**
```markdown
> [!INFO]
> **Site:** [[Brave New Geek]]

## Related Topics
- [[Brave New Geek]]  <-- WRONG: duplicates INFO callout
```

**Why it's wrong:** Creates redundancy within the same note.

**Correct approach:** For articles, the Site is already linked in INFO. Only add hosting platform if different (e.g., Site is "Better Programming" → could add [[Medium]]).

---

### Mistake: Too many backlinks
**What's wrong:**
- [[YouTube]]
- [[Programming]]
- [[Software]]
- [[Technology]]
- [[Computers]]
- [[Internet]]
- [[Learning]]
- [[Videos]]

**Why it's wrong:** Most are too generic to be useful. Dilutes genuinely relevant connections.

**Correct approach:** Be selective. Include only genuinely relevant links. If you have more than 8 candidates, use AskUserQuestion to let user choose.

---

### Mistake: Limited to Concept/ folder only
**What's wrong:** Only searching `Concept/` for backlinks.

**Why it's wrong:** Misses relevant pages in other folders like `My Tools/`, `My Stack/`, `Books/`.

**Correct approach:** Use `ls -d */` to discover all top-level folders and search relevant ones.

---

## Video-Specific Mistakes

### Mistake: Wrong URL format for embed
**What's wrong:**
```markdown
> ![](https://youtu.be/VIDEO_ID)
```

**Why it's wrong:** Embed requires full YouTube URL format to render in Obsidian.

**Correct approach:** Use full format: `![](https://www.youtube.com/watch?v=VIDEO_ID)`

---

### Mistake: Including both Channel and Event when only one applies
**What's wrong:**
```markdown
> **Channel:** [Some Conference](...)
> **Event:** [[Some Conference]] 2024
```

**Why it's wrong:** In practice, these are mutually exclusive. Conference talks have Event, regular YouTube videos have Channel.

**Correct approach:** Include Channel for regular YouTube content, Event for conference talks. Both only when genuinely applicable.

---

## Article-Specific Mistakes

### Mistake: Using Site field for just the domain
**What's wrong:**
```markdown
> **Site:** [[medium.com]]
```

**Why it's wrong:** Site should identify the logical brand/publication, not just the domain.

**Correct approach:** Use the publication name: `[[Better Programming]]` (on Medium), `[[research!rsc]]` (on blogspot).

---

### Mistake: Including navigation/sidebar content
**What's wrong:** Description includes "Previous Post | Next Post", sidebar widgets, footer links.

**Why it's wrong:** This is page chrome, not article content.

**Correct approach:** Extract only the main article content. Remove all navigation, sidebars, footers.

---

### Mistake: Reference-style syntax for hero image embed
**What's wrong:**
```markdown
![Hero][img]

[img]: https://example.com/hero.jpg
```

**Why it's wrong:** Obsidian requires inline format for image embeds to render.

**Correct approach:** Use inline format: `![](https://example.com/hero.jpg)`

---

## General Mistakes

### Mistake: Creating files outside Gems/
**What's wrong:** Creating gem files anywhere other than `Gems/Videos/` or `Gems/Articles/`.

**Why it's wrong:** Violates safety rules. Only these directories should be modified.

**Correct approach:** Always use `Gems/Videos/` for videos, `Gems/Articles/` for articles.

---

### Mistake: Overly long filenames
**What's wrong:** `This Is A Very Long Video Title That Goes On And On And Includes Lots Of Details And Maybe Even The Full Description.md`

**Why it's wrong:** Can cause filesystem issues and is hard to navigate.

**Correct approach:** Limit filenames to 200 characters maximum. Strip metadata patterns from titles.

---

### Mistake: Inventing new tags
**What's wrong:** Adding tags like `#my-new-category` without checking existing vault tags.

**Why it's wrong:** Creates tag fragmentation in the vault.

**Correct approach:** Discover existing tags first (see `scripts/list-vault-tags.sh` in the skill directory) and prefer them. Only create new tags when no existing tag fits.

---

### Mistake: Wrong first tag
**What's wrong:**
```yaml
tags:
  - golang
  - external/video
```

**Why it's wrong:** First tag MUST be `external/video` or `external/article`.

**Correct approach:** Always put the type tag first, then additional tags.
