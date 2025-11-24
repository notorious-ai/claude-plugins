# Shared Conventions for All Internet Gems

This file contains conventions shared across all gem types (videos and articles). Load this file for every gem capture.

## Directory Structure

Create notes in the appropriate subdirectory based on content type:
- **Videos**: `Gems/Videos/[Title].md`
- **Articles**: `Gems/Articles/[Title].md`

## Safety Rules

**CRITICAL - NEVER VIOLATE:**
- Only create or modify files within `Gems/Videos/` and `Gems/Articles/` directories
- Never modify files outside Gems/
- Never edit template files or other vault files
- Each URL capture creates exactly ONE file in the appropriate Gems/ subdirectory
- If a file already exists for the same URL, may update only that specific file

## Filename Generation

Generate clean filenames from content titles:
- Remove special characters (keep alphanumeric, spaces, hyphens)
- Strip metadata patterns like "[Event Name]", "Speaker:", dates in parentheses
- Convert to readable format with proper spacing
- Ensure filename ends with `.md`
- Limit to reasonable filesystem constraints (max 200 characters)

## Frontmatter Structure

All gems start with YAML frontmatter:

```yaml
---
starred: # Fill with today's date when saving (format: YYYY-MM-DD)
tags:
  - external/video    # For videos (mandatory, must be first tag)
  - external/article  # For articles (mandatory, must be first tag)
  # Additional tags based on content analysis (2-4 suggested)
---
```

**Critical:** The first tag MUST be either `external/video` or `external/article` depending on content type.

### Tag Selection

**Prefer existing vault tags over inventing new ones.**

1. **Discover existing tags:**
   ```bash
   scripts/list-vault-tags.sh
   ```
   This returns all unique tags used throughout the vault.

2. **Match content to existing tags:**
   - Review the tag list for relevant matches
   - Prioritize tags that already exist in the vault
   - Only suggest new tags when no existing tag fits

