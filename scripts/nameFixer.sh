#!/bin/bash

# Default values
DRY_RUN=true
TARGET_DIR="."

# Function to show usage
usage() {
    echo "Usage: $0 [options] [directory]"
    echo "Options:"
    echo "  -r, --run      Actually rename the files (default is dry-run)"
    echo "  -h, --help     Show this help message"
    exit 1
}

# Parse flags
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -r|--run) DRY_RUN=false; shift ;;
        -h|--help) usage ;;
        -*) echo "Unknown option: $1"; usage ;;
        *) TARGET_DIR="$1"; shift ;;
    esac
done

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' not found."
    exit 1
fi

cd "$TARGET_DIR" || exit 1

if [ "$DRY_RUN" = true ]; then
    echo "--- DRY RUN MODE: No files will be changed ---"
else
    echo "--- LIVE MODE: Renaming files now ---"
fi

# Process files
find . -maxdepth 1 -type f -not -path '*/.*' -print0 | while read -d $'\0' FULL_PATH; do
    FILENAME=$(basename "$FULL_PATH")
    EXT="${FILENAME##*.}"
    BASE="${FILENAME%.*}"

    # Sanitation logic (Keeping numbers 0-9 intact)
    CLEAN_BASE=$(echo "$BASE" | tr ' ()[]{}&/' '_________' | sed 's/[^a-zA-Z0-9._-]//g' | sed 's/_\+/_/g' | sed 's/^_//;s/_$//')
    CLEAN_BASE=$(echo "$CLEAN_BASE" | tr '[:upper:]' '[:lower:]' | cut -c 1-150)

    NEW_NAME="${CLEAN_BASE}.${EXT}"

    if [ "$FILENAME" != "$NEW_NAME" ]; then
        if [ "$DRY_RUN" = true ]; then
            echo "[PREVIEW] $FILENAME  ->  $NEW_NAME"
        else
            echo "[RENAMING] $FILENAME  ->  $NEW_NAME"
            mv -n "$FILENAME" "$NEW_NAME"
        fi
    fi
done

if [ "$DRY_RUN" = true ]; then
    echo "--- Dry run complete. Use --run to apply changes. ---"
fi
