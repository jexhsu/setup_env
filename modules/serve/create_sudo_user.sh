#!/bin/bash

# Check if the script is run as sudo
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script with sudo privileges.${NC}"
  exit 1
fi

# Read user input
read -p "Enter username: " username
read -sp "Enter password: " password
echo

# Create user and set password
if sudo useradd -m -s /bin/bash "$username"; then
  echo "$username:$password" | sudo chpasswd
  sudo usermod -aG sudo "$username"
  echo -e "${GREEN}User $username has been successfully created and added to the sudo group.${NC}"
else
  echo -e "${RED}Failed to create user.${NC}"
fi
