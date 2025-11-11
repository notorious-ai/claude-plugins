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

**Note on Marketplaces**: Plugins are distributed through marketplaces in Claude Code. This repository intentionally does not include a marketplace file to maximize composability. Following the Unix philosophy, each plugin has a single purpose. Users can create their own marketplace files to "package" several related plugins into coherent sets, without being burdened by unrelated plugins. This approach keeps the mental load low and makes plugins more effective.

## 🚀 Getting Started

### Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- Familiarity with the Claude Code plugin system and marketplaces

### Installation

To use plugins from this repository, you'll need to create a local marketplace file:

1. **Browse available plugins** in this repository to identify which ones suit your needs

2. **Create a marketplace file** (e.g., `my-marketplace.json`) with your selected plugins:
   ```json
   {
     "name": "My Custom Marketplace",
     "plugins": [
       {
         "name": "plugin-name-1",
         "source": "https://github.com/notorious-ai/claude-plugins.git",
         "path": "plugin-name-1"
       }
     ]
   }
   ```

3. **Register your marketplace** with Claude Code:
   ```bash
   claude marketplace add /path/to/my-marketplace.json
   ```

4. **Browse and install plugins** interactively:
   ```bash
   claude plugin install
   ```

For more details on marketplace configuration, see the [Claude Code settings documentation](https://code.claude.com/docs/en/settings#plugin-configuration).

## 📂 Repository Structure

Each plugin is a standalone directory. See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed plugin structure guidelines.

## 🤝 Contributing

We welcome contributions! Whether you have a new plugin to share, improvements to existing ones, or bug reports, feel free to open an issue or submit a pull request.

For detailed guidelines on plugin structure and development, see [CONTRIBUTING.md](CONTRIBUTING.md).

## 📖 Plugin Philosophy

Our plugins follow the [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy):

1. **Do One Thing Well**: Each plugin has a single, well-defined purpose
2. **Work Together**: Plugins are designed to compose with others through clean interfaces
3. **Handle Text Streams**: Plugins process and generate clear, parseable output
4. **Simple and Transparent**: Clear documentation and straightforward implementations
5. **Evolutionary**: Plugins improve incrementally based on real-world usage

## 🔗 Related Resources

- [Claude Code Plugins Documentation](https://code.claude.com/docs/en/plugins)
- [Plugins Reference](https://code.claude.com/docs/en/plugins-reference)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Go Programming Language](https://go.dev/)

## 🌱 About Emergence

The concept of emergence—where complex patterns arise from simple rules—fascinates us in both natural systems and software architecture. You'll find this philosophy reflected in how our plugins are designed: simple, composable pieces that enable sophisticated workflows.

---

*Built with curiosity and shared with the community.*
