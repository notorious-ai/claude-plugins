# Changelog

All notable changes to the Obsidian Notes plugin will be documented in this file.

## [Unreleased]

### Distilling Video Notes Skill

**BREAKING CHANGE**: Skill removed

- Removed `distilling-video-notes` skill as it has been replaced by the unified `saving-internet-gems` skill
- The new unified skill handles both videos and articles with better intent detection and progressive disclosure

## [2.0.0] - 2025-11-19

### Distilling Video Notes Skill (formerly YouTube Capture)

**BREAKING CHANGE**: Skill renamed from `youtube-capture` to `distilling-video-notes`

- Renamed skill from `youtube-capture` to `distilling-video-notes` to better reflect its purpose of distilling and structuring video knowledge
- Updated file path reference to use relative path (`template.md`) following skill best practices
- All functionality remains identical; only the skill name has changed

**Migration**: If you have local configurations or references to the old skill name, update them to `distilling-video-notes`.

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
