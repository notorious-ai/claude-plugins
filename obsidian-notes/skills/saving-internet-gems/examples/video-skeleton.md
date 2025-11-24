# Video Note Structure (Annotated Skeleton)

This file shows the structure of a video note with explanatory comments. Use this as a reference for creating actual video notes. Do NOT copy these comments into real notes.

```markdown
---
starred: # Fill with today's date when saving (format: YYYY-MM-DD)
tags:
  - external/video  # MANDATORY - Must be first tag
  # Suggest 2-4 additional relevant tags based on video content
  # Examples: shareworthy, ai, golang, distributed-systems, architecture
---

> [!INFO]
> **Source:** <https://youtu.be/VIDEO_ID>
> # Extract VIDEO_ID from any YouTube URL format
> # Always use SHORT youtu.be format, wrapped in angle brackets
>
> **Channel:** [Channel Name](https://www.youtube.com/@ChannelHandle)
> # Extract channel name and URL from video metadata
> # Format as markdown link with @ handle when available
>
> **Event:** [[Event Name]] YEAR
> # Extract conference/event from title, description, or channel
> # Format with backlink to event page and year
> # Examples: [[GopherCon]] 2024, [[Cloud Native Computing Foundation]] InfoQ Webinar
> # REMOVE THIS LINE if no event detected
>
> **Speakers:** Speaker Names
> # Extract from metadata, description, or title
> # Comma-separated list for multiple speakers
> # REMOVE THIS LINE if no speakers identified
>
> ![](https://www.youtube.com/watch?v=VIDEO_ID)
> # Video embed using FULL YouTube URL (not short format)
> # This renders as embedded player in Obsidian

## TL;DR

# Write 2-3 PUNCHY sentences about WHY to watch this video
# Before writing, READ 2-3 existing videos from Gems/Videos/ to understand user's style
# Focus on:
#   - The compelling hook or key insight
#   - Unique value proposition or perspective
#   - NOT a dry summary of topics covered
#
# Example approach: "This talk revolutionizes how you think about [X] by showing [Y]."
# Keep it SHORT and reader-focused

# Follow with separate paragraph:
# "Watch again when..." describing specific situations where this video would be valuable
# Example: "Watch again when designing distributed systems at scale."

## Video Description

# Strategy depends on YouTube description quality:
#
# OPTION 1 - If YouTube description is clean and informative:
#   - Start with the original description
#   - If short, add "Highlights" subsection with key points from transcript
#
# OPTION 2 - If YouTube description is spammy/promotional:
#   - Reconstruct from transcript
#   - Create index of main topics, arguments, notable examples
#
# Requirements:
#   - REMOVE: promotions, ads, spammy links, thank yous, credits, donations
#   - REMOVE: weirdly formatted paragraphs, timestamp spam (unless useful chapters)
#   - FOCUS: Create navigable content index
#   - GOAL: Help user decide whether to watch and what to look for
#
# DO NOT recap entire video - this should complement watching, not replace it

## Personal Takeaways

# This section is generated through interactive workflow:
#
# 1. READ 2-3 existing videos from Gems/Videos/
#    - Understand user's takeaway style and patterns
#    - Identify what user finds valuable and highlights
#    - Note recurring themes and interests
#
# 2. ANALYZE this video's content
#    - What insights connect to user's interests?
#    - What actionable insights or novel perspectives exist?
#    - What concepts link to broader ideas?
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
# 4. USE AskUserQuestion tool with multiSelect: true
#    - Present suggestions with explanations of why each is valuable
#    - Allow user to select multiple, add custom, or reject all
#
# 5. WRITE selected takeaways in FIRST PERSON (I/my) as user's personal voice
#    - Use user's exact wording if they provided custom input
#    - If user rejected all, leave placeholder note
#
# Example takeaway format:
# - I realized the AI progression (LLM → Agent → Agentic) maps to my own journey
# - I hadn't considered framing failure as iteration before - this shifts my perspective
# - I've been making decisions without a framework - this three-question approach could help

## Related Topics

# Discover and create backlinks across vault:
#
# 1. ALWAYS include [[YouTube]] for all videos
#
# 2. SEARCH top-level vault folders:
#    - List all directories: ls -d */ .obsidian
#    - Filter out .obsidian
#    - Check relevant folders for related pages
#
# 3. COMMON folders to check:
#    - Concept/ - conceptual backlinks (e.g., [[Golang]], [[Distributed Systems]])
#    - My Tools/ - tools mentioned in video
#    - My Stack/ - technologies discussed
#    - Books/ - if video references books
#    - Other folders as discovered and relevant
#
# 4. INCLUDE:
#    - Platform reference: [[YouTube]]
#    - Concept backlinks from vault
#    - Related talks/resources if relevant
#    - External links mentioned in video (wikis, blogs, docs)
#
# 5. FORMAT as bulleted list:
# - [[YouTube]]
# - [[Concept 1]]
# - [[Concept 2]]
# - [[My Tool]]
# - [[Related Video]]
# - External: https://example.com
#
# BE SELECTIVE - only include genuinely relevant links
```

## Key Principles for Videos

1. **TL;DR**: Punchy, value-focused, includes "Watch again when..." context
2. **Description**: Index of content, not full recap. Remove promotional material.
3. **Takeaways**: Interactive workflow, analyze existing notes first, first person (I/my) personal insights
4. **Links**: Search broadly across vault, not just Concept/. Always include [[YouTube]].
5. **Metadata**: Extract comprehensively. Event and Speakers optional (remove if N/A).
