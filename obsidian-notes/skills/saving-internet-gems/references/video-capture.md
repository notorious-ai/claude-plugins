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
- Remove trailing slashes
- Strip unnecessary query parameters (tracking, referral, etc.)

**Channel:**
- Always a **web link** to the YouTube channel: `[Channel Name](channel-url)`
- This is the online presence, not a vault backlink
- Use `@ChannelHandle` format when available

**Event / Taxonomy:**
- A **vault backlink** to the real-world entity behind the content
- Extract from video title, description, tags, or channel metadata
- Format: `[[Entity Name]] YEAR` (year when relevant)
- Common patterns:
  - Conference talk: `[[GopherCon]] 2024`
  - Organization webinar: `[[Cloud Native Computing Foundation]]`
  - Series: `[[Advent of Code]] 2023`
- If no notable taxonomy detected, REMOVE this line
- Other organizational affiliations can go in Related Topics instead

**Speakers:**
- List names separated by commas
- If no speakers identified, REMOVE this line

**Video Embed:**
- Use full YouTube URL: `![](https://www.youtube.com/watch?v=VIDEO_ID)`
- Always place an empty callout line (`>`) before the embed
- Renders as embedded player in Obsidian

### Channel and Event Serve Different Purposes

- **Channel** = web link to the YouTube presence (always include)
- **Event/Taxonomy** = vault backlink to real-world entity (when applicable)

Both can coexist: a GopherCon talk has Channel (web link to GopherCon's YouTube) AND Event ([[GopherCon]] 2024 backlink). Random YouTubers have only Channel.

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

## Extracting External Links for Further Reading

While processing the video, collect external links the speaker references for the Further Reading subsection (see `references/shared-workflow.md`).

**Where to look:**
- Video description links section
- Pinned comments from the creator
- Links mentioned verbally in the transcript
- Slides (if linked in description)
- "Resources" or "Links" sections in description

**What makes a good Further Reading link:**
- GitHub repositories with code samples from the talk
- Wikipedia pages explaining concepts discussed
- Documentation for tools or libraries demonstrated
- Related talks or videos the speaker recommends
- Blog posts or articles that expand on the topic
- Slides or presentation materials

**Skip:**
- Channel subscription/social media links
- Sponsor links or affiliate URLs
- Generic "follow me" links
- Timestamps (these belong in Description, not Further Reading)

For common mistakes to avoid, see `examples/common-mistakes.md`.
