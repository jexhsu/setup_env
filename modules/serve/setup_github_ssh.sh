#!/bin/bash

set -e

# Function to handle errors
handle_error() {
    print_message "${RED}" "Error: $1"
    return 0
}

# Install GitHub CLI using Homebrew
print_message "${YELLOW}" "Installing GitHub CLI..."
brew install gh || handle_error "Failed to install GitHub CLI"

# Generate SSH key
print_message "${YELLOW}" "Generating SSH key..."
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" || handle_error "Failed to generate SSH key"

# Read the public key into a variable
print_message "${YELLOW}" "Reading the public key into a variable..."
PUB_KEY=$(cat ~/.ssh/id_rsa.pub) || handle_error "Failed to read public key"

# Use GitHub CLI to add SSH key
print_message "${YELLOW}" "Using GitHub CLI to add SSH key..."
read -p "Enter a title for your SSH key: " title

gh auth login || handle_error "Failed to login to GitHub CLI"

if gh ssh-key add <(echo "$PUB_KEY") --title "$title"; then
    print_message "${GREEN}" "SSH key added to GitHub successfully!"
else
    handle_error "Failed to add SSH key to GitHub"
fi
