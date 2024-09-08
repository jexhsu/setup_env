#!/bin/bash

# Define the list of functions to execute
functions=(
    setup_ssh_connection
)

main() {
    if [ "$TEST_ENV" = true ]; then
        load_print_ascii "client_test"
    else
        load_print_ascii "serve_running"
    fi

    print_message "$YELLOW" "List of executable functions:"
    for i in "${!functions[@]}"; do
        echo "$((i+1)). ${functions[i]}"
    done

    read -p "Enter the function number(s) to execute (separate multiple choices with spaces, press Enter to execute all): " choices

    if [ -z "$choices" ]; then
        choices=$(seq 1 ${#functions[@]})
    fi

    valid_choices=true
    for choice in $choices; do
        if ! [[ "$choice" =~ ^[1-9][0-9]*$ ]] || [ "$choice" -gt "${#functions[@]}" ]; then
            valid_choices=false
            break
        fi
    done

    if [ "$valid_choices" = true ]; then
        for choice in $choices; do
            func="${functions[$((choice-1))]}"
            if ! load_print_ascii "$func"; then
                continue
            fi

            if [ "$TEST_ENV" = true ]; then
                print_message "$YELLOW" "Test environment: Skipping execution of $func..."
            else
                print_message "$YELLOW" "Loading and executing $func..."
                source "$CLIENT_DIR/$func.sh"
            fi
            show_loading
        done
    else
        print_message "$RED" "Invalid choice, please try again."
    fi
}

main
