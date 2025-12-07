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
- Remove trailing slashes

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

### Hero Image
- If the article has a notable hero image, embed it at the end of the INFO callout: `![](image-url)`

## Article Description Strategy

This section preserves knowledge about the article and entices the reader to engage with the original.

**Key principle:** Extract, don't summarize. Summaries replace reading; extracts invite reading. Short or straightforward content may warrant a brief summary, but default to extracts for substantive articles.

**Quality expectation:** Writing a good description is high-cognitive work. Spend time refining it, paying attention to nuances. Don't settle for a first draft.

**Steps:**

1. **Extract and clean main content:**
   - Remove navigation elements, ads, footers, sidebars
   - Remove promotional elements and newsletter signups
   - Identify sections with HTML anchor IDs for deep linking

2. **Create a navigable index with extracts:**
   - Structure as an index of the article's sections
   - Pull direct quotes that capture key insights
   - Highlight surprising claims or counterintuitive ideas
   - Note memorable examples or case studies
   - Deep link to sections using reference-style: `[section title][section-id]`

3. **Preserve contextual images:**
   - Embed diagrams, illustrations, or screenshots that clarify the surrounding text: `![](image-url)`
   - Place each image where it provides value to the reader (not grouped at the end)
   - Skip decorative images that don't add informational content

**Requirements:**
- Extracts should pull the reader toward the original article
- Deep link to specific sections, not just the article URL
- Preserve the article's voice through direct quotes
- Do NOT restate or paraphrase the article's content

**Goal**: Capture knowledge hooks that make the reader want to revisit specific sections of the original.

## Article-Specific Considerations

**Technical documentation:**
- Note which version/date documentation is current as of
- Highlight key sections or concepts covered
- May include direct quotes of important definitions
- Copy short code snippets (a few lines) directly; link to longer ones

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
