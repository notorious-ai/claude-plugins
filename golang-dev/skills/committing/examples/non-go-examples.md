# Non-Go Commit Examples

Real and representative examples of commits for non-Go files in Go-centric codebases.

## Module Dependencies (go.mod)

```
go.mod: tidy
```

```
go.mod: get golang.org/x/sync
```

```
go.mod: upgrade testcontainers to v0.20.0
```

```
go.mod: downgrade grpc to v1.58.0 for compatibility
```

```
go.mod: bump github.com/stretchr/testify to v1.9.0
```

```
go.mod: replace local module during development
```

## Documentation (docs)

```
docs: explain troubleshooting steps for connectivity issues
```

```
docs: clarify installation requirements for Windows
```

```
docs: restructure API reference by resource type
```

```
docs: remove deprecated migration guide
```

```
docs: document environment variable configuration
```

## GitHub Integration

From the Go repository:

```
github: use forms for issue templates
```

```
github: switch seen/expected order in issue forms
```

```
github: simplify the telemetry proposal template
```

```
github: clean up issue forms
```

With body:

```
github: automate release tagging on version bumps

The workflow triggers when a commit to main updates the
version constant in version.go. It creates a signed tag
and pushes to origin.

Requires RELEASE_TOKEN secret with repo and workflow scope.
```

```
github: label Dependabot PRs with "dependencies"

Automated labeling helps filter and track dependency updates
in the PR list. The workflow triggers on Dependabot PRs only.
```

## Git Configuration

```
git: ignore build artifacts
```

```
git: track large binaries with LFS
```

```
git: configure line endings for Windows compatibility
```

## Build System

```
build: parallelize test execution
```

```
build: simplify release target
```

```
build: configure cross-compilation for ARM64
```

```
build: cache Go modules between CI runs
```

## Tool Configurations

### golangci-lint

```
golangci: silence unused variable warnings in tests
```

```
golangci: enable gocritic linter
```

```
golangci: increase timeout for large modules
```

### Docker

```
docker: optimize image layer caching
```

```
docker: reduce final image size with multi-stage build
```

```
docker: pin base image to specific digest
```

## Scripts and Tools

```
scripts: validate input before deployment
```

```
scripts: retry failed uploads with exponential backoff
```

```
tools: generate OpenAPI spec from annotations
```

## Anti-Pattern Examples (What NOT to Do)

### Bad: Developer-Action Verbs

```
# BAD
github: add workflow for testing
docs: create installation guide
go.mod: update dependencies

# GOOD
github: test module on pull-requests
docs: explain installation process
go.mod: get updated dependencies
```

### Bad: Vague Targets

```
# BAD
config: update settings
ci: change pipeline
misc: various fixes

# GOOD
golangci: enable stricter linting rules
github: cache dependencies between workflow runs
scripts: handle edge cases in deployment
```

### Bad: Implementation Details

```
# BAD
github: add new YAML file for workflows
docker: change FROM statement

# GOOD
github: automate nightly builds
docker: switch to distroless base image
```
