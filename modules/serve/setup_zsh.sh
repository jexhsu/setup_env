#!/bin/bash

# Update and install dependencies
echo -e "${YELLOW}Updating and installing dependencies...${NC}"
sudo apt update && sudo apt install -y build-essential procps curl file git

# Install Homebrew
echo -e "${YELLOW}Installing Homebrew...${NC}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages using Homebrew
echo -e "${YELLOW}Installing packages using Homebrew zsh thefuck neofetch...${NC}"
brew install zsh thefuck neofetch 

# Install oh-my-zsh
echo -e "${YELLOW}Installing oh-my-zsh...${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins
echo -e "${YELLOW}Installing zsh plugins...${NC}"
brew install zsh-autosuggestions zsh-syntax-highlighting romkatv/powerlevel10k/powerlevel10k

# Copy config file
printf "${YELLOW}Copying config file to .zshrc...${NC}\n"
cp -f ../../config/zshrc ~/.zshrc

# Create a script file named safe_remove
sudo bash -c 'cat <<EOF > /usr/local/bin/safe_remove
#!/bin/bash
gio trash "\$@"
EOF'

# Make the script executable
sudo chmod +x /usr/local/bin/safe_remove

echo -e "${GREEN}safe_remove script has been created and set as executable. You can now use sudo safe_remove directory to delete a directory.${NC}"

# Reload Zsh configuration
echo -e "${YELLOW}Reloading Zsh configuration...${NC}"
source ~/.zshrc

# Set zsh as the default shell
echo -e "${YELLOW}Setting zsh as the default shell...${NC}"
chsh -s $(which zsh)

echo -e "${GREEN}Installation complete! Please restart your terminal or run 'exec zsh' to start using zsh.${NC}"
