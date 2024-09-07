#!/bin/bash

# Install GitHub CLI using Homebrew
print_message "${YELLOW}" "Installing GitHub CLI..."
brew install gh

# Generate SSH key
print_message "${YELLOW}" "Generating SSH key..."
ssh-keygen -t rsa -b 4096

# Read the public key into a variable
print_message "${YELLOW}" "Reading the public key into a variable..."
PUB_KEY=$(cat ~/.ssh/id_rsa.pub)

# Use GitHub CLI to add SSH key
print_message "${YELLOW}" "Using GitHub CLI to add SSH key..."
read -p "Enter a title for your SSH key: " title
gh auth login
gh ssh-key add <(echo "$PUB_KEY") --title "$title"

print_message "${GREEN}" "SSH key added to GitHub successfully!"
