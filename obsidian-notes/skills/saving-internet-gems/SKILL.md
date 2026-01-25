---
name: saving-internet-gems
description: This skill should be used when the user asks to "save this", "bookmark this", "capture this article", "capture this video", "add to vault", "take notes on this", or "refresh this note" combined with URLs (YouTube, Medium, blog posts, articles). CRITICAL - Only activate when inside an Obsidian vault (.obsidian directory present). Does not activate on URL presence alone.
---

# Saving Internet Gems

Capture videos and articles as structured markdown notes in an Obsidian vault.

## Activation Conditions

Activate when ALL conditions are met:
1. User expresses capture intent ("save this", "bookmark", "capture", "add to vault", "take notes on")
2. Message contains a URL (YouTube, Medium, blog, article)
3. Working directory contains `.obsidian` (is an Obsidian vault)

For comprehensive positive/negative activation corpus, see `activation-decisions.md`.

**Brief inline example (activate):**
> User: "Save this video for me: https://youtube.com/watch?v=abc123"
> Activate: clear capture intent + URL + (verify .obsidian exists)

**Brief inline example (don't activate):**
> User: "What do you think about this video? https://youtube.com/watch?v=abc123"
> Don't activate: discussion intent, not capture intent

## Safety Rules

**CRITICAL - NEVER VIOLATE:**
- Only create or modify files within `Gems/Videos/` and `Gems/Articles/` directories
- Never modify files outside Gems/
- Never edit template files or other vault files
- Each URL capture creates exactly ONE file in the appropriate Gems/ subdirectory
- If file already exists for same URL, may update only that specific file

## Workflow Overview

When activation conditions are met:

### 1. Validate Environment

```bash
test -d .obsidian
```
If not found, inform user this skill only works from Obsidian vault root.

### 2. Detect Content Type

- `youtube.com`, `youtu.be`, `vimeo.com` -> Video
- Blog domains, Medium, Substack, article URLs -> Article
- **When uncertain**: Use AskUserQuestion to let user choose

### 3. Load Type-Specific Reference

- **Videos**: Read `references/video-capture.md`
- **Articles**: Read `references/article-capture.md`

### 4. Extract Content & Build Note Structure

Follow the extraction strategy and INFO callout format from the type-specific reference.

### 5. Load Shared Workflow

Read `shared-workflow.md` for:
- Directory structure and filename generation
- Tag discovery strategy
- TL;DR section workflow
- Personal Takeaways interactive workflow
- Related Topics discovery workflow
- Migration workflow (for refreshing older notes)

### 6. Validate Output

Ensure:
- File created in correct Gems/ subdirectory only
- All required sections populated
- Proper formatting (embeds, links, backlinks)
- No other files were modified

### 7. Confirm to User

Report:
- Created filename and full path
- Brief summary of captured content
- Any issues encountered

## Reference Files

| File | Contains | Load When |
|------|----------|-----------|
| `shared-workflow.md` | Shared workflows (TL;DR, Takeaways, Topics, Tags, Migration) | Always after type-specific |
| `references/video-capture.md` | Video extraction, INFO fields, description strategy | Content is video |
| `references/article-capture.md` | Article extraction, INFO fields, description strategy | Content is article |

## Decision Support

When uncertain, consult these examples:
- **`activation-decisions.md`** - Comprehensive positive/negative activation cases
- **`quality-patterns.md`** - Good vs bad examples for each section type
- **`common-mistakes.md`** - Errors to avoid with explanations

For output structure reference, analyze 2-3 existing gems in the user's vault (`Gems/Videos/` or `Gems/Articles/`).
