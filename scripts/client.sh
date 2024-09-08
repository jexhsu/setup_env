#!/bin/bash

# Set TEST_ENV variable
export TEST_ENV=false

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load initial environment
source "$SCRIPT_DIR/init.sh"

# Load init.sh script
echo "Loading client init script..."
if ! source "$SCRIPT_DIR/../modules/client/init.sh"; then
    echo "Error: Failed to load init.sh"
    exit 1
fi

echo "Client init script loaded successfully."
