# Shared Workflow for All Internet Gems

This file contains workflows shared across all gem types. Load this after the type-specific reference.

## Directory Structure

Create notes in the appropriate subdirectory:
- **Videos**: `Gems/Videos/[Title].md`
- **Articles**: `Gems/Articles/[Title].md`

## Filename Generation

Generate clean filenames from content titles:
- Remove special characters (keep alphanumeric, spaces, hyphens)
- Strip metadata patterns like "[Event Name]", "Speaker:", dates in parentheses
- Convert to readable format with proper spacing
- Ensure filename ends with `.md`
- Limit to 200 characters maximum

## Frontmatter Structure

All gems start with YAML frontmatter:

```yaml
---
starred: YYYY-MM-DD  # Today's date when saving
tags:
  - external/video   # OR external/article (MUST be first tag)
  # Additional tags based on content (2-4 suggested)
---
```

**Critical:** First tag MUST be `external/video` or `external/article`.

## Tag Discovery

**Prefer existing vault tags over inventing new ones.**

1. **Discover existing tags:**
   ```bash
   scripts/list-vault-tags.sh
   ```

2. **Match content to existing tags** - prioritize tags already in vault

3. **Suggest 2-4 additional tags** after the mandatory external/* tag

## TL;DR Section Workflow

Write a compelling, punchy summary about WHY this content is valuable.

**Steps:**
1. Read 2-3 existing gems from target directory
2. Analyze user's writing style and tone
3. Identify what the user values and highlights
4. Write 2-3 sentences focusing on:
   - The compelling hook or key insight
   - Unique value proposition
   - NOT a dry summary of coverage
5. Add context sentence:
   - Videos: "Watch again when..."
   - Articles: "Read again when..." or "Send this to a friend who..."

**Keep this section SHORT** - 3-4 sentences total.

For good/bad examples, see `examples/quality-patterns.md`.

## Personal Takeaways Workflow

This section requires understanding user's interests and note-taking patterns.

**Steps:**

1. **Analyze Context**
   - Read 2-3 existing gems from target directory
   - Identify patterns in what user highlights
   - Note recurring themes and interests
   - Understand user's writing style

2. **Generate Suggestions**
   - Generate 3-5 potential takeaways based on content and user patterns
   - Write in FIRST PERSON (I/my) as user's voice
   - Focus on PERSONAL INSIGHTS derived from content, not summaries
   - Express: realizations, connections to own work, discoveries, shifts in thinking

3. **Interactive Refinement**
   - Use AskUserQuestion tool with `multiSelect: true`
   - Present suggestions as selectable options
   - User can select multiple, add custom via "Other", or reject all

4. **Incorporate Feedback**
   - Include all user-selected takeaways
   - Use user's exact wording for custom takeaways
   - If user rejects all, leave section with placeholder note
   - Write in FIRST PERSON (I/my)

**Example AskUserQuestion:**
```
questions: [{
  question: "Which personal takeaways resonate with you?",
  header: "Takeaways",
  multiSelect: true,
  options: [
    { label: "I realized...", description: "Personal insight about..." },
    { label: "This changed how I think about...", description: "Shift in understanding..." },
    { label: "I didn't know...", description: "Discovery that clarifies..." }
  ]
}]
```

For good/bad examples, see `examples/quality-patterns.md`.

## Related Topics Workflow

Discover and create backlinks to relevant pages throughout the vault.

**Steps:**

1. **Identify Top-Level Folders**
   ```bash
   ls -d */
   ```
   Common folders: `Concept/`, `My Tools/`, `My Stack/`, `Books/`, `Bases/`

2. **Search for Relevant Pages**
   - Check `Concept/` for conceptual backlinks
   - Check `My Tools/` for tools mentioned
   - Check `My Stack/` for technologies discussed
   - Match content keywords to page names

3. **Include Platform Reference**
   - Videos: Always include [[YouTube]] (or hosting platform)
   - Articles: Do NOT repeat Site backlink from INFO callout

4. **Format as Bulleted List**
   ```markdown
   ## Related Topics
   - [[Platform Reference]]
   - [[Concept Page]]
   - [[Tool]]
   ```

5. **User Refinement (when needed)**
   - If list exceeds 8 items: ask user to select most relevant
   - If uncertain about relevance: present as options
   - Always retain mandatory platform reference

For good/bad examples, see `examples/quality-patterns.md`.

## Migration Workflow

Triggered by explicit user request: "refresh this note", "migrate to new format", "update this gem"

Use this workflow to update older notes to current format while preserving user content.

**Steps:**

1. **Extract Original Input**
   - Read the existing note
   - Extract Source URL from INFO callout
   - Note current Personal Takeaways (SACRED - preserve user's voice)
   - Note current Related Topics (user-curated backlinks)

2. **Re-run Regular Capture Workflow**
   - Use extracted Source URL as input
   - Follow standard video-capture.md or article-capture.md workflow
   - Generate fresh: INFO callout, TL;DR, Description sections

3. **Merge with Preservation Rules**

   | Section | Preservation Rule |
   |---------|------------------|
   | Frontmatter | Keep existing `starred` date; update tags if new ones relevant |
   | INFO callout | Update to latest format |
   | TL;DR | Merge: keep user's context sentence, refresh summary if better |
   | Description | **MOST FLEXIBLE** - can fully replace with fresh extraction |
   | Personal Takeaways | **SACRED** - preserve exactly, only add if user requests |
   | Related Topics | Keep existing backlinks, suggest additions if discovered |

4. **Present Diff to User**
   - Show what will change
   - Highlight any Personal Takeaways that would be affected
   - Get approval before overwriting
