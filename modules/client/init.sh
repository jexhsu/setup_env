#!/bin/bash

# 获取当前脚本所在目录的绝对路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载颜色脚本
source "$SCRIPT_DIR/../modules/common/colors.sh"

# 定义需要执行的函数列表
functions=(
    setup_ssh_connection
)

for func in "${functions[@]}"; do
    # 加载并执行 print_ascii.sh 脚本，传入函数名
    source "$SCRIPT_DIR/../modules/common/print_ascii.sh" "$func"
    
    # 打印 5 行空行作为间隔
    printf '\n%.0s' {1..5}

    # 加载并执行对应的客户端函数脚本
    source "$SCRIPT_DIR/../modules/client/$func.sh"
done
