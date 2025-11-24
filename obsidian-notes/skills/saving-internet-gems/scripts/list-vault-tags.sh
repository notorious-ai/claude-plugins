#!/bin/bash
# Extract all unique tags from markdown files in an Obsidian vault

vault_path="${1:-.}"

find "$vault_path" -name "*.md" -type f -exec yq -f extract '.tags[]' {} \; 2>/dev/null | sort -u
