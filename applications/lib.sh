#!/bin/bash
# Shared helper functions for install scripts

# append_if_missing FILE LINE
# Appends LINE to FILE only if it is not already present (exact line match).
append_if_missing() {
    local file="$1"
    local line="$2"
    touch "$file"
    grep -Fxq "$line" "$file" || echo "$line" >> "$file"
}
