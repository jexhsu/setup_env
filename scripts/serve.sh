#!/bin/bash

# 获取当前脚本所在的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载 init.sh 脚本
echo "Loading serve init script..."
if ! source "$SCRIPT_DIR/../modules/serve/init.sh"; then
    echo "Error: Failed to load init.sh"
    exit 1
fi

echo "Serve init script loaded successfully."
