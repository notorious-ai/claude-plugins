#!/bin/bash
# Extract all unique tags from markdown files in an Obsidian vault

# Validate working directory
if [ ! -d ".obsidian" ]; then
    echo "Error: Not in an Obsidian vault root (no .obsidian directory found)" >&2
    echo "Current directory: $(pwd)" >&2
    echo "This script must be run from the root of an Obsidian vault" >&2
    exit 1
fi

vault_path="${1:-.}"

# Validate vault path exists
if [ ! -d "$vault_path" ]; then
    echo "Error: Vault path does not exist: $vault_path" >&2
    exit 1
fi

find "$vault_path" -name "*.md" -type f -exec yq -f extract '.tags[]' {} \; 2>/dev/null | sort -u
