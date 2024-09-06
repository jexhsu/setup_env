#!/bin/bash

#TODO Write the corresponding configuration in .ssh/config

# Remove spaces from variables
function trim_spaces() {
    echo "$1" | tr -d ' '
}

# Validate if the username is legal (adjust as needed)
function validate_username() {
    if [[ -z "$1" ]]; then
        printf "${RED}Username cannot be empty.${NC}\n"
        return 1
    elif [[ ! "$1" =~ ^[a-zA-Z0-9_]+$ ]]; then
        printf "${RED}Invalid username. Only letters, numbers, and underscores are allowed.${NC}\n"
        return 1
    fi
    return 0
}

# Validate if the IP address is legal
function validate_ip() {
    if [[ -z "$1" ]]; then
        printf "${RED}IP address cannot be empty.${NC}\n"
        return 1
    elif [[ ! "$1" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        printf "${RED}Invalid IP address format. Please use xxx.xxx.xxx.xxx format.${NC}\n"
        return 1
    fi
    return 0
}

# Input username until valid
while true; do
    read -p "Please input your username: " username
    username=$(trim_spaces "$username")
    if validate_username "$username"; then
        break
    fi
done

# Input IP address until valid
while true; do
    read -p "Please input IP number: " ip_number
    ip_number=$(trim_spaces "$ip_number")
    if validate_ip "$ip_number"; then
        break
    fi
done

# Input password
read -sp "Please input your password: " password
echo

# Generate SSH key pair (if not exists)
if [ ! -f ~/.ssh/id_rsa ]; then
    printf "${YELLOW}SSH key not found. Generating a new one...${NC}\n"
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
fi

# Copy SSH public key to remote server
printf "${GREEN}Copying SSH key to the remote server...${NC}\n"
sshpass -p "$password" ssh-copy-id -o StrictHostKeyChecking=no "$username@$ip_number"

# SSH login to remote server
printf "${GREEN}Connecting to the remote server...${NC}\n"
ssh -o StrictHostKeyChecking=no "$username@$ip_number"
