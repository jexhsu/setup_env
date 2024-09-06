#!/bin/bash

# Prompt the user for their Git username and email
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email

# Set Git global username and email
git config --global user.name "$git_username"
git config --global user.email "$git_email"

# Verify the configuration
echo -e "${YELLOW}Verifying Git configuration...${NC}"
git config --global --list

# Confirmation message
echo -e "${GREEN}Git configuration updated successfully!${NC}"
