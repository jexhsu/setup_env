#!/bin/bash

set -e

install_package() {
    local package=$1
    local message=$2
    print_message "${YELLOW}" "$message"
    if ! brew install "$package"; then
        print_message "${RED}" "Failed to install $package"
        return 0
    fi
}

configure_java_env() {
    print_message "${YELLOW}" "Configuring environment variables for OpenJDK 17..."
    local zshrc=~/.zshrc
    if ! grep -q "JAVA_HOME" "$zshrc"; then
        {
            echo 'export JAVA_HOME="$(brew --prefix openjdk@17)"'
            echo 'export PATH="$JAVA_HOME/bin:$PATH"'
        } >> "$zshrc"
    else
        print_message "${YELLOW}" "Java environment variables already configured"
    fi
}

# Install Nginx
install_package "nginx" "Installing Nginx..." || return 0

# Install OpenJDK 17
install_package "openjdk@17" "Installing OpenJDK 17..." || return 0

# Configure environment variables for OpenJDK 17
configure_java_env || return 0

# Refresh environment variables
if ! source ~/.zshrc; then
    print_message "${RED}" "Failed to refresh environment variables"
    return 0
fi

# Display installation results
print_message "${GREEN}" "Installation complete!"
print_message "${GREEN}" "Nginx version:"
if ! nginx -v; then
    print_message "${RED}" "Failed to get Nginx version"
fi

print_message "${GREEN}" "OpenJDK version:"
if ! java -version; then
    print_message "${RED}" "Failed to get Java version"
fi
