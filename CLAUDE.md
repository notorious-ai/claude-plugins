# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Navigation

### Understanding This Repository's Structure

This repository uses a **flat structure** where each top-level directory represents a single, standalone plugin. There is no nesting, categorization, or marketplace file - every plugin directory sits at the root level.

**To browse available plugins:**
```bash
ls -d */
```

Each plugin directory contains its own `.claude-plugin/plugin.json` manifest, `README.md`, and optional component directories (commands, agents, skills, hooks, MCP config).

### Finding Examples

**Official Reference Repositories:**
- [anthropics/claude-code](https://github.com/anthropics/claude-code) - Official Claude Code plugins
- [anthropics/skills](https://github.com/anthropics/skills) - Official Skills collection

**Note:** These official repositories use `.claude-plugin/marketplace.json` to organize their plugins. You'll need to parse the marketplace file to understand their structure and locate individual plugins, unlike this repository's simpler flat approach.

**To explore plugins in this repository:**
1. **Browse plugin directories** at the root level
2. **Read plugin READMEs** to understand their purpose and capabilities
3. **Examine component directories** within plugins:
   - `commands/` - Slash command instruction files
   - `agents/` - Subagent configuration files
   - `skills/` - Skill directories with `SKILL.md`
   - `hooks/` - Event hook configurations
   - `.mcp.json` - MCP server configurations

## Planning a New Plugin

### IMPORTANT: Always Plan Before Creating

When a user requests a new plugin, **ALWAYS** start with planning. Never immediately create files. Follow this process:

1. **Understand the Request**
   - What problem does this plugin solve?
   - What capabilities should it provide?
   - What are the expected inputs and outputs?

2. **Ask Clarifying Questions**

   Use the AskUserQuestion tool to refine the plugin's purpose:
   - What is the single, focused purpose of this plugin? (Unix philosophy: do one thing well)
   - Which component types would best deliver this capability? (commands, agents, skills, hooks, MCP)
   - Are there dependencies on external tools or services?
   - What should the plugin be named? (kebab-case)
   - Should this integrate with existing plugins?

### Component Selection Guide

When planning which component types to use, consider these guidelines:

**[Slash Commands][commands-docs]** - Use when you want to:
- Provide quick, user-triggered actions
- Execute specific, bounded tasks on-demand
- Offer convenient shortcuts for common operations
- Example: `/lint-go` to run Go linting, `/visualize-coverage` to show test coverage

**[Subagents][agents-docs]** - Use when you want to:
- Perform autonomous, multi-step tasks
- Make decisions and adapt based on context
- Handle complex workflows requiring reasoning
- Example: Analyze distributed tracing spans autonomously, debug issues independently

**[Agent Skills][skills-docs]** - Use when you want to:
- Extend Claude's base capabilities with domain expertise
- Provide reusable, composable abilities
- Enable specialized knowledge or patterns
- Example: Go concurrency pattern analysis, system architecture validation

**[Hooks][hooks-docs]** - Use when you want to:
- React automatically to Claude Code events
- Validate, transform, or augment operations
- Enforce policies or run checks
- Example: Validate event schema before commits, auto-format on file save

**[MCP Servers][mcp-docs]** - Use when you want to:
- Integrate external data sources or APIs
- Provide tools for accessing external systems
- Bridge Claude Code with other services
- Example: Fetch metrics from observability platform, query architecture diagrams

**Combining Components**: A single plugin can use multiple component types to deliver its capabilities. Plan which components work together to achieve the plugin's single, focused purpose.

3. **Ensure Single Responsibility**

   If the plugin tries to do multiple unrelated things, help the user break it into separate plugins. Each plugin should have one clear purpose.

4. **Create a Plan**

   Present a clear plan including:
   - Plugin name and description
   - Primary component types to be used
   - Directory structure
   - Key files to be created
   - Any external dependencies

5. **Get Approval**

   Wait for user approval before proceeding to the Creation Phase.

## Creating a New Plugin

### Step 1: Create Plugin Directory

Create a top-level directory with your plugin name in kebab-case:

```bash
mkdir plugin-name
cd plugin-name
```

### Step 2: Create Plugin Manifest

Create `.claude-plugin/plugin.json` following the [plugin manifest schema][manifest-schema]:

```bash
mkdir .claude-plugin
```

Create a minimal manifest:
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

See the [manifest schema documentation][manifest-schema] for complete schema details and optional fields.

### Step 3: Create Plugin Directory Structure

Follow the [plugin directory structure][structure-docs] standard. Create only the component directories you need:

```bash
# Only create directories for components you're actually using
mkdir commands    # if using slash commands
mkdir agents      # if using subagents
mkdir skills      # if using skills
mkdir hooks       # if using hooks
touch .mcp.json   # if using MCP server
```

### Step 4: Create Component Files

Create component files based on your plan. Refer to the official documentation for each component type:
- [Slash commands][commands-docs] - Command instruction files
- [Subagents][agents-docs] - Agent configuration files
- [Agent Skills][skills-docs] - Skill directories with `SKILL.md`
- [Hooks][hooks-docs] - Event hook configurations in `hooks.json`
- [MCP servers][mcp-docs] - `.mcp.json` configuration

### Step 5: Create README.md

Create a `README.md` at the plugin root documenting:
- Plugin purpose (single responsibility)
- Usage instructions with examples
- Dependencies or prerequisites
- Configuration options

### Step 6: Create CHANGELOG.md (Optional)

If versioning is important, create a `CHANGELOG.md` to track changes.

## Helping Users Test Their Plugin

After creating a plugin, guide the user through local testing. **You cannot test the plugin yourself** - provide clear instructions for the user to follow.

### Step 1: Generate Development Marketplace File

Create a file named `dev-marketplace.json` at the repository root:

```json
{
  "name": "dev-marketplace",
  "owner": {
    "name": "Developer"
  },
  "plugins": [
    {
      "name": "plugin-name",
      "source": "./plugin-name"
    }
  ]
}
```

**Important**: The `source` is relative to the marketplace file's location (repository root). Since the marketplace file is at the root, use `./plugin-name` to reference the plugin directory.

### Step 2: Register the Marketplace

**Do NOT run `claude` commands yourself.** Instruct the user to run:

```bash
claude plugin marketplace add ./dev-marketplace.json
```

**Note**: The new marketplace takes effect only in Claude Code sessions opened after registration.

### Step 3: Install the Plugin

Prompt the user to install the plugin:

```bash
claude plugin install plugin-name@dev-marketplace
```

### Step 4: Test Plugin Functionality

Provide specific testing instructions based on the plugin's components:

- **Commands**: Try the slash command (e.g., `/command-name`)
- **Agents**: Check that agents appear in agent listings and test their functionality
- **Skills**: Describe scenarios where the skill should activate
- **Hooks**: Verify hooks trigger on the expected events
- **MCP**: Test the MCP server integration

### Step 5: Iterate on Changes

When the user makes changes to the plugin, instruct them to reload the changes by uninstalling and reinstalling:

```bash
claude plugin uninstall plugin-name@dev-marketplace
claude plugin install plugin-name@dev-marketplace
```

This uninstall/reinstall cycle reloads all plugin changes (commands, JSON configuration, or any other plugin files).

### Step 6: Decommission the Development Marketplace

Once testing is complete, prompt the user to clean up by removing the development marketplace:

```bash
claude plugin marketplace remove dev-marketplace
```

This leaves their environment in a clean state.

For more details, refer users to the [Claude Code plugin testing documentation](https://code.claude.com/docs/en/plugins#test-your-plugins-locally).

## Git Workflow

### During Development

**Commit often** as you work on the plugin. Don't worry about perfect commit messages during development - the focus is on making incremental progress.

### When Ready for Pull Request

When submitting pull requests for new plugins or improvements:

**Pull Request Title** - In IMPERATIVE MOOD, describe what the plugin does (its capability), not what you're adding:
- Good: "Analyze Go test coverage interactively"
- Good: "Validate event schemas via hooks"
- Bad: "Add test coverage plugin"

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed PR guidelines with examples showing how component types emerge naturally in titles.

**Pull Request Description** - Explain the plugin's purpose and value:
- Why this plugin is useful
- What problem it solves

**Do NOT** list commits in the description - focus on the plugin's intention and impact on the collection.

### Merging

When the pull request is ready to merge, use **squash-and-merge**. This will combine all development commits into a single commit using the PR title and description as the merge commit message.

### Documentation Style

When writing or editing documentation in this repository:

- **Repository files**: Use inline links - `[CONTRIBUTING.md](CONTRIBUTING.md)`
- **External documentation**: Use reference-style links - `[Slash Commands][commands-docs]`

This keeps repository file references direct and readable, while allowing external URLs to be defined once at the bottom of the document.

## Reference Documentation

- [README.md](README.md) - Repository overview and installation
- [CONTRIBUTING.md](CONTRIBUTING.md) - Plugin development guidelines
- [Claude Code Plugins Documentation](https://code.claude.com/docs/en/plugins)
- [Plugin Marketplaces Documentation](https://code.claude.com/docs/en/plugin-marketplaces)
- [Plugins Reference](https://code.claude.com/docs/en/plugins-reference)

[commands-docs]: https://code.claude.com/docs/en/slash-commands
[agents-docs]: https://code.claude.com/docs/en/sub-agents
[skills-docs]: https://code.claude.com/docs/en/skills
[hooks-docs]: https://code.claude.com/docs/en/hooks
[mcp-docs]: https://code.claude.com/docs/en/mcp
[manifest-schema]: https://code.claude.com/docs/en/plugins-reference#plugin-manifest-schema
[structure-docs]: https://code.claude.com/docs/en/plugins-reference#plugin-directory-structure
