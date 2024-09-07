#!/bin/bash

# Update and install dependencies
print_message "${YELLOW}" "Updating and installing dependencies..."
sudo apt update && sudo apt install -y build-essential procps curl file git

# Install Homebrew
print_message "${YELLOW}" "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages using Homebrew
print_message "${YELLOW}" "Installing packages using Homebrew: zsh, thefuck, neofetch..."
brew install zsh thefuck neofetch 

# Install oh-my-zsh
print_message "${YELLOW}" "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins
print_message "${YELLOW}" "Installing zsh plugins..."
brew install zsh-autosuggestions zsh-syntax-highlighting romkatv/powerlevel10k/powerlevel10k

# Copy config file
print_message "${YELLOW}" "Copying config file to .zshrc..."
cp -f ../../config/zshrc ~/.zshrc

# Create a script file named safe_remove
sudo bash -c 'cat <<EOF > /usr/local/bin/safe_remove
#!/bin/bash
gio trash "\$@"
EOF'

# Make the script executable
sudo chmod +x /usr/local/bin/safe_remove

print_message "${GREEN}" "safe_remove script has been created and set as executable. You can now use sudo safe_remove directory to delete a directory."

# Reload Zsh configuration
print_message "${YELLOW}" "Reloading Zsh configuration..."
source ~/.zshrc

# Set zsh as the default shell
print_message "${YELLOW}" "Setting zsh as the default shell..."
chsh -s "$(which zsh)"

print_message "${GREEN}" "Installation complete! Please restart your terminal or run 'exec zsh' to start using zsh."
