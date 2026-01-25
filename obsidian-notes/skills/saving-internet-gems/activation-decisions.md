# Activation Decisions

This file provides a corpus of positive and negative activation examples to help Claude make better decisions about when to activate the saving-internet-gems skill.

## Positive Examples (ACTIVATE)

### Example 1: Clear capture intent with video URL
**User message:** "Save this video for me: https://youtube.com/watch?v=abc123"

**Decision:** ACTIVATE

**Reasoning:** Clear capture intent ("Save this") + YouTube URL + (verify .obsidian exists)

---

### Example 2: Bookmark intent with article
**User message:** "Bookmark this article about Go concurrency https://blog.golang.org/concurrency-is-not-parallelism"

**Decision:** ACTIVATE

**Reasoning:** "Bookmark" expresses capture intent + article URL + (verify .obsidian exists)

---

### Example 3: Note-taking intent
**User message:** "Take notes on this talk: https://youtu.be/XYZ789"

**Decision:** ACTIVATE

**Reasoning:** "Take notes on" is capture intent + YouTube URL + (verify .obsidian exists)

---

### Example 4: Add to vault intent
**User message:** "Add this to my vault https://medium.com/@author/great-article-123"

**Decision:** ACTIVATE

**Reasoning:** "Add to vault" is explicit capture intent + article URL + (verify .obsidian exists)

---

### Example 5: Implicit capture with context
**User message:** "This is a great video, capture it: https://vimeo.com/12345"

**Decision:** ACTIVATE

**Reasoning:** "Capture it" is capture intent + Vimeo URL + (verify .obsidian exists)

---

### Example 6: Refresh/migrate existing note
**User message:** "Refresh this note to the latest format" (while viewing an existing gem file)

**Decision:** ACTIVATE

**Reasoning:** "Refresh" triggers migration workflow for existing gem files

---

## Negative Examples (DO NOT ACTIVATE)

### Example 1: Discussion intent
**User message:** "What do you think about this video? https://youtube.com/watch?v=abc123"

**Decision:** DO NOT ACTIVATE

**Reasoning:** User wants discussion/analysis, not capture. "What do you think" is inquiry, not save intent.

---

### Example 2: Summary request
**User message:** "Can you summarize this article for me? https://example.com/article"

**Decision:** DO NOT ACTIVATE

**Reasoning:** User wants a summary in the conversation, not a vault note. No capture intent expressed.

---

### Example 3: URL sharing without intent
**User message:** "Check out https://youtube.com/watch?v=xyz"

**Decision:** DO NOT ACTIVATE

**Reasoning:** URL presence alone is not sufficient. No capture intent expressed.

---

### Example 4: Technical help with URL
**User message:** "This video shows the error I'm getting https://youtu.be/error123"

**Decision:** DO NOT ACTIVATE

**Reasoning:** User is sharing context for debugging, not requesting capture.

---

### Example 5: Outside Obsidian vault
**User message:** "Save this video: https://youtube.com/watch?v=abc123"
**Context:** Working directory does NOT contain `.obsidian`

**Decision:** DO NOT ACTIVATE

**Reasoning:** All three conditions must be met. Missing `.obsidian` directory means this is not an Obsidian vault.

---

### Example 6: Information request about content
**User message:** "Is this article still relevant? https://blog.example.com/old-post"

**Decision:** DO NOT ACTIVATE

**Reasoning:** User wants evaluation/opinion, not capture.

---

## Edge Cases

### Edge Case 1: Ambiguous intent
**User message:** "I like this https://youtube.com/watch?v=good-video"

**Decision:** DO NOT ACTIVATE (or ASK for clarification)

**Reasoning:** Expression of preference is not capture intent. If context suggests capture might be wanted, ask: "Would you like me to save this video to your vault?"

---

### Edge Case 2: Multiple URLs
**User message:** "Save these videos: https://youtu.be/video1 and https://youtu.be/video2"

**Decision:** ACTIVATE (handle sequentially)

**Reasoning:** Clear capture intent applies to multiple URLs. Process each URL separately, creating two gem files.

---

### Edge Case 3: Mixed intent
**User message:** "What's this video about and save it too https://youtube.com/watch?v=mixed"

**Decision:** ACTIVATE (and answer question)

**Reasoning:** Multiple intents can coexist. Address the question AND capture the video.

---

### Edge Case 4: Partial vault setup
**User message:** "Save this: https://article.com/post"
**Context:** `.obsidian` exists but `Gems/` directory doesn't

**Decision:** ACTIVATE (create Gems/ directory)

**Reasoning:** Valid vault (has .obsidian), but missing output directory. Create `Gems/Articles/` as needed.

---

### Edge Case 5: Unknown content type
**User message:** "Save this: https://some-unknown-site.com/content"

**Decision:** ACTIVATE with user confirmation

**Reasoning:** Clear capture intent + URL + vault present. Use AskUserQuestion to confirm if this is a video or article.

---

### Edge Case 6: File operation without URL
**User message:** "Update this gem to the latest format" (with cursor in a Gems/ file)

**Decision:** ACTIVATE migration workflow

**Reasoning:** "Update" intent on existing gem file triggers migration, not new capture. Extract URL from existing file.

---

## Decision Framework

When evaluating whether to activate:

1. **Check capture intent keywords:**
   - YES: save, bookmark, capture, add to vault, take notes on, refresh, migrate, update (existing gem)
   - NO: summarize, explain, what do you think, check out, is this...?

2. **Verify URL presence:**
   - Must contain a URL (any format)
   - URL type determines video vs article routing

3. **Confirm Obsidian environment:**
   - `.obsidian` directory must exist in working directory
   - If missing, inform user skill only works from vault root

4. **Handle ambiguity:**
   - When intent is unclear, ask for clarification
   - When content type is unclear, ask user to choose
