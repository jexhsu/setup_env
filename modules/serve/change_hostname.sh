#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    print_message "${RED}" "Please run as root or use sudo."
    exit 1
fi

# Prompt the user to input the old and new hostname
read -p "Please input the old hostname: " old_hostname
read -p "Please input the new hostname: " new_hostname

# Change the hostname
hostnamectl set-hostname "$new_hostname"

# Update the /etc/hosts file
sed -i "s/$old_hostname/$new_hostname/g" /etc/hosts

# Notify the user of the successful change
print_message "${GREEN}" "Hostname changed from '${YELLOW}$old_hostname${GREEN}' to '${YELLOW}$new_hostname${GREEN}'."
