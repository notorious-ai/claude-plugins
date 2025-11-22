# Obsidian Notes Plugin

Capture and structure knowledge from various sources into your Obsidian vault
following your personal note-taking system.

## Vision

This plugin provides intent-based capture skills for different types of content
you want to preserve in your personal knowledge base:

- **Videos & Articles** - Save online content when you express intent (available)
- **Podcasts** (planned)
- **Research Papers** (planned)

Each skill understands your note-taking format, extracts relevant metadata, and
creates properly structured markdown files in the appropriate directories within
your vault.

## Prerequisites

- **Obsidian vault**: You must run Claude Code from the root directory of your
  Obsidian vault (the directory containing `.obsidian/`)
- **yt-dlp**: Required for YouTube video capture. Install on macOS via: `brew
  install yt-dlp`

### Vault Structure

Your vault should have the following structure for this plugin to work optimally:

```
YourVault/
├── .obsidian/              # Obsidian configuration (automatic)
├── Gems/
│   ├── Videos/             # Video notes are created here
│   └── Articles/           # Article notes are created here
├── Concept/                # Concept pages for backlinking (optional)
├── My Tools/               # Tool pages for backlinking (optional)
├── My Stack/               # Technology pages for backlinking (optional)
└── [Other folders]         # Skill discovers all top-level folders for backlinking
```

If required directories (such as `Gems/Videos/` or `Gems/Articles/`) do not exist, the skill will skip execution for those resources and no notes will be created. The plugin does not create missing directories automatically, and no error message will be shown. Please ensure all required directories exist in your vault before running the skill.

## Skills Definitions

**Usage tips:**
- Always run Claude Code from your Obsidian vault's root directory
- The skill automatically discovers backlink pages from all top-level vault folders
- Existing gems in `Gems/Videos/` and `Gems/Articles/` are analyzed to match your personal style
- You can share multiple URLs in a single message - each will be captured separately
- Express clear intent like "save this", "bookmark this", or "capture this article"

### Saving Internet Gems

**Intent-based capture** for online content (videos and articles) as structured markdown notes.

**Activation**: Express desire to save content combined with a URL. The skill activates when you say things like:
- "Save this video for later"
- "Bookmark this article"
- "Capture this for my vault"
- "Add this to my notes"

**Does NOT activate** on URL presence alone - you must indicate capture intent.

**What it does**:
1. Validates you're in an Obsidian vault (checks for `.obsidian` directory)
2. Detects content type (video vs article, or asks if uncertain)
3. Extracts comprehensive metadata and content:
   - **Videos**: metadata, transcript, channel info using yt-dlp
   - **Articles**: content, author, publication using web extraction
4. Analyzes 2-3 existing gems from target directory to understand your style
5. Creates structured note in `Gems/Videos/` or `Gems/Articles/`
6. Generates compelling TL;DR matching your writing style
7. Creates personal takeaways interactively (presents suggestions, you select)
8. Discovers backlinks across all top-level vault folders (Concept/, My Tools/, My Stack/, etc.)

**Example usage**:

```
You: Save this for later: https://www.youtube.com/watch?v=abc123

Claude: I'll capture this YouTube video as a structured note in your Gems/Videos/ directory.
[Extracts metadata, analyzes your style, creates formatted note]
```

```
You: Bookmark this article: https://blog.example.com/great-post

Claude: I'll capture this article as a structured note in your Gems/Articles/ directory.
[Extracts content, matches your style, creates formatted note]
```

**Safety features**:
- Only operates within Obsidian vaults (requires `.obsidian` directory)
- Only creates/modifies files in `Gems/Videos/` and `Gems/Articles/` directories
- Never touches other vault files
- Intent-based activation prevents unwanted captures during casual URL sharing

## Development & Testing

To test this plugin locally during development:

1. **Create development marketplace** at the repository root:

```json
{
  "name": "dev-marketplace",
  "owner": {
    "name": "Developer"
  },
  "plugins": [
    {
      "name": "obsidian-notes",
      "source": "./obsidian-notes"
    }
  ]
}
```

2. **Register the marketplace**:
```bash
claude plugin marketplace add ./dev-marketplace.json
```

3. **Install the plugin**:
```bash
claude plugin install obsidian-notes@dev-marketplace
```

4. **Test the skill**:
   - Navigate to your Obsidian vault root (must contain `.obsidian` directory)
   - Start a new Claude Code session
   - Share a YouTube URL and watch the skill activate

5. **Iterate on changes**:
```bash
claude plugin uninstall obsidian-notes@dev-marketplace
claude plugin install obsidian-notes@dev-marketplace
```

6. **Clean up when done**:
```bash
claude plugin marketplace remove dev-marketplace
```

### Adding New Skills

To extend this plugin with additional capture skills (articles, podcasts,
papers, etc.):

1. Create a new skill directory in `skills/` (e.g., `skills/article-capture/`)
2. Add `SKILL.md` with clear activation conditions and capture logic
3. Include any necessary templates or supporting files
4. Update this README with the new skill documentation
5. Update `CHANGELOG.md`

See [CONTRIBUTING.md](/CONTRIBUTING.md) for detailed guidelines on plugin
development.
