#!/bin/sh

# Download the exa zip file
print_message "${YELLOW}" "Downloading the exa zip file..."
curl -LO https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip

# Unzip the file
print_message "${YELLOW}" "Unzipping the file..."
unzip exa-linux-x86_64-v0.10.0.zip

# Copy exa to /usr/local/bin
print_message "${YELLOW}" "Copying exa to /usr/local/bin..."
sudo cp exa-linux-x86_64-v0.10.0/bin/exa /usr/local/bin/

# Remove the extracted folder
print_message "${YELLOW}" "Removing the extracted folder..."
rm -rf exa-linux-x86_64-v0.10.0

# Remove the downloaded zip file
print_message "${YELLOW}" "Removing the downloaded zip file..."
rm exa-linux-x86_64-v0.10.0.zip

print_message "${GREEN}" "exa installation complete!"
