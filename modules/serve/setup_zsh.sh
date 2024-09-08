#!/bin/bash

set -e

# Function to handle errors
handle_error() {
    print_message "${RED}" "An error occurred. Exiting..."
    return 0
}

# Set trap for error handling
trap handle_error ERR

# Update and install dependencies
print_message "${YELLOW}" "Updating and installing dependencies..."
sudo apt update && sudo apt install -y build-essential procps curl file git || handle_error

# Install Homebrew
print_message "${YELLOW}" "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || handle_error

# Add Homebrew to PATH
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install packages using Homebrew
print_message "${YELLOW}" "Installing packages using Homebrew: zsh, thefuck, neofetch..."
brew install zsh thefuck neofetch || handle_error

# Install oh-my-zsh
print_message "${YELLOW}" "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || handle_error

# Install zsh plugins
print_message "${YELLOW}" "Installing zsh plugins..."
brew install zsh-autosuggestions zsh-syntax-highlighting romkatv/powerlevel10k/powerlevel10k || handle_error

# Copy config file
print_message "${YELLOW}" "Copying config file to .zshrc..."
cp -f "$ROOT_DIR/config/zshrc" ~/.zshrc || handle_error

# Create a script file named srm
print_message "${YELLOW}" "Creating srm script..."
sudo tee /usr/local/bin/srm > /dev/null << EOF || handle_error
#!/bin/bash
gio trash "\$@"
EOF

# Make the script executable
sudo chmod +x /usr/local/bin/srm || handle_error

print_message "${GREEN}" "srm script has been created and set as executable. You can now use sudo srm directory to delete a directory."

# Reload Zsh configuration
print_message "${YELLOW}" "Reloading Zsh configuration..."
source ~/.zshrc || handle_error

# Set zsh as the default shell
print_message "${YELLOW}" "Setting zsh as the default shell..."
chsh -s "$(which zsh)" || handle_error

print_message "${GREEN}" "Installation complete! Please restart your terminal or run 'exec zsh' to start using zsh."
