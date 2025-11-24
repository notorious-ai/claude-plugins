---
name: saving-internet-gems
description: This skill should be used when the user asks to "save this", "bookmark this", "capture this article", "capture this video", "add to vault", or "take notes on this" combined with URLs (YouTube, Medium, blog posts, articles). Activates when working inside an Obsidian vault and user expresses intent to preserve online content. Creates formatted markdown notes with metadata, summaries, and tags. Does not activate on URL presence alone.
---

Use this skill to capture online content (videos, articles, blog posts) as structured markdown notes in an Obsidian vault. The skill activates based on user intent to save content, not mere URL presence.

## Activation Conditions

This skill activates when ALL of the following are true:
- The current working directory contains a `.obsidian` directory (working at vault root)
- User expresses capture intent with phrases like:
  - "save this"
  - "bookmark this"
  - "capture this video/article"
  - "add to vault"
  - "take notes on this"
- A content URL is present (YouTube, blog, article, etc.)

**CRITICAL**: Do NOT activate on URL presence alone. User must indicate desire to capture content.

## Examples

<example>
Context: User is working inside Obsidian vault and wants to save a video
user: "Save this for later: https://www.youtube.com/watch?v=abc123"
assistant: "I'll capture this YouTube video as a structured note in your Gems/Videos/ directory."
<commentary>
Clear capture intent + URL + .obsidian present → activate skill and capture video
</commentary>
</example>

<example>
Context: User shares URL for discussion, not capture
user: "What do you think about this video? https://youtube.com/watch?v=abc123"
assistant: [Regular response discussing the video, skill does NOT activate]
<commentary>
URL present but no capture intent signals → don't activate. User wants discussion, not capture.
</commentary>
</example>

<example>
Context: User wants to bookmark multiple articles
user: "Bookmark these articles for me: https://blog.example.com/post1 and https://example.org/article"
assistant: "I'll capture both articles as structured notes in your Gems/Articles/ directory."
<commentary>
Multiple URLs with explicit bookmark intent → activate for each URL and create separate notes
</commentary>
</example>

<example>
Context: Working outside Obsidian vault
user: "Save this video: https://youtube.com/watch?v=xyz"
assistant: [Regular response, skill does NOT activate]
<commentary>
No .obsidian directory found → don't activate. Skill only works within Obsidian vaults.
</commentary>
</example>

---

This skill captures and structures online knowledge into Obsidian vault notes following the user's established patterns and conventions.

## Content Type Detection

Analyze URL patterns to determine content type:
- `youtube.com`, `youtu.be`, `vimeo.com` → Video
- Blog domains, article URLs, Medium, Substack → Article
- **When uncertain**: Use AskUserQuestion to let user choose between video and article

## Workflow

When activation conditions are met:

### 1. Validate Environment

Check that `.obsidian` directory exists in current working directory:
```bash
test -d .obsidian
```

If not found, do not proceed. Inform user this skill only works from Obsidian vault root.

### 2. Detect Content Type

Analyze the URL to determine if it's a video or article. If uncertain, ask the user.

### 3. Load Shared Conventions

See `references/shared-conventions.md` for:
- Directory structure (Gems/Videos/, Gems/Articles/)
- Shared template sections (INFO callout, TL;DR, Personal Takeaways, Related Topics)
- Backlink discovery across vault folders
- Safety rules (only modify Gems/)

### 4. Load Content-Specific Details

Based on detected content type:
- **Videos**: See `references/video-specifics.md` for video extraction and formatting
- **Articles**: See `references/article-specifics.md` for article extraction and formatting

### 5. Extract Content

Use appropriate tools to extract metadata and content:
- Videos: Extract metadata, transcript, and video information
- Articles: Extract article content, author, and publication details

### 6. Analyze Existing Style

Before creating note:
- Read 2-3 existing gems from the target directory (Gems/Videos/ or Gems/Articles/)
- Understand user's writing style for TL;DR and Personal Takeaways
- Identify patterns in what user finds valuable

### 7. Create Note

Generate markdown file in appropriate directory:
- Videos: `Gems/Videos/[Title].md`
- Articles: `Gems/Articles/[Title].md`

Follow structure from annotated skeletons:
- Videos: `examples/video-skeleton.md`
- Articles: `examples/article-skeleton.md`

### 8. Generate Personal Takeaways Interactively

After analyzing existing notes and understanding user's patterns:
- Generate 3-5 personal takeaway suggestions based on content
- Use AskUserQuestion tool to present suggestions
- Allow multi-select and custom input via "Other"
- Include selected takeaways in note

### 9. Validate

Ensure:
- File created in correct Gems/ subdirectory only
- All required sections populated
- Proper formatting (embeds, links, backlinks)
- Backlinks discovered from relevant vault folders
- No other files were modified

## Safety Rules

**CRITICAL - NEVER VIOLATE THESE RULES:**
- Only create or modify files within `Gems/Videos/` and `Gems/Articles/` directories
- Never edit, modify, or delete files outside Gems/
- Never modify template files or other vault files
- Each URL capture results in exactly ONE file operation in Gems/
- If file already exists for same URL, may update only that specific file

## Output

Confirm successful capture with:
- Created filename and full path
- Brief summary of captured content (title and source)
- Report any issues encountered

## Additional Resources

**For detailed conventions:**
- `references/shared-conventions.md` - Common elements across all gems
- `references/video-specifics.md` - Video-only details and formatting
- `references/article-specifics.md` - Article-only details and formatting

**For structure reference:**
- `examples/video-skeleton.md` - Annotated video note structure
- `examples/article-skeleton.md` - Annotated article note structure
