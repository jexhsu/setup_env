#!/bin/bash

echo -e "${YELLOW}Installing Neovim...${NC}"
brew install neovim

echo -e "${YELLOW}Installing prerequisites for NvChad...${NC}"
brew install ripgrep
brew install gcc

echo -e "${YELLOW}Deleting old Neovim folders...${NC}"
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

echo -e "${YELLOW}Cloning NvChad configuration...${NC}"
git clone --branch jexhsu git@github.com:jexhsu/nvim.git ~/.config/nvim

echo -e "${GREEN}Setup complete!${NC}"
