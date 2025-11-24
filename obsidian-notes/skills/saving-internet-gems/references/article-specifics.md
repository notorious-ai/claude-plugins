# Article-Specific Conventions

Load this file ONLY when capturing article content (blogs, documentation, essays, etc.). For shared conventions across all gems, see `shared-conventions.md`.

## Article Content Extraction

Extract article content using appropriate tools:
- WebFetch for fetching and processing web content
- Extract main article text, author information, publication details
- Get publication date, reading time if available
- Identify site/publication name

## INFO Callout Fields (Article-Specific)

Articles use these specific fields in the INFO callout:

```markdown
> [!INFO]
> **Source:** <https://example.com/article-url>
> **Site:** [[Site Name]]
> **Authors:** Author names
```

### Source Field
- Use the article's full URL
- Wrap in angle brackets: `<https://example.com/article>`
- Preserve the original URL (don't shorten)

### Site Field
- Extract the site or publication name (e.g., "Go Documentation", "GitHub Blog", "research!rsc")
- Format as backlink: `[[Site Name]]`
- Create backlink even if site page doesn't exist yet in vault
- Examples: `[[Go Documentation]]`, `[[GitHub Blog]]`, `[[research!rsc]]`

### Authors Field
- Extract author names from article metadata
- List multiple authors separated by commas
- Use "The [Team] team" format for team-authored content (e.g., "The Golang team")
- If no author identified, you may remove this line or note "Unknown"

### No Video Embed
- Articles do not include video embeds
- If a notable image is present, embed it

## Frontmatter (Article-Specific)

Articles use the `starred` field:

```yaml
---
starred: # Fill with today's date when saving (format: YYYY-MM-DD)
tags:
  - external/article  # MANDATORY - Must be first tag
  # Additional tags (2-4 suggested based on content)
---
```

**Critical:** First tag must be `external/article`.

Fill `starred:` field with today's date when saving the gem.

## Article Description Section

This section presents the article's content to help the user decide whether to read and what to expect.

**Strategy:**

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

## TL;DR for Articles

Articles use slightly different TL;DR phrasing:

**Context sentences:**
- "Read again when..." describing situations where article would be valuable
- "Send this to a friend who..." describing who would benefit
- "Reference this when..." describing use cases

Examples from existing articles:
- "Read the full guide if you're building performance-critical Go applications..."
- "Send this to a friend who: Feels frustrated by rigid programming communities..."

## Example Article Note Structure

See `examples/article-skeleton.md` for annotated structure showing:
- How each section should be filled
- What information goes where
- Common patterns for articles

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

## Common Article Mistakes to Avoid

- ❌ Don't include the full article text (summarize and index instead)
- ❌ Don't include article navigation, ads, or footer content
- ❌ Don't skip cleaning promotional elements
- ❌ Don't include newsletter signup prompts or social sharing widgets
- ❌ Don't forget to create [[Site Name]] backlink
