# Claude Code Plugins Collection

A curated collection of Claude Code plugins for systems architecture,
distributed systems, and software engineering workflows. Each plugin is a
standalone, composable tool that extends Claude Code with custom commands,
agents, hooks, and integrations.

## ✨ Available Plugins

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

Since this repository follows a composable design (no bundled marketplace), you
choose exactly which plugins you want:

1. **Browse the repository** to find plugins that match your needs

2. **Create your own marketplace file** (e.g., `my-marketplace.json`):
   ```json
   {
     "name": "my-marketplace",
     "plugins": [
       {
         "name": "plugin-name",
         "source": "https://github.com/notorious-ai/claude-plugins.git",
         "path": "plugin-name"
       }
     ]
   }
   ```

3. **Register your marketplace**:
   ```bash
   claude marketplace add /path/to/my-marketplace.json
   ```

4. **Install plugins interactively**:
   ```bash
   claude plugin install
   ```

For more details, see the [Claude Code settings documentation](https://code.claude.com/docs/en/settings#plugin-configuration).

## 📖 Understanding This Repository

### Design Philosophy

This repository follows the **Unix philosophy**:

- **Do One Thing Well**: Each plugin has a single, focused purpose
- **Composability**: Plugins work together through clean interfaces
- **User Control**: No bundled marketplace means you select only what you need
- **Simplicity**: Clear documentation and transparent implementations

### Why No Marketplace File?

Most plugin repositories bundle a marketplace file that installs all plugins
together. We deliberately don't do this because:

1. **Lower cognitive load**: Only install plugins you actually need
2. **Maximum flexibility**: Mix and match plugins across repositories
3. **Single responsibility**: Each plugin maintains clear boundaries
4. **Custom combinations**: Create your own "plugin packs" via marketplace files

This keeps plugins focused and users in control.

### Repository Structure

```
claude-plugins/
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
