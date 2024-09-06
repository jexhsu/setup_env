#!/bin/bash

# Prompt the user for their Git username and email
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email

# Set Git global username and email
git config --global user.name "$git_username"
git config --global user.email "$git_email"

# Verify the configuration
echo -e "${YELLOW}Checking Git username and email...${NC}"

# Get Git global username and email
git_username=$(git config --global user.name)
git_email=$(git config --global user.email)

# Output the results
if [ -n "$git_username" ] && [ -n "$git_email" ]; then
    echo -e "${GREEN}Git Username: ${NC}$git_username"
    echo -e "${GREEN}Git Email: ${NC}$git_email"
else
    echo -e "${YELLOW}Git username or email is not set.${NC}"
fi
