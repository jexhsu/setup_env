#!/bin/bash

# 设置 TEST_ENV 变量
export TEST_ENV=false

# 加载初始环境
source "./init.sh"

# 加载 init.sh 脚本
echo "Loading serve init script..."
if ! source "$SCRIPT_DIR/../modules/serve/init.sh"; then
    echo "Error: Failed to load init.sh"
    exit 1
fi

echo "Serve init script loaded successfully."
