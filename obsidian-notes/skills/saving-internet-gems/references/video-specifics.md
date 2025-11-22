# Video-Specific Conventions

Load this file ONLY when capturing video content (YouTube, Vimeo, etc.). For shared conventions across all gems, see `shared-conventions.md`.

## Video Metadata Extraction

Use yt-dlp or similar tools to extract comprehensive video information:
- Title, channel, description
- Upload date, duration
- Tags, categories
- Transcript/captions (auto-generated or manual)

Explore all available metadata proactively. Use `/tmp/claude/` for any temporary files.

## INFO Callout Fields (Video-Specific)

Videos use these specific fields in the INFO callout:

```markdown
> [!INFO]
> **Source:** <https://youtu.be/VIDEO_ID>
> **Channel:** [Channel Name](https://www.youtube.com/@ChannelHandle)
> **Event:** [[Event Name]] YEAR
> **Speakers:** Speaker names
>
> ![](https://www.youtube.com/watch?v=VIDEO_ID)
```

### Source Field
- Use **short** YouTube URL format: `https://youtu.be/VIDEO_ID`
- Wrap in angle brackets: `<https://youtu.be/VIDEO_ID>`
- Extract VIDEO_ID from any YouTube URL format

### Channel Field
- Extract channel name and URL from video metadata
- Format as markdown link: `[Channel Name](channel-url)`
- Use `@ChannelHandle` format when available

### Event Field
- Extract conference/event name from video title, description, or channel
- Format with backlink: `[[Event Name]] YEAR`
- Examples: `[[GopherCon]] 2024`, `[[Cloud Native Computing Foundation]] InfoQ Webinar`
- If no event detected, remove this line entirely

### Speakers Field
- Extract speaker names from video metadata, description, or title
- List names separated by commas
- If no speakers identified, remove this line entirely

### Video Embed
- Include video embed using full YouTube URL
- Format: `![](https://www.youtube.com/watch?v=VIDEO_ID)`
- This renders as embedded player in Obsidian

## Frontmatter (Video-Specific)

Videos use the `watched` field in frontmatter:

```yaml
---
type: online-resource
watched: # Leave empty initially - user fills after watching
tags: # Suggest tags based on content
---
```

Leave `watched:` field empty (no value). User will fill in date after watching.

## Video Description Section

This section presents the video's content to help the user decide whether to watch and what to look for.

**Strategy:**

1. **If YouTube description is clean and informative:**
   - Start with the original description
   - If description is good but short, add a "Highlights" subsection with key points from transcript

2. **If YouTube description is spammy:**
   - Reconstruct description from the transcript
   - Create an index of main topics, arguments, and notable examples
   - Help user navigate the content

**Requirements:**
- Remove promotions, advertisements, spammy links
- Remove weirdly formatted paragraphs, thank yous, credits, donations
- Focus on content index - what's covered, not a full recap
- Help user decide whether to watch, not replace watching

**Goal**: Create a navigable index of video content that respects the user's time.

## Example Video Note Structure

See `examples/video-skeleton.md` for annotated structure showing:
- How each section should be filled
- What information goes where
- Common patterns and approaches

## Video-Specific Considerations

**Multiple speakers:**
- List all speakers in Speakers field
- If speakers are identified by timestamps in transcript, consider noting key speakers in description

**Event context:**
- Conference talks should always have Event field
- Look for event information in: video title, description, channel name, tags

**Transcript quality:**
- Auto-generated captions may have errors - use judgment when extracting key points
- Manual captions are usually higher quality

**Long videos:**
- For videos >1 hour, consider creating a more detailed content index
- Highlight key segments or chapters if available

**Live streams and premieres:**
- Treat same as regular videos
- Check if description has been updated post-stream with relevant links

## Common Video Mistakes to Avoid

- ❌ Don't include the full transcript in the note (extract key points instead)
- ❌ Don't skip metadata extraction - get comprehensive information
- ❌ Don't forget to check for event information
- ❌ Don't include timestamp spam from descriptions (chapter timestamps are OK if useful)
- ❌ Don't use full YouTube URLs in Source field (use youtu.be short format)
- ❌ Don't include speakers/event fields if not applicable (remove the lines)
