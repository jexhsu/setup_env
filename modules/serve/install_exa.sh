#!/bin/sh

# Download the exa zip file
echo -e "${YELLOW}Downloading the exa zip file...${NC}"
curl -LO https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip

# Unzip the file
echo -e "${YELLOW}Unzipping the file...${NC}"
unzip exa-linux-x86_64-v0.10.0.zip

# Copy exa to /usr/local/bin
echo -e "${YELLOW}Copying exa to /usr/local/bin...${NC}"
sudo cp exa-linux-x86_64-v0.10.0/bin/exa /usr/local/bin/

# Remove the extracted folder
echo -e "${YELLOW}Removing the extracted folder...${NC}"
rm -rf exa-linux-x86_64-v0.10.0

# Remove the downloaded zip file
echo -e "${YELLOW}Removing the downloaded zip file...${NC}"
rm exa-linux-x86_64-v0.10.0.zip

echo -e "${GREEN}exa installation complete!${NC}"
