#!/bin/bash

# Prompt the user for their Git username and email
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email

# Set Git global username and email
git config --global user.name "$git_username"
git config --global user.email "$git_email"

# Verify the configuration
print_message "${YELLOW}" "Checking Git username and email..."

# Get Git global username and email
git_username=$(git config --global user.name)
git_email=$(git config --global user.email)

# Output the results
if [ -n "$git_username" ] && [ -n "$git_email" ]; then
    print_message "${GREEN}" "Git Username: $git_username"
    print_message "${GREEN}" "Git Email: $git_email"
else
    print_message "${YELLOW}" "Git username or email is not set."
fi
