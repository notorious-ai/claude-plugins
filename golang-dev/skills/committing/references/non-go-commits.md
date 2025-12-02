# Non-Go Commits

Guidance for commits that modify non-Go files in a Go-centric codebase: dependencies, documentation, configs, CI, scripts, and tooling.

## Target Categories

### Module Dependencies (`go.mod:`)

Use `go.mod:` for dependency changes.

**Files:**
- `go.mod`
- `go.sum`

**Verbs (prefer CLI command names):**
- **tidy** - from `go mod tidy`
- **get** - from `go get example.com/pkg`
- **upgrade** - version upgrade
- **downgrade** - version downgrade
- **bump** - general version update (when CLI verb doesn't fit)
- **replace** - local replacement
- **remove** - dependency removal

**Examples:**
```
go.mod: tidy
go.mod: get golang.org/x/sync
go.mod: upgrade testcontainers to v0.20.0
go.mod: downgrade grpc to v1.58.0
go.mod: bump github.com/stretchr/testify to v1.9.0
```

### Documentation (`docs:`)

Use `docs:` for ALL documentation changes.

**Files:**
- `README.md`, `CONTRIBUTING.md`, any `*.md` files
- `docs/` directory and all contents

**Sentence completion:** "This change modifies documentation to..."

**Verbs:**
- **explain** - adds explanation of concepts/usage
- **clarify** - improves clarity of existing docs
- **document** - covers new functionality
- **restructure** - reorganizes documentation
- **update** - minor content changes
- **remove** - deletes outdated content

**Examples:**
```
docs: explain how to troubleshoot connectivity issues
docs: clarify installation requirements for Windows
docs: restructure API reference by resource type
docs: remove deprecated migration guide
```

### GitHub Integration (`github:`)

Use `github:` for ALL GitHub-related changes.

**Files:**
- `.github/` directory (workflows, templates, actions)
- GitHub-specific configuration files

**Sentence completion:** "This change modifies GitHub integration to..."

**Verbs:**
- **automate** - sets up automation
- **test** - runs tests via workflows
- **build** - builds artifacts
- **deploy** - deploys releases
- **enforce** - enforces policies
- **label** - manages labels
- **notify** - sends notifications

**Examples:**
```
github: automate release tagging on version bumps
github: test the module on pull-requests
github: label Dependabot PRs with "dependencies"
github: enforce commit message format
```

### Git Configuration (`git:`)

Use `git:` for Git configuration files.

**Files:**
- `.gitignore`
- `.gitattributes`
- Other Git configuration files

**Sentence completion:** "This change modifies git configuration to..."

**Verbs:**
- **ignore** - adds ignore patterns
- **track** - adds tracking rules
- **configure** - general configuration

**Examples:**
```
git: ignore build artifacts
git: track large binaries with LFS
git: configure line endings for Windows compatibility
```

### Build System (`build:`)

Use `build:` for build-related files.

**Files:**
- `Makefile`
- Build scripts
- Build configuration

**Sentence completion:** "This change modifies build system to..."

**Verbs:**
- **parallelize** - improves build speed
- **simplify** - reduces complexity
- **optimize** - performance improvements
- **configure** - build options

**Examples:**
```
build: parallelize test execution
build: simplify release target
build: configure cross-compilation for ARM64
```

### CI/CD (Non-GitHub) (`ci:`)

Use `ci:` for CI configuration outside GitHub.

**Files:**
- `.circleci/`, `.travis.yml`, `Jenkinsfile`
- Other CI/CD configuration

**Sentence completion:** "This change modifies CI configuration to..."

**Examples:**
```
ci: cache Go modules between builds
ci: test on Go 1.21 and 1.22
ci: deploy to staging on merge
```

### Tool Configurations

Use the tool name as target (named after the CLI tool).

| Tool | Config File | Target |
|------|-------------|--------|
| golangci-lint | `.golangci.yml` | `golangci:` |
| Docker | `Dockerfile`, `docker-compose.yml` | `docker:` |
| Prettier | `.prettierrc` | `prettier:` |
| ESLint | `.eslintrc` | `eslint:` |

**Sentence completion:** "This change modifies [tool] configuration to..."

**Examples:**
```
golangci: silence unused variable warnings in tests
golangci: enable gocritic linter
docker: optimize image layer caching
docker: reduce final image size with multi-stage build
```

### Non-Code Directories (`scripts:`, `tools:`, etc.)

Use the FIRST segment only for non-Go code.

| Path | Target |
|------|--------|
| `scripts/deploy.sh` | `scripts:` |
| `scripts/customer-a/provision.sh` | `scripts:` |
| `tools/generator/generate.py` | `tools:` |

**Sentence completion:** "This change modifies TARGET to..."

## Anti-Patterns to Avoid

### Bad: Developer-Action Verbs

| Bad | Why | Good Alternative |
|-----|-----|------------------|
| `add workflow` | Describes your action | `automate testing` |
| `create Dockerfile` | Describes your action | `containerize application` |
| `write docs` | Describes your action | `explain usage` |
| `update config` | Too vague | Specific action |

### Bad: Vague Targets

| Bad | Why | Good Alternative |
|-----|-----|------------------|
| `config: ...` | Which config? | `golangci:`, `docker:`, etc. |
| `ci: update` | Too vague | `ci: cache dependencies` |
| `misc: ...` | Meaningless | Specific target |

## Choosing Target or Verb

When the target category isn't listed above, or when uncertain which target or verb best fits:

**1. Check local conventions first:**

```bash
git log --oneline -10 -- .github/ docs/ .golangci.yml
git log --oneline -10 -- <files>
```

Look for:
- How were similar files committed before?
- Does this repo use `ci:` or `github:` for workflow files?
- Are there established patterns for tool configs?
- Any domain-specific prefixes?

When local conventions exist and are consistent, follow them for uniformity.

**2. Only if history doesn't reveal a clear pattern:**

Use AskUserQuestion with prioritized options:
- Most likely target based on file type/location
- Alternative targets if applicable
- Let user select or provide custom target

This uncertainty is about **authoring the commit message**. Developer uncertainty about code/config itself belongs in the commit body; see `references/body-guidelines.md`.
