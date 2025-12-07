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
   find . -name "*.md" -type f -exec yq -f extract '.tags[]' {} \; 2>/dev/null | sort -u
   ```
   If this fails, see `scripts/list-vault-tags.sh` in the skill directory for reference.

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

This section requires understanding user's interests and iterative refinement.

**Steps:**

1. **Analyze Context**
   - Read 2-3 existing gems from target directory
   - Identify patterns in what user highlights
   - Note recurring themes and interests
   - Understand user's writing style

2. **Generate Initial Suggestions**
   - Generate 3-5 potential takeaways based on content and user patterns
   - Write in FIRST PERSON (I/my) as user's voice
   - Focus on PERSONAL INSIGHTS derived from content, not summaries
   - Express: realizations, connections to own work, discoveries, shifts in thinking

3. **First Question**
   - Use AskUserQuestion tool with `multiSelect: true`
   - Present suggestions as selectable options
   - User can select multiple, add custom via "Other", or skip

4. **Interpret Response**
   - Analyze what the user selected - what themes resonate?
   - Parse any custom input - what direction are they taking?
   - Understand the GAP between your suggestions and their actual insights

5. **Iterate (ask again)**
   - REMOVE unselected options (they didn't resonate)
   - KEEP selected options (confirmed)
   - ADD 2-3 NEW options based on user's input direction
   - If user provided custom text, integrate its meaning into new suggestions
   - Ask again with refined options

6. **Repeat Until Done**
   - Continue iterating until user confirms final selection
   - User may signal completion by selecting without adding new input
   - Or explicitly say "done" / "that's all"

7. **Write Final Takeaways**
   - Include all confirmed takeaways
   - Use user's exact wording for custom input
   - Write in FIRST PERSON (I/my)
   - If user rejected all after iterations, leave section with placeholder

**Example Iteration Flow:**

```
Round 1:
  Options: A, B, C, D
  User selects: B, adds custom "Something about X"

Round 2:
  Options: B (kept), E (new, inspired by X), F (new, inspired by X)
  User selects: B, E

Done → Final takeaways: B, E
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

3. **Include Platform Reference (when applicable)**

   **Videos:** Always include [[YouTube]] (or Vimeo, etc.) - the platform is always distinct from Channel identity.

   **Articles:** Include hosting platform ONLY when it's distinct from the Site identity in INFO callout:

   | Scenario | Site (INFO) | Related Topics |
   |----------|-------------|----------------|
   | `medium.com/better-programming/...` | [[Better Programming]] | Include [[Medium]] |
   | `dev.to/author/...` | [[Author]] | Include [[dev.to]] |
   | `bravenewgeek.com/...` | [[Brave New Geek]] | NO platform (standalone) |
   | `go.dev/blog/...` | [[The Go Blog]] | NO [[go.dev]] (same domain) |

   **Key principle:** Don't duplicate Site, but DO note hosting platforms when the content identity differs from the host.

4. **Format as Bulleted List**
   ```markdown
   ## Related Topics
   - [[YouTube]]  <!-- videos: always -->
   - [[Medium]]   <!-- articles: only if hosted, not standalone -->
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
