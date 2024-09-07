#!/bin/bash

# Check if the script is run as sudo
if [ "$EUID" -ne 0 ]; then
    print_message "${RED}" "Please run this script with sudo privileges."
    exit 1
fi

# Read user input
read -p "Enter username: " username
read -sp "Enter password: " password
echo

# Create user and set password
if useradd -m -s /bin/bash "$username"; then
    echo "$username:$password" | chpasswd
    usermod -aG sudo "$username"
    print_message "${GREEN}" "User $username has been successfully created and added to the sudo group."
else
    print_message "${RED}" "Failed to create user."
fi
