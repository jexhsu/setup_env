#!/bin/bash

# Install Neovim
print_message "${YELLOW}" "Installing Neovim..."
brew install neovim

# Install prerequisites for NvChad
print_message "${YELLOW}" "Installing prerequisites for NvChad..."
brew install ripgrep
brew install gcc

# Delete old Neovim folders
print_message "${YELLOW}" "Deleting old Neovim folders..."
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

# Clone NvChad configuration
print_message "${YELLOW}" "Cloning NvChad configuration..."
git clone --branch jexhsu git@github.com:jexhsu/nvim.git ~/.config/nvim

print_message "${GREEN}" "Setup complete!"
