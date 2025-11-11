# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a collection of Claude Code plugins following the Unix philosophy - each plugin does one thing well and composes cleanly with others. The repository serves as a curated collection of plugins focused on systems architecture, distributed systems, Go development, knowledge access, and emergence.

See [README.md](README.md) for full context on purpose, tech stack focus areas, and philosophy.

## Repository Architecture

### Plugin Structure
Each plugin is a standalone top-level directory. See [CONTRIBUTING.md](CONTRIBUTING.md) for complete plugin structure requirements and component details.

### No Marketplace File
This repository intentionally excludes a marketplace file to maximize composability. Users create their own marketplace files to compose selected plugins. See [README.md](README.md) for installation instructions and marketplace configuration.

## Working with Plugins

### Creating a New Plugin
See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Complete development workflow
- Plugin structure requirements
- Testing procedures
- Design principles (Unix philosophy, quality standards)
- Pull request process

### Key Requirements
- Each plugin must have a single, well-defined purpose
- Kebab-case naming for directories
- Required files: `.claude-plugin/plugin.json` and `README.md`
- Optional components: commands, agents, skills, hooks, MCP config

## Git Workflow

When creating commits and PRs:
- Title in IMPERATIVE MOOD starting with a VERB
- Description explains intention, not a commit list
- Focus on how the repository/project changes

## Reference Documentation

- [README.md](README.md) - Repository overview and installation
- [CONTRIBUTING.md](CONTRIBUTING.md) - Plugin development guidelines
- [Claude Code Plugins Documentation](https://code.claude.com/docs/en/plugins)
- [Plugins Reference](https://code.claude.com/docs/en/plugins-reference)
