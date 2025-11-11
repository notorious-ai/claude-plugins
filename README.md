# Claude Code Plugins Collection

Welcome! This repository is our collection of Claude Code plugins—standalone configurations that extend Claude Code with custom commands, agents, hooks, Skills, and MCP servers to enhance our daily workflows.

## 🎯 Purpose

As we work across systems architecture, distributed systems, and software engineering, we've found that having the right tools configured for Claude Code dramatically improves productivity. This repository is where we accumulate and share plugins that have proven useful in our work.

## 🔧 Our Tech Stack & Focus Areas

The plugins in this repository reflect our professional focus:

- **Systems Architecture**: Designing scalable, resilient systems
- **Distributed & Event-Driven Systems**: Building reactive, decoupled architectures
- **Go-Centric Development**: Primary language for building robust backend systems
- **Knowledge Access**: Tools and patterns for information retrieval and synthesis
- **Emergence**: Exploring emergent properties in both natural and engineered systems

## 📚 What You'll Find Here

This repository contains individual Claude Code plugins, each as a standalone directory with its own configuration and components.

## 🚀 Getting Started

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- Familiarity with the Claude Code plugin system

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/notorious-ai/claude-plugins.git
   cd claude-plugins
   ```

2. Browse the plugin directories

3. Follow the individual plugin READMEs for specific setup instructions

4. Install plugins locally or add them to your Claude Code configuration

## 📂 Repository Structure

Each plugin is a standalone directory with its own structure:

```
claude-plugins/
├── plugin-name-1/
│   ├── .claude-plugin/
│   │   └── plugin.json      # Plugin manifest (required)
│   ├── commands/            # Custom slash commands (optional)
│   ├── agents/              # Custom agents (optional)
│   ├── skills/              # Autonomous agent skills (optional)
│   ├── hooks/               # Event hooks (optional)
│   ├── .mcp.json            # MCP server config (optional)
│   └── README.md            # Plugin documentation
├── plugin-name-2/
│   └── ...
└── README.md                # This file
```

### Plugin Structure

Each plugin directory contains:
- **`.claude-plugin/plugin.json`**: Required manifest with plugin metadata
- **`commands/`**: Optional directory with markdown files defining custom commands
- **`agents/`**: Optional directory with markdown files defining custom agents
- **`skills/`**: Optional directory with skill definitions
- **`hooks/`**: Optional directory with event hook configurations
- **`.mcp.json`**: Optional MCP server configuration
- **`README.md`**: Documentation for the plugin

## 🤝 Contributing

We welcome contributions from the community:

- **New Plugins**: Share your useful Claude Code plugins
- **Improvements**: Enhance existing plugins with new features or fixes
- **Bug Reports**: If something doesn't work as expected
- **Discussions**: Thoughts on distributed systems, Go patterns, or emergence

Feel free to open an issue or submit a pull request!

## 📖 Plugin Philosophy

Our plugins are designed with several principles in mind:

1. **Composability**: Each plugin works independently and composes well with others
2. **Clarity**: Clear documentation and examples for each plugin
3. **Pragmatism**: Solutions that work in real-world scenarios, not just theory
4. **Evolution**: Plugins evolve as we learn and discover better patterns

## 🔗 Related Resources

- [Claude Code Plugins Documentation](https://code.claude.com/docs/en/plugins)
- [Plugins Reference](https://code.claude.com/docs/en/plugins-reference)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Go Programming Language](https://go.dev/)

## 📝 License

This repository is provided as-is for educational and reference purposes. Individual plugins may have their own licensing requirements—check the specific plugin directories for details.

## 🌱 About Emergence

The concept of emergence—where complex patterns arise from simple rules—fascinates us in both natural systems and software architecture. You'll find this philosophy reflected in how our plugins are designed: simple, composable pieces that enable sophisticated workflows.

---

*Built with curiosity and shared with the community.*
