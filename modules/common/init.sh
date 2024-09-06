#!/bin/bash

# 获取当前脚本所在的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 确保传入了参数
if [ -z "$1" ]; then
    echo "Usage: $0 <function_name>"
    exit 1
fi

# 加载通用的 print_ascii.sh 脚本，传入参数 $1
if ! source "$SCRIPT_DIR/common/print_ascii.sh" "$1"; then
    echo "Error: Failed to source print_ascii.sh"
    exit 1
fi

# 添加 5 行空行作为间隔
printf '\n%.0s' {1..5}
