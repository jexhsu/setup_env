#!/bin/bash

# Install Nginx
print_message "${YELLOW}" "Installing Nginx..."
brew install nginx

# Install OpenJDK 17
print_message "${YELLOW}" "Installing OpenJDK 17..."
brew install openjdk@17

# Configure environment variables for OpenJDK 17 (optional)
print_message "${YELLOW}" "Configuring environment variables for OpenJDK 17..."
{
    echo 'export JAVA_HOME="$(brew --prefix openjdk@17)"'
    echo 'export PATH="$JAVA_HOME/bin:$PATH"'
} >> ~/.zshrc

# Refresh environment variables
source ~/.zshrc

# Display installation results
print_message "${GREEN}" "Installation complete!"
print_message "${GREEN}" "Nginx version:"
nginx -v
print_message "${GREEN}" "OpenJDK version:"
java -version
