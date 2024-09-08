#!/bin/bash

set -e

setup_neovim() {
    # Install Neovim
    print_message "${YELLOW}" "Installing Neovim - Your powerful text editor..."
    if ! brew install neovim; then
        print_message "${RED}" "Failed to install Neovim"
        return 0
    fi

    # Install prerequisites for NvChad
    print_message "${YELLOW}" "Setting up prerequisites for NvChad - Making your Neovim awesome..."
    if ! brew install ripgrep gcc; then
        print_message "${RED}" "Failed to install prerequisites"
        return 0
    fi

    print_message "${YELLOW}" "Cloning NvChad starter configuration..."
    if ! git clone https://github.com/NvChad/starter ~/.config/nvim; then
        print_message "${RED}" "Failed to clone NvChad starter configuration"
        return 0
    fi

    print_message "${YELLOW}" "Navigating to Neovim configuration directory..."
    cd ~/.config/nvim || { print_message "${RED}" "Failed to navigate to Neovim config directory"; return 0; }

    print_message "${YELLOW}" "Setting up remote repositories..."
    if ! git remote rename origin nvchad-starter-origin; then
        print_message "${RED}" "Failed to rename remote"
        return 0
    fi

    print_message "${YELLOW}" "Updating NvChad starter configuration..."
    if ! git pull nvchad-starter-origin main; then
        print_message "${RED}" "Failed to update NvChad starter configuration"
        return 0
    fi

    print_message "${YELLOW}" "Setting upstream branch..."
    if ! git branch --set-upstream-to=nvchad-starter-origin/main; then
        print_message "${RED}" "Failed to set upstream branch"
        return 0
    fi

    print_message "${YELLOW}" "Adding personal Neovim configuration repository..."
    if ! git remote add jexhsu-origin git@github.com:jexhsu/nvim.git; then
        print_message "${RED}" "Failed to add personal Neovim configuration repository"
        return 0
    fi

    print_message "${YELLOW}" "Creating and switching to personal branch..."
    if ! git checkout -b jexhsu; then
        print_message "${RED}" "Failed to create and switch to personal branch"
        return 0
    fi

    print_message "${YELLOW}" "Fetching and applying personal Neovim configuration..."
    if ! git fetch jexhsu-origin && git reset --hard jexhsu-origin/jexhsu; then
        print_message "${RED}" "Failed to fetch and apply personal Neovim configuration"
        return 0
    fi

    print_message "${YELLOW}" "Setting upstream for personal branch..."
    if ! git branch --set-upstream-to=jexhsu-origin/jexhsu; then
        print_message "${RED}" "Failed to set upstream for personal branch"
        return 0
    fi

    print_message "${GREEN}" "Neovim setup complete! Your personalized environment is ready to use."
}

setup_neovim || { print_message "${RED}" "Neovim setup failed"; exit 1; }