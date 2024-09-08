#!/bin/bash

# Define the list of functions to execute
functions=(
    create_sudo_user
    change_hostname
    setup_zsh
    install_exa
    config_git
    setup_github_ssh
    setup_neovim
    install_packages
)

# Main execution logic
main() {
    if [ "$TEST_ENV" = true ]; then
        load_print_ascii "serve_test"
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

    for choice in $choices; do
        if [ "$choice" = "0" ]; then
            break
        fi

        if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#functions[@]} ]; then
            print_message "$RED" "Invalid selection, please try again."
            break
        fi

        func=${functions[$((choice-1))]}
        if ! load_print_ascii "$func"; then
            continue
        fi

        if [ "$TEST_ENV" = true ]; then
            print_message "$YELLOW" "Test environment: Skipping execution of $func..."
        else
            print_message "$YELLOW" "Loading and executing $func..."
            source "$SERVE_DIR/$func.sh"
        fi
        show_loading
    done
}

main
