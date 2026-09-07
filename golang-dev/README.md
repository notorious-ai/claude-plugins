# golang-dev

Go development skills for coding agents.

## Philosophy

This plugin teaches Go team conventions and professional development practices.

**Priority Hierarchy:**

1. **Idiomatic readability** - Matching Go team style (stdlib, golang.org/x)
2. **Professional developer mindset** - How to think and act, not just code
3. **Industry know-hows** - Testing strategies, observability, community tools

## Skills

### Tier 1 (Current)

- **committing** - Write commit messages that match Go project conventions for all files in Go-centric codebases
- **planning-commits** - Plan a fine-grained sequence of atomic commits before the first line of code lands
- **testing** - Hold committed Go tests to the maintainer's standard, and review a suite against it

### Tier 2 (Planned)

- go-style-guide - The Go Way: idiomatic patterns and conventions
- go-documentation - Writing Go docs that match godoc standards

### Tier 3 (Future)

- go-observability - Production Go with OpenTelemetry
- go-toolchain - Community tools and practices

## Installation

### Claude Code

```bash
claude plugin marketplace add notorious-ai/claude-plugins
claude plugin install golang-dev@notorious-ai
```

### Codex CLI

```bash
codex plugin marketplace add notorious-ai/claude-plugins
codex plugin add golang-dev@notorious-ai
```

Start a new Codex session after installation.

## Requirements

- Go toolchain installed
- Working in a Go-centric codebase (go.mod present or known from context)
