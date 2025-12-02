# Article Capture Details

This file extends the workflow in SKILL.md with article-specific details. Load this when capturing article content (blogs, documentation, essays, etc.).

## Article Content Extraction

Extract article content using appropriate tools:
- WebFetch for fetching and processing web content
- Extract main article text, author information, publication details
- Get publication date if available
- Identify site/publication name

## INFO Callout Fields

Articles use these fields in the INFO callout:

```markdown
> [!INFO]
> **Source:** <https://example.com/article-url>
> **Site:** [[Site Name]]
> **Authors:** Author names
> **Published:** Month Day, Year
```

### Field Details

**Source:**
- Use the article's full URL
- Wrap in angle brackets: `<https://example.com/article>`
- Preserve the original URL (don't shorten)

**Site:**
- Identify the **content identity** - the publication, brand, blog, or author
- This is the "who" behind the content, NEVER the hosting platform
- Format as backlink: `[[Site Name]]`
- Create backlink even if page doesn't exist yet in vault

**Determining Site identity:**

| URL Pattern | Site Field | Reasoning |
|-------------|------------|-----------|
| `medium.com/better-programming/...` | [[Better Programming]] | Publication on Medium (platform goes in Related Topics) |
| `dev.to/author-name/...` | [[Author Name]] | Author's blog on dev.to (platform goes in Related Topics) |
| `go.dev/blog/...` | [[The Go Blog]] | Distinct section, NOT [[go.dev]] or [[Go Documentation]] |
| `go.dev/doc/effective_go` | [[Go Documentation]] | Documentation section of go.dev |
| `bravenewgeek.com/...` | [[Brave New Geek]] | Standalone site (no platform distinction needed) |
| `research.swtch.com/...` | [[research!rsc]] | Author's blog series |
| `martinfowler.com/bliki/...` | [[Martin Fowler's Bliki]] | Author's blog section |

**Key principle:** The Site field captures content identity. Hosting platforms (Medium, dev.to) are noted in Related Topics, not here.

**Authors:**
- Extract author names from article metadata
- List multiple authors separated by commas
- Use "The [Team] team" format for team-authored content (e.g., "The Golang team")
- If no author identified, REMOVE this line

**Published:**
- Extract publication date from article
- Format as: `Month Day, Year` (e.g., "June 7, 2015")
- If no date found, REMOVE this line

### No Video Embed
- Articles do not include video embeds
- If a notable hero image is present, consider embedding it

## Article Description Strategy

This section presents the article's content to help the user decide whether to read.

**Steps:**

1. **Extract and clean main content:**
   - Use WebFetch or similar to get article text
   - Remove navigation elements, ads, footers, sidebars
   - Remove promotional elements and newsletter signups
   - Preserve the article's core message and structure

2. **Create navigable summary:**
   - Summarize key arguments and main points
   - Include notable examples or case studies mentioned
   - Highlight unique insights or perspectives
   - Create an index of the article's structure

**Requirements:**
- Focus on helping user understand what the article covers
- Don't include full article text - create a summary/index
- Preserve important quotes or key insights
- Help user decide whether to read in full

**Goal**: Give user enough context to understand the article's value and decide whether to invest time reading it.

## Article-Specific Considerations

**Technical documentation:**
- Note which version/date documentation is current as of
- Highlight key sections or concepts covered
- May include direct quotes of important definitions

**Blog posts:**
- Capture author's main argument or thesis
- Note if post is part of a series
- Include links to related posts if mentioned

**Essays and opinion pieces:**
- Capture the core argument
- Note the author's perspective and background
- Highlight key supporting evidence or examples

**Long-form articles:**
- Create more detailed index of sections
- Highlight major sections or chapters
- May include key quotes from throughout

**Multi-part series:**
- Note if article is part of a series
- May want to capture other parts separately
- Include navigation links if available

For common mistakes to avoid, see `examples/common-mistakes.md`.
