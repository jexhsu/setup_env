#!/bin/bash

# Set TEST_ENV variable
export TEST_ENV=false

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load the initial environment
source "$SCRIPT_DIR/init.sh"

# Load the init.sh script
echo "Loading serve init script..."
if ! source "$SCRIPT_DIR/../modules/serve/init.sh"; then
    echo "Error: Failed to load init.sh"
    exit 1
fi

echo "Serve init script loaded successfully."
