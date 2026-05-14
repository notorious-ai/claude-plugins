# Claude Code Plugins Collection

A curated collection of Claude Code plugins for systems architecture,
distributed systems, and software engineering workflows. Each plugin is a
standalone, composable tool that extends Claude Code with custom commands,
agents, hooks, and integrations.

## ✨ Available Plugins

- [github-author](github-author/) - Craft effective GitHub PRs and Issues with skills for title conventions and description structure
- [golang-dev](golang-dev/) - Comprehensive Go development experience with skills for committing, documentation, and testing

This collection is growing. To browse available plugins:

```bash
ls -d */
```

Each plugin directory contains:
- `.claude-plugin/plugin.json` - Plugin manifest
- `README.md` - Documentation and usage examples
- Component directories (`commands/`, `agents/`, `skills/`, `hooks/`) as needed

## 🚀 Quick Start

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- Familiarity with Claude Code's plugin system

### Installation

**Simple approach - Register the marketplace:**

```bash
claude plugin marketplace add notorious-ai/claude-plugins
```

Then install individual plugins you need:

```bash
claude plugin install golang-dev@notorious-ai
```

Or browse and install interactively:

```bash
claude plugin
```

**Advanced - Team configuration for selective installation:**

Teams can configure `.claude/settings.json` in their repository to specify which plugins to enable. When team members trust the repository, they'll be prompted to install only the selected plugins:

```json
{
  "extraKnownMarketplaces": {
    "team-tools": {
      "source": {
        "source": "github",
        "repo": "notorious-ai/claude-plugins"
      }
    }
  },
  "enabledPlugins": {
    "developing-go@team-tools": true
  }
}
```

For more details, see the [plugin configuration documentation](https://code.claude.com/docs/en/settings#plugin-configuration).

## 📖 Understanding This Repository

### Design Philosophy

This repository follows the **Unix philosophy**:

- **Do One Thing Well**: Each plugin has a single, focused purpose
- **Composability**: Plugins work together through clean interfaces
- **User Control**: Install only the plugins you need, not the entire collection
- **Simplicity**: Clear documentation and transparent implementations

### User Control and Selective Installation

While this repository provides a marketplace for convenient discovery, you maintain complete control over which plugins you install:

1. **Individual selection**: Install only the plugins you need from our marketplace
2. **Team configuration**: Use settings to pre-select plugin subsets for your team
3. **Maximum flexibility**: Mix and match plugins across multiple marketplaces
4. **Single responsibility**: Each plugin maintains clear boundaries and can be used independently

The marketplace enables easy discovery while preserving your freedom to choose exactly what you need.

### Repository Structure

```
claude-plugins/
├── .claude-plugin/
│   └── marketplace.json  # Repository marketplace
├── README.md             # This file
├── CONTRIBUTING.md       # Plugin development guidelines
├── CLAUDE.md             # Instructions for Claude Code
└── plugin-name/          # Each plugin is a top-level directory
    ├── .claude-plugin/
    │   └── plugin.json   # Plugin manifest
    ├── README.md         # Plugin documentation
    ├── commands/         # Slash commands (optional)
    ├── agents/           # Subagents (optional)
    ├── skills/           # Skills (optional)
    ├── hooks/            # Event hooks (optional)
    └── .mcp.json         # MCP server config (optional)
```

## 🤝 Contributing

We welcome contributions! Whether you have a new plugin to share, improvements
to existing ones, or bug reports:

- Open an issue for bugs, feature requests, or questions
- Submit a pull request for new plugins or enhancements
- See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines on plugin
  structure and development

## 💬 Getting Help

Use GitHub Issues with the appropriate issue type:

- **Bug**: Report issues with existing plugins
- **Feature**: Suggest new plugins or enhancements
- **Task**: Propose improvements to documentation or infrastructure
- **Question Label**: Add the `question` label for questions about plugins or
  usage

## 🔗 Resources

- [Claude Code Plugins Documentation](https://code.claude.com/docs/en/plugins)
- [Plugins Reference](https://code.claude.com/docs/en/plugins-reference)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- Example: [Official Claude Code Plugins](https://github.com/anthropics/claude-code)
- Example: [Official Skills Collection](https://github.com/anthropics/skills)

---

*Built with curiosity and shared with friends.*
