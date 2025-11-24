# Video Capture Details

This file extends the workflow in SKILL.md with video-specific details. Load this when capturing video content (YouTube, Vimeo, etc.).

## Video Metadata Extraction

Use yt-dlp or similar tools to extract comprehensive video information:
- Title, channel, description
- Upload date, duration
- Tags, categories
- Transcript/captions (auto-generated or manual)

Explore all available metadata proactively. Use `/tmp/claude/` for any temporary files.

## INFO Callout Fields

Videos use these fields in the INFO callout:

```markdown
> [!INFO]
> **Source:** <https://youtu.be/VIDEO_ID>
> **Channel:** [Channel Name](https://www.youtube.com/@ChannelHandle)
> **Event:** [[Event Name]] YEAR
> **Speakers:** Speaker names
>
> ![](https://www.youtube.com/watch?v=VIDEO_ID)
```

### Field Details

**Source:**
- Prefer short YouTube URL format: `https://youtu.be/VIDEO_ID`
- Wrap in angle brackets: `<https://youtu.be/VIDEO_ID>`

**Channel:**
- Format as markdown link: `[Channel Name](channel-url)`
- Use `@ChannelHandle` format when available

**Event:**
- Extract from video title, description, or channel
- Format with backlink: `[[Event Name]] YEAR`
- If no event detected, REMOVE this line

**Speakers:**
- List names separated by commas
- If no speakers identified, REMOVE this line

**Video Embed:**
- Use full YouTube URL: `![](https://www.youtube.com/watch?v=VIDEO_ID)`
- Renders as embedded player in Obsidian

### Channel vs Event (Mutually Exclusive in Practice)

- **Conference talks**: Have Event field, may omit Channel
- **YouTube channel videos**: Have Channel field, typically no Event
- Include both only when genuinely applicable

## Video Description Strategy

This section presents video content to help user decide whether to watch.

**Strategy 1: If YouTube description is clean and informative**
- Start with original description
- If short, add "Highlights" subsection with key points from transcript

**Strategy 2: If YouTube description is spammy**
- Reconstruct from transcript
- Create index of main topics and arguments
- Help user navigate the content

**Requirements:**
- Remove promotions, ads, spammy links
- Remove thank yous, credits, donations, weird formatting
- Focus on content index - what's covered, not full recap
- Help user decide whether to watch, not replace watching

**Goal**: Navigable index that respects user's time.

## Video-Specific Considerations

**Multiple speakers:**
- List all in Speakers field
- Note key speakers in description if identified by timestamps

**Event context:**
- Conference talks should always have Event field
- Look in: video title, description, channel name, tags

**Transcript quality:**
- Auto-generated captions may have errors
- Manual captions are usually higher quality

**Long videos (>1 hour):**
- Create more detailed content index
- Highlight key segments or chapters if available

**Live streams and premieres:**
- Treat same as regular videos
- Check if description updated post-stream

For common mistakes to avoid, see `examples/common-mistakes.md`.
