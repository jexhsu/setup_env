#!/bin/bash

# 设置 TEST_ENV 变量
export TEST_ENV=false

# 获取当前脚本所在的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载初始环境
source "$SCRIPT_DIR/init.sh"

# 加载 init.sh 脚本
echo "Loading client init script..."
if ! source "$SCRIPT_DIR/../modules/client/init.sh"; then
    echo "Error: Failed to load init.sh"
    exit 1
fi

echo "Client init script loaded successfully."
