# Changelog

All notable changes to the Obsidian Notes plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-11-18

### YouTube Capture Skill

- Updated template to use INFO callout formatting for better visual organization
- Moved colons inside bold markers for metadata fields (e.g., `**Source:**` instead of `**Source**:`)
- Relocated YouTube embed inside the metadata callout for logical grouping
- Removed redundant horizontal rule separator after metadata section

## [1.0.0] - 2025-11-12

### YouTube Capture Skill

- Initial release with automatic activation
- Vault detection (requires `.obsidian` directory in working directory)
- Metadata extraction using `yt-dlp` (title, channel, description, transcript)
- Dual template strategy: reads from vault's `_templates/YouTube Resource.md` with embedded fallback
- Clean filename generation from video titles
- Structured note creation in `Resources/Videos/` directory
- Personal takeaways generation by learning from existing notes
- Automatic concept backlinking from `Concept/` folder
- Safety constraints: only modifies files in `Resources/Videos/`
- Temporary file cleanup in `/tmp`

### Plugin Infrastructure

- Foundation release establishing plugin architecture for multi-source knowledge capture
- Future skills planned: articles, podcasts, research papers, Twitter threads, books
