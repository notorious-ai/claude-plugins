# golang-dev

Comprehensive Go development experience - skills that elevate Claude into the ultimate Golang developer.

## Philosophy

This plugin shapes Claude into a **professional Go developer** who thinks and acts like someone from the Go team - not just knows Go syntax, but embodies Go culture, conventions, and professional practices.

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

```bash
claude plugin marketplace add notorious-ai/claude-plugins
claude plugin install golang-dev@notorious-ai
```

## Requirements

- Go toolchain installed
- Working in a Go-centric codebase (go.mod present or known from context)