3. **Suggest 2-4 additional tags** after the mandatory external/* tag

## INFO Callout Format

All gems use an INFO callout at the top with metadata. The specific fields vary by content type:

```markdown
> [!INFO]
> **Source:** <short-url>
> **Channel/Site:** [[Referenced Page]]
> **Additional fields vary by content type**
```

- **Source**: Short URL wrapped in angle brackets
- **Channel/Site**: Link to referenced page in vault (create backlink using [[brackets]])
- Content-specific fields documented in video-specifics.md and article-specifics.md

## TL;DR Section

Write a compelling, punchy summary that speaks directly to the user about WHY they should consume this content.

**Process:**
1. Read 2-3 existing gems from the target directory (Gems/Videos/ or Gems/Articles/)
2. Analyze user's writing style and tone
3. Identify what the user values and highlights
4. Write 2-3 sentences focusing on:
   - The compelling hook or key insight
   - Unique value proposition
   - NOT a dry summary of what's covered

**Follow with context sentence:**
- Videos: "Watch again when..." describing situations where this would be valuable
- Articles: "Read again when..." or "Send this to a friend who..." describing relevance

**Keep this section SHORT** - 3-4 sentences total. Think hard about what makes this content valuable to the user.

## Personal Takeaways Section

This section requires understanding the user's interests and note-taking patterns.

**Workflow:**

1. **Analyze Context**
   - Read 2-3 existing gems from the target directory
   - Identify patterns in what user highlights and finds important
   - Note recurring themes and interests
   - Understand user's writing style for takeaways

2. **Generate Suggestions**
   - Based on content analysis and user patterns, generate 3-5 potential takeaways
   - Each takeaway should be written in FIRST PERSON (I/my) as the user's voice
   - Focus on PERSONAL INSIGHTS derived from the content, not summaries of what the content says
   - Each takeaway should express:
     - Personal realizations or shifts in thinking ("I realized...", "This changed how I think about...")
     - Connections the user made to their own work/experience ("I've been doing X wrong...", "I hadn't considered...")
     - Discoveries or aha moments ("I didn't know...", "This explains why...")
     - Can be general reflections, not necessarily actionable items
   - ❌ WRONG: "Notice how this pattern solves X" (describes content)
   - ❌ WRONG: "Consider applying Y to your work" (advice to user)
   - ✅ RIGHT: "I realized I've been missing X in my own services" (personal insight)
   - ✅ RIGHT: "This changed how I think about Y" (shift in thinking)

3. **Interactive Refinement**
   - Use AskUserQuestion tool to present suggestions for review
   - Format each as a selectable option with description explaining why it's valuable
   - Use `multiSelect: true` to allow selecting multiple takeaways
   - User can select multiple, add custom via "Other", or reject all

4. **Incorporate Feedback**
   - Include all user-selected takeaways in note
   - Use user's exact wording if they provide custom takeaways
   - If user rejects all, leave section with placeholder note
   - Write selected takeaways in FIRST PERSON (I/my) as user's personal voice

**Example AskUserQuestion usage:**
```
questions: [{
  question: "Which personal takeaways resonate with you for this content?",
  header: "Takeaways",
  multiSelect: true,
  options: [
    {
      label: "I realized I've been [specific realization about own work/thinking]",
      description: "Personal insight connecting content to your [domain/experience]"
    },
    {
      label: "This changed how I think about [concept] - I hadn't considered [new perspective]",
      description: "Shift in understanding that relates to your interest in [theme]"
    },
    {
      label: "I didn't know [discovery] - this explains why [connection to past experience]",
      description: "Aha moment that clarifies something you've encountered"
    },
    // ... 3-5 total suggestions
  ]
}]
```

## Related Topics Section

Discover and create backlinks to relevant pages throughout the vault.

**Process:**

1. **Identify Top-Level Folders**
   - List all directories at vault root: `ls -d */ .obsidian`
   - Filter out `.obsidian` directory
   - Common folders: `Concept/`, `My Tools/`, `My Stack/`, `Books/`, `Bases/`, etc.

2. **Search for Relevant Pages**
   - For each top-level folder, look for pages that relate to the content
   - Check `Concept/` for conceptual backlinks (e.g., [[Golang]], [[Distributed Systems]])
   - Check `My Tools/` for tools mentioned in content
   - Check `My Stack/` for technologies discussed
   - Check other folders as appropriate

3. **Include Platform Reference (Use Discretion)**
   - Videos: Always include [[YouTube]] (or other hosting platform like Vimeo)
   - Articles: Only include platform reference for hosting sites like [[Medium]]
     - Do NOT repeat the site link for regular articles - it's already in the INFO callout above
     - Regular article sites (blogs, documentation, personal sites) don't need duplication
     - Only include hosting platforms where multiple different publications/authors are hosted

4. **Add Related Resources**
   - Backlink to related gems if relevant
   - Include external links to wikis, blogs, documentation mentioned in content
   - Optionally repeat important backlinks from above sections

5. **Format as Bulleted List**
   ```markdown
   ## Related Topics
   - [[Platform Reference]]  # Only for hosting platforms (YouTube, Medium, etc.)
   - [[Concept Page 1]]
   - [[Concept Page 2]]
   - [[My Tool]]
   - [[Related Gem]]
   - External link: https://example.com
   ```

**Discovery Strategy:**
- Use `ls` to discover folder names dynamically
- Use `ls` or `find` to list pages within relevant folders
- Match content keywords to page names
- Be thorough but selective - only include genuinely relevant links

6. **User Refinement (when needed)**

   Use the user as a refinement tool to improve quality, not as a verification gate.

   **Invoke AskUserQuestion when:**
   - Discovered list exceeds 8 items → present all candidates, ask user to select most relevant
   - Uncertain about specific backlink relevance → present uncertain items as options
   - Multiple candidate pages for same concept → ask which connection is strongest

   **After user input:**
   - Include all selected items in final list
   - Add any custom backlinks provided via "Other"
   - Always retain mandatory items (platform reference) even if not selected

## Common Mistakes to Avoid

**TL;DR Section:**
- ❌ Don't write generic summaries - make it compelling and personal
- ❌ Don't be comprehensive - be punchy and focused on value
- ❌ Don't skip the "Watch/Read again when..." context sentence

**Personal Takeaways:**
- ❌ Don't write generic takeaways without analyzing existing notes first
- ❌ Don't skip the interactive refinement step
- ❌ Don't describe what the content says - focus on personal insights derived FROM it
- ❌ Don't write in second person (you/your) or third person - use first person (I/my)

**Related Topics:**
- ❌ Don't limit backlink search to just `Concept/` folder
- ❌ Don't repeat article site backlinks (already in INFO callout) - only include hosting platforms
- ❌ Don't include every possible link - be selective and relevant

**General:**
- ❌ Don't include promotional content, ads, or spam in any section
- ❌ Don't modify files outside `Gems/` directories
- ❌ Don't create files with overly long filenames (>200 chars)
- ❌ Don't skip validation steps
