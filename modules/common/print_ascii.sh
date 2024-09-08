#!/bin/bash

# Print ASCII art
print_ascii() {
    local name="$1"
    local file="$COMMON_DIR/ascii_art.txt"
    local terminal_width=$(tput cols)

    # Ensure a parameter is passed
    if [ -z "$name" ]; then
        print_message "${RED}" "Usage: print_ascii <name>"
        return 1
    fi

    # Read input file content and process each line
    if ! ascii_art=$(awk -v name="$name" -v terminal_width="$terminal_width" '
        BEGIN {found=0; name_start=name"_start"; name_end=name"_end"}
        function center(line) {
            line_length = length(line)
            padding = int((terminal_width - line_length) / 2)
            printf "%*s%s\n", padding, "", line
        }
        $0 ~ name_start {found=1; next}
        $0 ~ name_end {found=0; exit}
        found {center($0)}
    ' "$file"); then
        print_message "${RED}" "Error: Unable to read or process file $file"
        return 1
    fi

    # Output processed ASCII art
    echo "$ascii_art"
}

# Load and execute print_ascii function
load_print_ascii() {
    local func_name="$1"
    if ! print_ascii "$func_name"; then
        print_message "${RED}" "Failed to load ASCII art: $func_name"
        return 1
    fi
    printf '\n%.0s' {1..5}  # Print 5 empty lines as spacing
    return 0
}

# If this script is executed directly, call the print_ascii function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    print_ascii "$1"
fi
