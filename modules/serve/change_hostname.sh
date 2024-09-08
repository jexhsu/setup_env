#!/bin/bash

# Function to validate hostname
validate_hostname() {
    local hostname=$1
    if [[ ! $hostname =~ ^[a-zA-Z0-9-]{1,63}$ ]] || [[ $hostname =~ ^-|-$ ]]; then
        return 1
    fi
    return 0
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    print_message "${RED}" "Please run as root or use sudo."
    exit 1
fi

# Get current hostname
current_hostname=$(hostname)

# Prompt the user to input the new hostname
while true; do
    read -p "Please input the new hostname (current: $current_hostname): " new_hostname
    if validate_hostname "$new_hostname"; then
        break
    else
        print_message "${YELLOW}" "Invalid hostname. Please use only letters, numbers, and hyphens (1-63 characters)."
    fi
done

# Confirm change
read -p "Change hostname from '$current_hostname' to '$new_hostname'? (y/n): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    print_message "${YELLOW}" "Hostname change cancelled."
    exit 0
fi

# Change the hostname
if hostnamectl set-hostname "$new_hostname"; then
    # Update the /etc/hosts file
    sed -i "s/\b$current_hostname\b/$new_hostname/g" /etc/hosts

    # Verify the change
    if [[ $(hostname) == "$new_hostname" ]]; then
        print_message "${GREEN}" "Hostname successfully changed from '${YELLOW}$current_hostname${GREEN}' to '${YELLOW}$new_hostname${GREEN}'."
    else
        print_message "${RED}" "Hostname change failed. Please check system logs for details."
    fi
else
    print_message "${RED}" "Failed to set new hostname. Please check your permissions and try again."
fi
