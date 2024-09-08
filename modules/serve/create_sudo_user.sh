#!/bin/bash
# Check if the script is run as sudo
if [ "$EUID" -ne 0 ]; then
    print_message "$RED" "Please run this script with sudo privileges."
    exit 1
fi

# Read user input with validation
while true; do
    read -p "Enter username: " username
    if [[ "$username" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
        break
    else
        print_message "$RED" "Invalid username. Please use only lowercase letters, numbers, underscores, and hyphens."
    fi
done

while true; do
    read -sp "Enter password: " password
    echo
    read -sp "Confirm password: " password_confirm
    echo
    if [ "$password" = "$password_confirm" ]; then
        break
    else
        print_message "$RED" "Passwords do not match. Please try again."
    fi
done

# Create user and set password
if id "$username" &>/dev/null; then
    print_message "$RED" "User $username already exists."
    exit 1
fi

if useradd -m -s /bin/bash "$username"; then
    echo "$username:$password" | chpasswd
    if usermod -aG sudo "$username"; then
        print_message "$GREEN" "User $username has been successfully created and added to the sudo group."
        # Switch to the new user
        print_message "$GREEN" "Switching to user $username..."
        exec sudo -u "$username" /bin/bash
    else
        print_message "$RED" "Failed to add user to sudo group."
    fi
else
    print_message "$RED" "Failed to create user."
    exit 1
fi
