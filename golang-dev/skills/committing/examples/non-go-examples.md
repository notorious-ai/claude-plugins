# Non-Go Commit Examples

Real and representative examples of commits for non-Go files in Go-centric codebases.

## Examples with Full Context

<example>
<context>
Adding automated release workflow that creates git tags when version changes.
</context>
<diff>
.github/workflows/release.yml: New workflow triggered on push to main.
Checks if version.go changed, extracts version string, creates signed tag,
pushes to origin. Uses actions/checkout@v4 and softprops/action-gh-release.
</diff>
<message>
github: automate release tagging on version bumps

The workflow triggers when a commit to main updates the
version constant in version.go. It creates a signed tag
and pushes to origin.

Requires RELEASE_TOKEN secret with repo and workflow scope.
</message>
<why_good>
Verb "automate" describes what GitHub now does (automation). Body explains
the trigger mechanism and secret requirement not visible in YAML alone.
</why_good>
</example>

<example>
<context>
Dependabot PRs need consistent labeling for filtering in PR list.
</context>
<diff>
.github/workflows/labeler.yml: New workflow triggered on pull_request from
dependabot[bot]. Adds "dependencies" label using actions/labeler.
</diff>
<message>
github: label Dependabot PRs with "dependencies"

Automated labeling helps filter and track dependency updates
in the PR list. The workflow triggers on Dependabot PRs only.
</message>
<why_good>
Body explains the WHY (filtering) not visible in workflow definition.
Verb "label" describes the resulting action.
</why_good>
</example>

## Module Dependencies (go.mod)

<examples category="go.mod" context="CLI-style verbs match go command semantics">
<message>go.mod: tidy</message>
<message>go.mod: get golang.org/x/sync</message>
<message>go.mod: upgrade testcontainers to v0.20.0</message>
<message>go.mod: downgrade grpc to v1.58.0 for compatibility</message>
<message>go.mod: bump github.com/stretchr/testify to v1.9.0</message>
<message>go.mod: replace local module during development</message>
</examples>

## Documentation (docs)

<examples category="docs" context="Documentation files, READMEs, guides">
<message>docs: explain troubleshooting steps for connectivity issues</message>
<message>docs: clarify installation requirements for Windows</message>
<message>docs: restructure API reference by resource type</message>
<message>docs: remove deprecated migration guide</message>
<message>docs: document environment variable configuration</message>
</examples>

## GitHub Integration

<examples category="github" context="GitHub workflows, issue templates, actions - from Go repository">
<message>github: use forms for issue templates</message>
<message>github: switch seen/expected order in issue forms</message>
<message>github: simplify the telemetry proposal template</message>
<message>github: clean up issue forms</message>
</examples>

## Git Configuration

<examples category="git" context="Git configuration files (.gitignore, .gitattributes, LFS)">
<message>git: ignore build artifacts</message>
<message>git: track large binaries with LFS</message>
<message>git: configure line endings for Windows compatibility</message>
</examples>

## Build System

<examples category="build" context="Makefiles, build scripts, CI configuration">
<message>build: parallelize test execution</message>
<message>build: simplify release target</message>
<message>build: configure cross-compilation for ARM64</message>
<message>build: cache Go modules between CI runs</message>
</examples>

## Tool Configurations

<examples category="golangci" context="golangci-lint configuration">
<message>golangci: silence unused variable warnings in tests</message>
<message>golangci: enable gocritic linter</message>
<message>golangci: increase timeout for large modules</message>
</examples>

<examples category="docker" context="Dockerfile and container configuration">
<message>docker: optimize image layer caching</message>
<message>docker: reduce final image size with multi-stage build</message>
<message>docker: pin base image to specific digest</message>
</examples>

## Scripts and Tools

<examples category="scripts" context="Shell scripts, automation, deployment">
<message>scripts: validate input before deployment</message>
<message>scripts: retry failed uploads with exponential backoff</message>
</examples>

<examples category="tools" context="Code generators, development utilities">
<message>tools: generate OpenAPI spec from annotations</message>
</examples>

## Anti-Patterns

### ❌ Developer-Action Verbs

<anti-pattern>
<bad>github: add workflow for testing</bad>
<why_bad>Verb "add" describes what the developer did, not what GitHub now does.</why_bad>
<good>github: test module on pull-requests</good>
</anti-pattern>

<anti-pattern>
<bad>docs: create installation guide</bad>
<why_bad>Verb "create" describes developer action, not what docs now explain.</why_bad>
<good>docs: explain installation process</good>
</anti-pattern>

<anti-pattern>
<bad>go.mod: update dependencies</bad>
<why_bad>Verb "update" is vague; prefer CLI verbs like tidy, get, upgrade.</why_bad>
<good>go.mod: get updated dependencies</good>
</anti-pattern>

### ❌ Vague Targets

<anti-pattern>
<bad>config: update settings</bad>
<why_bad>Target "config" is too generic - which tool's configuration?</why_bad>
<good>golangci: enable stricter linting rules</good>
</anti-pattern>

<anti-pattern>
<bad>ci: change pipeline</bad>
<why_bad>Target "ci" is vague when "github" or specific tool is clearer.</why_bad>
<good>github: cache dependencies between workflow runs</good>
</anti-pattern>

<anti-pattern>
<bad>misc: various fixes</bad>
<why_bad>Target "misc" and verb "various" provide no information.</why_bad>
<good>scripts: handle edge cases in deployment</good>
</anti-pattern>

### ❌ Implementation Details

<anti-pattern>
<bad>github: add new YAML file for workflows</bad>
<why_bad>Describes file format, not what the workflow accomplishes.</why_bad>
<good>github: automate nightly builds</good>
</anti-pattern>

<anti-pattern>
<bad>docker: change FROM statement</bad>
<why_bad>Describes Dockerfile syntax, not the resulting change.</why_bad>
<good>docker: switch to distroless base image</good>
</anti-pattern>
