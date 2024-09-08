#!/bin/bash

# Function to set and verify Git configuration
set_and_verify_git_config() {
    local config_type=$1
    local prompt_message=$2
    local config_value

    while true; do
        # Prompt the user for input
        read -p "$prompt_message" config_value

        # Validate input
        if [ -z "$config_value" ]; then
            print_message "${YELLOW}" "Input cannot be empty. Please try again."
            continue
        fi

        # Set Git global configuration
        if git config --global "user.$config_type" "$config_value"; then
            # Verify the configuration
            local verified_value=$(git config --global "user.$config_type")

            if [ "$verified_value" = "$config_value" ]; then
                print_message "${GREEN}" "Git $config_type set successfully: $verified_value"
                break
            else
                print_message "${RED}" "Failed to set Git $config_type. Please try again."
            fi
        else
            print_message "${RED}" "Error setting Git $config_type. Please check your Git installation."
        fi
    done
}

# Check if Git is installed
if ! command -v git &> /dev/null; then
    print_message "${RED}" "Git is not installed. Please install Git and try again."
    exit 1
fi

# Set and verify Git username and email
print_message "${YELLOW}" "Configuring Git username and email..."
set_and_verify_git_config "name" "Enter your Git username: "
set_and_verify_git_config "email" "Enter your Git email: "

# Final verification
if [ -n "$(git config --global user.name)" ] && [ -n "$(git config --global user.email)" ]; then
    print_message "${GREEN}" "Git configuration completed successfully."
    print_message "${YELLOW}" "Current Git configuration:"
    git config --global --list | grep user
else
    print_message "${RED}" "Git configuration is incomplete. Please run the script again."
fi
