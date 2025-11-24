# Article Note Structure (Annotated Skeleton)

This file shows the structure of an article note with explanatory comments. Use this as a reference for creating actual article notes. Do NOT copy these comments into real notes.

```markdown
---
# NOTE: Articles do NOT have 'watched:' field - that's video-specific
tags:
  - external/article  # MANDATORY - Must be first tag
  # Suggest 2-4 additional relevant tags based on article content
  # Examples: tricks, shareworthy, styleguide, golang, architecture
---

> [!INFO]
> **Source:** <https://example.com/article-path>
> # Use full article URL wrapped in angle brackets
> # Preserve original URL (don't shorten for articles)
>
> **Site:** [[Site Name]]
> # Extract site/publication name and create backlink
> # Examples: [[Go Documentation]], [[GitHub Blog]], [[research!rsc]]
> # Create backlink even if site page doesn't exist yet
>
> **Authors:** Author Names
> # Extract from article metadata
> # Use "The [Team] team" format for team-authored (e.g., "The Golang team")
> # Comma-separated for multiple authors
> # May remove line or note "Unknown" if no author identified

## TL;DR

# Write brief compelling summary about WHY to read this article
# Before writing, READ 2-3 existing articles from Gems/Articles/ to understand user's style
# Focus on:
#   - What makes this article valuable or unique
#   - Key insights or perspectives offered
#   - NOT a comprehensive summary
#
# Keep it SHORT and focused on value

# Follow with context sentence (choose appropriate format):
#   - "Read again when..." describing situations where article is useful
#   - "Send this to a friend who..." describing who would benefit
#   - "Reference this when..." describing specific use cases
#
# Examples:
#   - "Read the full guide if you're building performance-critical Go applications..."
#   - "Send this to a friend who feels frustrated by rigid programming communities"
#   - "Reference this when tuning garbage collection behavior"

## Article Description

# Extract and present article's main content:
#
# 1. EXTRACT main article text using WebFetch or similar
#    - Get article content, avoiding navigation/ads/footers
#
# 2. CLEAN the content:
#    - Remove navigation elements, sidebars
#    - Remove ads, promotional material
#    - Remove newsletter signups, social sharing widgets
#    - Remove footers with company info
#    - Keep the article's core message and structure
#
# 3. CREATE navigable summary:
#    - Summarize key arguments and main points
#    - Include notable examples or case studies
#    - Highlight unique insights or perspectives
#    - Create index of article's structure
#    - Preserve important quotes or key insights
#
# 4. GOAL:
#    - Help user understand what article covers
#    - Don't include full article text - summarize and index
#    - Give enough context to decide whether to read in full
#
# For technical documentation:
#   - Note version/date documentation is current as of
#   - Highlight key sections or concepts
#   - May include direct quotes of important definitions
#
# For blog posts:
#   - Capture author's main argument or thesis
#   - Note if part of a series
#   - Include links to related posts if mentioned
#
# For essays/opinion pieces:
#   - Capture core argument
#   - Note author's perspective and background
#   - Highlight key supporting evidence
#
# For long-form articles:
#   - Create detailed index of sections
#   - Highlight major parts or chapters
#   - May include key quotes throughout

## Personal Takeaways

# Interactive workflow (same as videos):
#
# 1. READ 2-3 existing articles from Gems/Articles/
#    - Understand user's style and what they value
#    - Identify recurring themes and interests
#
# 2. ANALYZE this article's insights
#    - What connects to user's interests?
#    - What actionable insights exist?
#    - What perspectives challenge or expand thinking?
#
# 3. GENERATE 3-5 suggestions in FIRST PERSON (I/my) as user's voice:
#    - Focus on PERSONAL INSIGHTS derived from content, not summaries of what content says
#    - Express personal realizations: "I realized I've been [doing X wrong]..."
#    - Express shifts in thinking: "This changed how I think about [concept]..."
#    - Express discoveries: "I didn't know [fact] - this explains why [connection]..."
#    - Can be general reflections, not necessarily actionable items
#    - ❌ WRONG: "Notice how this solves X" (describes content)
#    - ✅ RIGHT: "I realized I've been missing X in my own work" (personal insight)
#
# 4. USE AskUserQuestion with multiSelect: true
#    - Present suggestions with value explanations
#    - Allow multiple selections, custom input, or rejection
#
# 5. WRITE selected takeaways in FIRST PERSON (I/my) as user's personal voice
#    - Use user's exact wording for custom input
#    - If rejected all, leave placeholder
#
# Example takeaway formats:
# - I didn't realize GOGC controls the balance between memory and CPU - I've been tuning blindly
# - I've felt this responsibility to explain both sides but never articulated it this clearly
# - This reinforces something I've felt about dogmatic thinking but couldn't express
# - I've been seeing this pattern in my own work without naming it

## Related Topics

# Discover and create backlinks across vault:
#
# 1. ALWAYS include site reference backlink
#    - For articles, create [[Site Name]] based on publication
#    - Examples: [[Go Documentation]], [[GitHub Blog]], [[research!rsc]]
#
# 2. SEARCH top-level vault folders:
#    - List directories: ls -d */ .obsidian
#    - Filter out .obsidian
#    - Check relevant folders for related pages
#
# 3. COMMON folders to check:
#    - Concept/ - conceptual backlinks (e.g., [[Golang]], [[Garbage Collection]])
#    - My Tools/ - tools mentioned in article
#    - My Stack/ - technologies discussed
#    - Books/ - if article references books
#    - Other folders as discovered and relevant
#
# 4. INCLUDE:
#    - Site reference: [[Site Name]]
#    - Concept backlinks from vault
#    - Related articles/resources if relevant
#    - External links mentioned in article
#
# 5. FORMAT as bulleted list:
# - [[Site Name]]
# - [[Concept 1]]
# - [[Concept 2]]
# - [[Related Article]]
# - External: https://example.com
#
# BE SELECTIVE - only include genuinely relevant links
# Don't force links where they don't naturally fit
```

## Key Principles for Articles

1. **No 'watched' field**: Articles omit this frontmatter field (videos only)
2. **No video embed**: Articles don't have the `![](url)` embed
3. **TL;DR variations**: Use "Read again when...", "Send to a friend who...", or "Reference when..."
4. **Description focus**: Create navigable summary, not full text. Clean promotional content.
5. **Site backlink**: Always create [[Site Name]] backlink (not [[YouTube]])
6. **Takeaways**: Same interactive workflow as videos, first person (I/my) personal insights
7. **Links**: Search broadly across vault folders

## Differences from Videos

| Element | Videos | Articles |
|---------|--------|----------|
| First tag | `external/video` (mandatory) | `external/article` (mandatory) |
| `watched:` field | Include (leave empty) | Omit entirely |
| Video embed | Include: `![](url)` | Omit |
| Source URL | Short youtu.be format | Full article URL |
| Platform reference | [[YouTube]] | [[Site Name]] |
| Event/Speakers | May include | Use Authors instead |
| TL;DR context | "Watch again when..." | "Read again when..." / "Send to..." |
