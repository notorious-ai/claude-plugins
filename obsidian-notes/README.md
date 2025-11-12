# Obsidian Notes Plugin

Capture and structure knowledge from various sources into your Obsidian vault following your personal note-taking system.

## Vision

This plugin provides automated capture skills for different types of content you want to preserve in your personal knowledge base. Each skill understands your note-taking format, extracts relevant metadata, and creates properly structured markdown files in the appropriate directories within your vault.

**Current Skills:**
- **YouTube Videos** - Automatic capture with metadata extraction and transcript analysis

**Planned Skills:**
- **Articles & Blog Posts** - Extract and format articles from URLs with readability parsing
- **Podcasts** - Capture podcast episodes with transcript extraction
- **Research Papers** - Structure research papers with citation management
- **Books & Chapters** - Template-based book and chapter note creation

All skills follow the same philosophy: understand your personal system, extract rich metadata, and create well-structured notes that integrate seamlessly with your existing knowledge base.

## Prerequisites

- **Obsidian vault**: You must run Claude Code from the root directory of your Obsidian vault (the directory containing `.obsidian/`)
- **yt-dlp**: Required for YouTube video capture. Install on macOS via: `brew install yt-dlp`

### Vault Structure

Your vault should have the following structure for this plugin to work optimally:

```
YourVault/
├── .obsidian/              # Obsidian configuration (required)
├── _templates/
│   └── YouTube Resource.md # Your YouTube note template (optional, has fallback)
├── Resources/
│   └── Videos/            # YouTube notes are created here
└── Concept/               # Concept pages for backlinking
```

If directories don't exist, the skill will create them as needed (except `.obsidian` which must exist).

## Current Skills

Always run Claude Code from your Obsidian vault's root directory. The skill automatically discovers concepts from your `Concept/` folder for backlinking, reads existing notes in `Resources/Videos/` to match your personal takeaway style, and you can share multiple YouTube URLs in a single message - each will be captured separately. You can customize the output format by editing `_templates/YouTube Resource.md` in your vault.

### YouTube Video Capture

Automatically captures YouTube videos as structured markdown notes when URLs are detected in conversation.

**Activation**: Mention or paste a YouTube URL while working inside your Obsidian vault.

**What it does**:
1. Validates you're in an Obsidian vault (checks for `.obsidian` directory)
2. Extracts video metadata using `yt-dlp` (title, channel, description, etc.)
3. Downloads and parses video transcript/captions
4. Reads your YouTube Resource template from `_templates/YouTube Resource.md` (or uses embedded fallback)
5. Generates a clean filename from the video title
6. Creates a properly formatted note in `Resources/Videos/` directory
7. Fills all template sections following embedded `<instructions>` precisely
8. Generates personal takeaways by examining your existing notes
9. Creates backlinks to existing concepts in your `Concept/` folder

**Example usage**:

```
You: https://www.youtube.com/watch?v=dQw4w9WgXcQ

Claude: I'll capture this YouTube video as a structured note in your vault.
[Extracts metadata, creates formatted note in Resources/Videos/]
```

**Safety features**:
- Only operates within Obsidian vaults (requires `.obsidian` directory)
- Only creates/modifies files in `Resources/Videos/` directory
- Never touches template files or other vault content
- No temporary files left in working directory

**Template handling**:
- **Primary**: Reads from your vault's `_templates/YouTube Resource.md`
- **Fallback**: Uses embedded template if vault template not found
- This allows you to evolve your template over time while maintaining plugin compatibility

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

To extend this plugin with additional capture skills (articles, podcasts, papers, etc.):

1. Create a new skill directory in `skills/` (e.g., `skills/article-capture/`)
2. Add `SKILL.md` with clear activation conditions and capture logic
3. Include any necessary templates or supporting files
4. Update this README with the new skill documentation
5. Update `CHANGELOG.md`

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines on plugin development.
