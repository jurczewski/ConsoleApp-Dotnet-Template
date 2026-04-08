#!/usr/bin/env bash

set -euo pipefail

# Prompt the user for the new phrase
read -rp "Enter the new phrase to replace 'ProjectName': " NEW_PHRASE

if [[ -z "$NEW_PHRASE" ]]; then
    echo "Error: phrase cannot be empty." >&2
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIRECTORY="$(dirname "$SCRIPT_DIR")"

# Detect sed in-place flag (GNU/Linux vs BSD/macOS)
if sed --version 2>/dev/null | grep -q GNU; then
    SED_I=(-i)
else
    SED_I=(-i '')
fi

# Escape special characters in NEW_PHRASE for use as sed replacement string
ESCAPED_PHRASE=$(printf '%s' "$NEW_PHRASE" | sed 's/[\\&|]/\\&/g')

# Replace "ProjectName" with the new phrase in file content
while IFS= read -r -d '' file; do
    # Skip binary files
    if file "$file" | grep -q "text"; then
        if sed "${SED_I[@]}" "s|ProjectName|$ESCAPED_PHRASE|g" "$file" 2>/dev/null; then
            echo "Replaced content in '$file'"
        else
            echo "Warning: Could not replace content in '$file'. Skipping." >&2
        fi
    fi
done < <(find "$DIRECTORY" -type f \
    ! -name "README.md" \
    ! -name "rename-all.sh" \
    ! -name "rename-all.ps1" \
    -print0)

# Rename files containing "ProjectName"
while IFS= read -r -d '' file; do
    parent="$(dirname "$file")"
    base="$(basename "$file")"
    new_name="${base//ProjectName/$NEW_PHRASE}"
    mv "$file" "$parent/$new_name"
    echo "Renamed file '$file' to '$parent/$new_name'"
done < <(find "$DIRECTORY" -type f -name "*ProjectName*" -print0)

# Rename directories containing "ProjectName" (deepest first)
while IFS= read -r dir; do
    parent="$(dirname "$dir")"
    base="$(basename "$dir")"
    new_name="${base//ProjectName/$NEW_PHRASE}"
    new_path="$parent/$new_name"
    mv "$dir" "$new_path"
    echo "Renamed directory '$dir' to '$new_path'"
done < <(find "$DIRECTORY" -depth -type d -name "*ProjectName*")

echo "Rename operation completed."
