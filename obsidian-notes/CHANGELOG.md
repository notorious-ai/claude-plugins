# Changelog

All notable changes to the Obsidian Notes plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-12

### Added

- Initial release of Obsidian Notes plugin
- YouTube Video Capture skill with automatic activation
- Vault detection (requires `.obsidian` directory in working directory)
- Metadata extraction using `yt-dlp` (title, channel, description, transcript)
- Dual template strategy: reads from vault's `_templates/YouTube Resource.md` with embedded fallback
- Clean filename generation from video titles
- Structured note creation in `Resources/Videos/` directory
- Personal takeaways generation by learning from existing notes
- Automatic concept backlinking from `Concept/` folder
- Safety constraints: only modifies files in `Resources/Videos/`
- Temporary file cleanup in `/tmp`

### Notes

- This is the foundation release establishing the plugin architecture for multi-source knowledge capture
- Future skills planned: articles, podcasts, research papers, Twitter threads, books
