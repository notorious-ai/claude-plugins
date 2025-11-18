# Contributing to Claude Code Plugins Collection

Thank you for your interest in contributing! This document provides guidelines
for adding new plugins or improving existing ones.

## 🎯 Contribution Guidelines

We welcome several types of contributions:

- **New Plugins**: Share plugins that align with our focus areas in
  [README.md](README.md)
- **Plugin Improvements**: Enhance existing plugins with new features, bug
  fixes, or better documentation
- **Bug Reports**: Report issues with existing plugins
- **Documentation**: Improve plugin documentation or examples

## 📂 Plugin Structure

Each plugin is a standalone directory following the Claude Code [plugin
directory structure][structure-docs]. Here's the basic layout:

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (required)
├── commands/                # Custom slash commands (optional)
│   └── command-name.md
├── agents/                  # Custom agents (optional)
│   └── agent-name.md
├── skills/                  # Autonomous agent skills (optional)
│   └── skill-name/
│       └── SKILL.md
├── hooks/                   # Event hooks (optional)
│   └── hooks.json
├── .mcp.json                # MCP server config (optional)
├── README.md                # Plugin documentation (required)
└── CHANGELOG.md             # Version history (optional)
```

The plugin manifest (`.claude-plugin/plugin.json`) contains metadata and
configuration following the [plugin manifest schema][manifest-schema]. Here's a
minimal example:

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "Brief description of what the plugin does",
  "paths": {
    "commands": "./commands",
    "agents": "./agents",
    "skills": "./skills",
    "hooks": "./hooks"
  }
}
```

Each plugin must have a `README.md` documenting its purpose, usage with
examples, and any dependencies or configuration options.

This repository's files are configured to help Claude Code generate plugin
directories and components following our conventions.

Plugins can include any combination of these optional components:

- **[Slash commands][commands-docs]** (`commands/`) - Command development
  details (instruction files)
- **[Subagents][agents-docs]** (`agents/`) - Agent configuration and
  capabilities (instruction files)
- **[Agent Skills][skills-docs]** (`skills/`) - Extend Claude's capabilities
  (directory containing `SKILL.md`)
- **[Hooks][hooks-docs]** (`hooks/`) - React to specific Claude Code events
  automatically (configured in `hooks.json`)
- **[MCP servers][mcp-docs]** (`.mcp.json`) - Integrate external data sources
  or tools

## 🔧 Development Workflow

### Adding a New Plugin

1. **Fork and clone** this repository
2. **Create a kebab-case directory** with your plugin name
3. **Add required files**: `.claude-plugin/plugin.json` and `README.md`
4. **Add optional components** as needed: commands, agents, skills, hooks, MCP config
5. **Update `.claude-plugin/marketplace.json`** to include your plugin:
   ```json
   {
     "name": "your-plugin-name",
     "source": "./your-plugin-name"
   }
   ```
6. **Update the repository README** to add your plugin to the "Available Plugins" section
7. **Test your plugin** locally (see Testing section below)
8. **Submit a pull request** following the guidelines below

### Testing Your Plugin

Test your plugin locally before submitting:

1. Create a local marketplace file pointing to your plugin directory
2. Register the marketplace with Claude Code
3. Install and test the plugin functionality
4. Verify all commands, agents, and features work as expected

See the [Claude Code plugin testing documentation](https://code.claude.com/docs/en/plugins#test-your-plugins-locally) for details.

## 📝 Plugin Design Principles

Follow these principles when creating plugins:

1. **Do One Thing Well**: Each plugin should have a single, focused purpose
2. **Composability**: Design plugins to work with others through clean interfaces
3. **Simplicity**: Keep implementations straightforward and understandable
4. **Text-Based**: Process and generate clear, parseable output
5. **Clear Naming**: Use descriptive, kebab-case names
6. **Well-Documented**: Write clear READMEs with examples
7. **Lightweight**: Keep plugins efficient and performant

## 📋 Pull Request Guidelines

When submitting a pull request:

- **Title in IMPERATIVE MOOD** starting with a verb describing what the plugin
  does, not what you're adding to the repository. The title should capture the
  plugin's capability and naturally indicate its primary component type or
  interaction model.

  Examples:
  - "Analyze distributed tracing context autonomously" (includes agents)
  - "Visualize Go test coverage with commands" (includes commands)
  - "Validate event streaming patterns via hooks" (includes hooks)
  - "Generate system architecture documentation" (general capability, may include multiple components)
  - "Analyze Go concurrency patterns as skills" (includes skills)

  Notice how the component type emerges naturally: "autonomously" suggests
  agents, "with commands" indicates slash commands, "via hooks" signals event
  hooks, and "as skills" denotes autonomous skills. Plugins may include
  multiple component types to deliver their capabilities.

- **Description explains the plugin's purpose and value**, not a list of commits
  - Why this plugin is useful, what problem it solves, how it fits our focus areas

- **Ensure your plugin follows the structure and principles outlined above**

- **Update both `.claude-plugin/marketplace.json` and repository README** to include your new plugin

- **Test your plugin locally** before submitting

## 🔗 Reference Documentation

- [Plugins Reference](https://code.claude.com/docs/en/plugins-reference)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Unix Philosophy](https://en.wikipedia.org/wiki/Unix_philosophy)

---

*Thank you for contributing to our plugin collection!*

[plugins-docs]: https://code.claude.com/docs/en/plugins
[marketplaces-docs]: https://code.claude.com/docs/en/plugin-marketplaces
[commands-docs]: https://code.claude.com/docs/en/slash-commands
[agents-docs]: https://code.claude.com/docs/en/sub-agents
[skills-docs]: https://code.claude.com/docs/en/skills
[hooks-docs]: https://code.claude.com/docs/en/hooks
[mcp-docs]: https://code.claude.com/docs/en/mcp
[settings-docs]: https://code.claude.com/docs/en/settings
[structure-docs]: https://code.claude.com/docs/en/plugins-reference#plugin-directory-structure
[manifest-schema]: https://code.claude.com/docs/en/plugins-reference#plugin-manifest-schema
