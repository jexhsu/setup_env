#!/bin/sh

# Function to handle errors and cleanup
cleanup() {
    print_message "${YELLOW}" "Cleaning up..."
    rm -rf exa-linux-x86_64-v0.10.0 exa-linux-x86_64-v0.10.0.zip
}

# Set up trap to call cleanup function on script exit
trap cleanup EXIT

# Check if exa is already installed
if command -v exa &> /dev/null; then
    print_message "${GREEN}" "exa is already installed. Skipping installation."
    return 0
fi

# Download the exa zip file
print_message "${YELLOW}" "Downloading the exa zip file..."
if ! curl -LO https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip; then
    print_message "${RED}" "Failed to download exa. Exiting."
    return 0
fi

# Unzip the file
print_message "${YELLOW}" "Unzipping the file..."
if ! unzip -q exa-linux-x86_64-v0.10.0.zip; then
    print_message "${RED}" "Failed to unzip exa. Exiting."
    return 0
fi

# Copy exa to /usr/local/bin
print_message "${YELLOW}" "Copying exa to /usr/local/bin..."
if ! sudo cp exa-linux-x86_64-v0.10.0/bin/exa /usr/local/bin/; then
    print_message "${RED}" "Failed to copy exa to /usr/local/bin. Exiting."
    return 0
fi

# Verify installation
if command -v exa &> /dev/null; then
    print_message "${GREEN}" "exa installation complete!"
else
    print_message "${RED}" "exa installation failed. Please check the logs and try again."
    return 0
fi

# Cleanup is handled by the trap, so we don't need to explicitly call it here
