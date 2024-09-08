#!/bin/bash

set -e

# Function to add or update SSH config
update_ssh_config() {
    local host="$1"
    local hostname="$2"
    local user="$3"
    local config_file="$HOME/.ssh/config"

    # Create config file if it doesn't exist
    [ ! -f "$config_file" ] && touch "$config_file"

    # Check if host already exists in config
    if grep -q "Host $host" "$config_file"; then
        # Update existing host
        sed -i "/Host $host/,/Host /c\
Host $host\n\
    HostName $hostname\n\
    User $user\n\
    IdentityFile ~/.ssh/id_rsa\n" "$config_file" || return 1
    else
        # Add new host
        echo -e "\nHost $host\n\
    HostName $hostname\n\
    User $user\n\
    IdentityFile ~/.ssh/id_rsa" >> "$config_file" || return 1
    fi

    print_message "${GREEN}" "SSH config updated for $host"
}

# Remove spaces from variables
trim_spaces() {
    echo "${1// /}"
}

# Validate if the username is legal (adjust as needed)
validate_username() {
    [[ -n "$1" && "$1" =~ ^[a-zA-Z0-9_]+$ ]] || return 1
}

# Validate if the IP address is legal
validate_ip() {
    [[ -n "$1" && "$1" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || return 1
}

# Input username until valid
get_valid_username() {
    local username
    while true; do
        read -p "Please input your username: " username
        username=$(trim_spaces "$username")
        if validate_username "$username"; then
            echo "$username"
            return 0
        else
            print_message "${RED}" "Invalid username. Only letters, numbers, and underscores are allowed."
        fi
    done
}

# Input IP address until valid
get_valid_ip() {
    local ip_number
    while true; do
        read -p "Please input IP number: " ip_number
        ip_number=$(trim_spaces "$ip_number")
        if validate_ip "$ip_number"; then
            echo "$ip_number"
            return 0
        else
            print_message "${RED}" "Invalid IP address format. Please use xxx.xxx.xxx.xxx format."
        fi
    done
}

main() {
    local username ip_number password

    username=$(get_valid_username) || return 0
    ip_number=$(get_valid_ip) || return 0

    # Input password
    read -sp "Please input your password: " password
    echo

    # Generate SSH key pair (if not exists)
    if [ ! -f ~/.ssh/id_rsa ]; then
        print_message "${YELLOW}" "SSH key not found. Generating a new one..."
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" || return 0
    fi

    # Copy SSH public key to remote server
    print_message "${GREEN}" "Copying SSH key to the remote server..."
    sshpass -p "$password" ssh-copy-id -o StrictHostKeyChecking=no "$username@$ip_number" || return 0

    # Update SSH config
    update_ssh_config "$username-server" "$ip_number" "$username" || return 0

    # SSH login to remote server
    print_message "${GREEN}" "Connecting to the remote server..."
    ssh "$username-server" || return 0
}

main
