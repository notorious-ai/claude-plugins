# Contributing to Claude Code Plugins Collection

Thank you for your interest in contributing! This document provides guidelines for adding new plugins or improving existing ones.

## 🎯 Contribution Guidelines

We welcome several types of contributions:

- **New Plugins**: Share plugins that align with our focus areas (systems architecture, distributed systems, Go development, knowledge access, emergence)
- **Plugin Improvements**: Enhance existing plugins with new features, bug fixes, or better documentation
- **Bug Reports**: Report issues with existing plugins
- **Documentation**: Improve plugin documentation or examples
- **Discussions**: Share ideas, patterns, or best practices

## 📂 Plugin Structure

Each plugin is a standalone directory following the Claude Code plugin standard. Here's the structure:

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
└── LICENSE                  # Plugin-specific license (optional)
```

### Required Files

#### `.claude-plugin/plugin.json`

The plugin manifest contains metadata and configuration:

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "Brief description of what the plugin does",
  "author": {
    "name": "Your Name",
    "email": "your.email@example.com"
  },
  "paths": {
    "commands": "./commands",
    "agents": "./agents",
    "skills": "./skills",
    "hooks": "./hooks"
  }
}
```

#### `README.md`

Each plugin must have a README with:

- Clear description of the plugin's purpose (single responsibility)
- Installation and usage instructions
- Examples demonstrating the plugin in action
- Any dependencies or prerequisites
- Configuration options (if any)

### Optional Components

#### Commands (`commands/`)

Custom slash commands are defined in markdown files:

```markdown
---
description: Brief description of the command
---

# Command Name

Detailed documentation of what the command does and how to use it.

## Usage

Examples and use cases.
```

#### Agents (`agents/`)

Custom agents are defined in markdown files with specific capabilities and context.

#### Skills (`skills/`)

Each skill is a directory containing a `SKILL.md` file that defines the skill's capabilities.

#### Hooks (`hooks/`)

Event hooks are configured in `hooks.json` to trigger actions on specific Claude Code events.

#### MCP Servers (`.mcp.json`)

MCP server configuration for integrating external data sources or tools.

## 🔧 Development Workflow

### Adding a New Plugin

1. **Fork and clone** this repository
2. **Create a new directory** with a descriptive, kebab-case name
3. **Add the required files**:
   - `.claude-plugin/plugin.json`
   - `README.md`
   - Any optional components (commands, agents, skills, hooks)
4. **Test your plugin** locally using Claude Code
5. **Document thoroughly** - include examples and usage instructions
6. **Submit a pull request** with a clear description

### Testing Your Plugin

Test your plugin locally before submitting:

1. Create a local marketplace file pointing to your plugin directory
2. Register the marketplace with Claude Code
3. Install and test the plugin functionality
4. Verify all commands, agents, and features work as expected

See the [Claude Code plugin testing documentation](https://code.claude.com/docs/en/plugins#test-your-plugins-locally) for details.

## 📝 Plugin Design Principles

Follow these principles when creating plugins:

### Unix Philosophy

1. **Do One Thing Well**: Each plugin should have a single, focused purpose
2. **Composability**: Design plugins to work with others through clean interfaces
3. **Simplicity**: Keep implementations straightforward and understandable
4. **Text-Based**: Process and generate clear, parseable output

### Quality Standards

- **Clear naming**: Use descriptive, kebab-case names
- **Good documentation**: Write clear READMEs with examples
- **Error handling**: Provide helpful error messages
- **Performance**: Keep plugins lightweight and efficient
- **Security**: Don't include secrets or credentials

## 🔗 Reference Documentation

- [Claude Code Plugins Overview](https://code.claude.com/docs/en/plugins)
- [Plugins Reference](https://code.claude.com/docs/en/plugins-reference)
- [Plugin Settings](https://code.claude.com/docs/en/settings#plugin-configuration)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Unix Philosophy](https://en.wikipedia.org/wiki/Unix_philosophy)

## 💬 Getting Help

- **Questions**: Open a GitHub issue with the `question` label
- **Bugs**: Open a GitHub issue with the `bug` label
- **Ideas**: Open a GitHub issue with the `enhancement` label
- **Discussions**: Use GitHub Discussions for broader topics

## 📋 Pull Request Process

1. Ensure your plugin follows the structure and principles outlined above
2. Update documentation as needed
3. Test your plugin locally
4. Submit a PR with:
   - Clear title describing the change
   - Description of what the plugin does
   - Any testing you've performed
5. Respond to review feedback

## 🌱 Plugin Ideas

Looking for ideas? Consider plugins for:

- **Go Development**: Testing, benchmarking, linting, refactoring tools
- **Systems Architecture**: Diagram generation, dependency analysis, design pattern helpers
- **Distributed Systems**: Event sourcing, CQRS patterns, resilience testing
- **Knowledge Management**: Documentation generation, cross-referencing, learning aids
- **Emergence**: Pattern detection, complexity analysis, system visualization

---

*Thank you for contributing to our plugin collection!*
