# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Navigation

### Understanding This Repository's Structure

This repository uses a **flat structure** where each top-level directory represents a single, standalone plugin. There is no nesting or categorization - every plugin directory sits at the root level. The repository includes a marketplace file (`.claude-plugin/marketplace.json`) to enable easy discovery and installation.

**To browse available plugins:**
```bash
ls -d */
```

Each plugin directory contains its own `.claude-plugin/plugin.json` manifest, `README.md`, and optional component directories (commands, agents, skills, hooks, MCP config).

### Finding Examples

**Official Reference Repositories:**
- [anthropics/claude-code](https://github.com/anthropics/claude-code) - Official Claude Code plugins
- [anthropics/skills](https://github.com/anthropics/skills) - Official Skills collection

**Note:** Like this repository, the official repositories use `.claude-plugin/marketplace.json` to enable plugin discovery. You can browse the marketplace file to understand their structure and locate individual plugins.

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

   **For technical component details**: Invoke **plugin-structure** skill for overall structure, or component-specific skills (**command-development**, **skill-development**, **agent-development**, **hook-development**, **mcp-integration**).

### Component Selection Guide

When planning which component types to use, consider these guidelines based on activation patterns and use cases:

**[Slash Commands][commands-docs]** - User-triggered shortcuts for quick tasks:
- Single-file Markdown structure with explicit invocation
- Quick, frequently-used prompts and templates
- Simple workflows that don't require complex multi-file organization
- Best for: reminders, code templates, common prompt snippets
- Example: `/lint-go` to run Go linting with standard flags, `/trace-context` to analyze distributed tracing headers

**[Subagents][agents-docs]** - Delegated task execution with isolated context:
- Pre-configured AI personalities with specific expertise
- Separate context windows that keep main conversation clean
- Task-specific workflows like reviews, testing, debugging, or analysis
- Best for: complex subtasks requiring focused attention without polluting main thread
- Example: Delegate code review to specialized agent, autonomously debug distributed system issues

**[Agent Skills][skills-docs]** - Model-invoked capabilities that activate automatically:
- Claude autonomously decides when to use them based on request relevance
- Self-activating modular components for encoding specialized knowledge
- Single-capability focus with clear activation descriptions
- Best for: automating repetitive workflows, distributing standardized processes
- Example: Automatically analyze Go concurrency patterns when reviewing code, validate system architecture against principles

**[Hooks][hooks-docs]** - Event-driven automation at workflow points:
- Execute automatically at specific lifecycle events (PreToolUse, PostToolUse, SessionStart, etc.)
- Validation, context injection, permission management, monitoring
- Deterministic rules and security policies
- Best for: automated enforcement of standards, context enrichment, security checks
- Example: Validate event schemas before commits, auto-format code on file save, inject distributed tracing context at session start

**[MCP Servers][mcp-docs]** - Integration bridge to external systems:
- Connect Claude Code with external tools, databases, and APIs
- OAuth-authenticated cloud services and real-time data access
- Multi-step automations across design, development, and deployment tools
- Best for: enterprise integrations, data-heavy operations, cross-tool workflows
- Example: Query observability platform for metrics, fetch architecture diagrams from design system, analyze error tracking data

**Combining Components**: A single plugin can use multiple component types to deliver its capabilities. Plan which components work together to achieve the plugin's single, focused purpose.

3. **Ensure Single Responsibility**

   If the plugin tries to do multiple unrelated things, help the user break it into separate plugins. Each plugin should have one clear purpose.

4. **Validate the Approach**

   Before proceeding, validate that the plugin design is sound:
   - Does this plugin have exactly one clear purpose?
   - Can the functionality be achieved with existing tools or plugins?
   - Are there overlapping plugins that should be consolidated?
   - Does the name clearly convey the plugin's purpose?
   - Are the chosen component types appropriate for the intended activation pattern?
   - Have all external dependencies been identified and documented?

5. **Create a Plan**

   Present a clear plan including:
   - Plugin name and description
   - Primary component types to be used
   - Directory structure
   - Key files to be created
   - Any external dependencies

6. **Get Approval**

   Wait for user approval before proceeding to the Creation Phase.

## Creating a New Plugin

Invoke `/plugin-dev:create-plugin` to create the plugin structure, manifest, components, and documentation.

After the command completes, make these repository-specific amendments:

### Update Repository README

Update [README.md](README.md) to add the plugin to the "Available Plugins" section:

```markdown
- [plugin-name](plugin-name/) - One-line description
```

### Update Marketplace File

Update `.claude-plugin/marketplace.json` to add the plugin:

```json
{
  "name": "plugin-name",
  "source": "./plugin-name"
}
```

### Verify CHANGELOG.md

Ensure `CHANGELOG.md` exists at plugin root. Organize entries by **component** (skill/agent/command names) not by change type.

## Working with Individual Components

When creating or modifying components after initial plugin setup:

**Commands**: Invoke **command-development** skill
**Skills**: Invoke **skill-development** skill, then invoke **plugin-dev:skill-reviewer** agent after creating the skill
**Agents**: Invoke **agent-development** skill
**Hooks**: Invoke **hook-development** skill
**MCP**: Invoke **mcp-integration** skill

## Validating Plugin Components

Before testing, validate components are correctly structured.

**Skills**: Invoke **plugin-dev:skill-reviewer** agent to validate structure, quality, and best practices.

**Other components**: Reference the relevant skill used during creation (**command-development**, **agent-development**, **hook-development**, **mcp-integration**) for validation guidance.

**IMPORTANT:** Fix all validation issues before testing. Invalid components will not activate properly.

## Helping Users Test Their Plugin

After creating a plugin, guide the user through local testing. **You cannot test the plugin yourself** - provide clear instructions for the user to follow.

There are two methods for local testing. The `--plugin-dir` flag is simpler and recommended for quick iteration, while the development marketplace method is useful for testing marketplace integration.

### Method 1: Using --plugin-dir Flag (Recommended)

The simplest way to test a plugin is using the `--plugin-dir` flag when starting Claude Code:

**Start Claude Code with the plugin loaded:**

```bash
claude --plugin-dir /absolute/path/to/plugin-name
```

**Important notes:**
- Use the absolute path to the plugin directory
- The plugin is loaded only for that session
- To test changes, exit the session and restart with the flag
- This method doesn't require any marketplace setup or cleanup

**Iterate on changes:**
Simply exit the Claude Code session and restart with the same `--plugin-dir` flag to load the updated plugin.

### Method 2: Using Development Marketplace (Alternative)

This method is useful for testing marketplace integration and installation workflows.

**IMPORTANT**: The `dev-marketplace.json` file described below is for LOCAL TESTING ONLY. The repository's official marketplace is `.claude-plugin/marketplace.json`, which should be updated during plugin creation (see Step 8 in "Creating a New Plugin" above).

#### Step 1: Generate Development Marketplace File

Create a file named `dev-marketplace.json` at the repository root for local testing:

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

#### Step 2: Register the Marketplace

**Do NOT run `claude` commands yourself.** Instruct the user to run:

```bash
claude plugin marketplace add ./dev-marketplace.json
```

**Note**: The new marketplace takes effect only in Claude Code sessions opened after registration.

#### Step 3: Install the Plugin

Prompt the user to install the plugin:

```bash
claude plugin install plugin-name@dev-marketplace
```

#### Step 4: Iterate on Changes

When the user makes changes to the plugin, the changes won't automatically appear because the marketplace is cached. To reload changes, update the marketplace registration:

```bash
claude plugin marketplace update dev-marketplace
```

This refreshes the marketplace cache and picks up all plugin changes (commands, JSON configuration, or any other plugin files).

#### Step 5: Decommission the Development Marketplace

Once testing is complete, prompt the user to clean up by uninstalling the plugin and removing the development marketplace:

```bash
claude plugin uninstall plugin-name@dev-marketplace
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

**Why squash-and-merge?**
- Keeps the main branch history clean and focused on plugin capabilities rather than development iterations
- Makes it easy to revert entire plugins if needed (one commit = one plugin)
- Preserves full development history in the pull request for future reference
- Aligns commit messages with the plugin's purpose rather than implementation steps

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
[skill-structure]: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices#skill-structure
[skill-checklist]: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices#checklist-for-effective-skills
[skill-technical]: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices#technical-notes
