#!/bin/bash

# Install GitHub CLI using Homebrew
echo -e "${YELLOW}Installing GitHub CLI...${NC}"
brew install gh

# Generate SSH key
echo -e "${YELLOW}Generating SSH key...${NC}"
ssh-keygen -t rsa -b 4096

# Read the public key into a variable
echo -e "${YELLOW}Reading the public key into a variable...${NC}"
PUB_KEY=$(cat ~/.ssh/id_rsa.pub)

# Use GitHub CLI to add SSH key
echo -e "${YELLOW}Using GitHub CLI to add SSH key...${NC}"
read -p "Enter a title for your SSH key: " title
gh auth login
gh ssh-key add <(echo "$PUB_KEY") --title "$title"

echo -e "${GREEN}SSH key added to GitHub successfully!${NC}"
