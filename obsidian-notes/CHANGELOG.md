# Changelog

All notable changes to the Obsidian Notes plugin will be documented in this file.

## [3.0.0] - 2025-11-24

### Saving Internet Gems Skill

**NEW**: Unified skill for capturing videos and articles

- Initial release of `saving-internet-gems` skill that unifies video and article capture
- Intent-based activation: only activates when user explicitly requests capture ("save this", "bookmark this", etc.), not on URL presence alone
- Multi-source support: handles YouTube videos and web articles with source-appropriate processing
- Progressive disclosure: guides users through metadata refinement after initial capture
- Tag-based classification: mandatory tagging replaces legacy type field for flexible content organization
- Related Topics section: links to existing vault concepts for knowledge graph integration, avoiding duplicate backlinks for articles
- Personal Takeaways: focuses on insights and learnings derived from content rather than content recaps
- Site field: represents logical brand/publication (e.g., "The Verge"), not domain
- Starred property: enables immediate capture of promising content for later review
- Tag preservation: respects tags already in-use within the vault
- Template structure: separate skeletons for videos (with embed) and articles (text-focused)
- User refinement workflow: allows iterative improvement of Related Topics and other metadata
- Script validation: validates required external tools at skill invocation

### Breaking Changes

**Skill Removed**
- Removed `distilling-video-notes` skill, superseded by the unified `saving-internet-gems` skill
- All video capture functionality preserved and enhanced in the new skill

**Vault Structure Changed**
- Video notes now saved to `Gems/Videos/` instead of `Resources/Videos/`
- Article notes saved to `Gems/Articles/`
- Existing notes in `Resources/Videos/` will not be automatically migrated
- Template system removed: skill now learns from vault environment and respects existing conventions

**Migration**:
- Use the new `saving-internet-gems` skill for all content capture. The activation pattern remains similar but requires explicit capture intent.
- Manually move existing video notes from `Resources/Videos/` to `Gems/Videos/` if you want them in the new location.
- The skill will adapt to your vault's existing structure and conventions without requiring templates.

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
