#!/bin/bash

# Set TEST_ENV variable
export TEST_ENV=true  

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load the initial environment
source "$SCRIPT_DIR/init.sh"

# Define a function to run a specified init.sh script
echo "Loading client init script..."
run_init_script() {
    local init_script="$1"
    if ! source "$init_script"; then
        echo "Failed to run initialization script: $init_script"
        return 1
    fi
    echo "Initialization script completed successfully:"
}

# Run the init.sh scripts for serve and client
run_init_script "$SERVE_DIR/init.sh" "serve_test"
run_init_script "$CLIENT_DIR/init.sh" "client_test"
