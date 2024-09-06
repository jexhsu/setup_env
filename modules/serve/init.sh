#!/bin/bash

# 获取当前脚本所在的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载颜色脚本
source "$SCRIPT_DIR/../common/colors.sh"

# 定义要执行的函数列表
functions=(
    create_sudo_user    
    change_hostname     
    setup_zsh           
    install_exa         
    config_git          
    setup_github_ssh    
    setup_neovim        
)

for func in "${functions[@]}"; do
    # 加载并执行 print_ascii.sh 脚本，传入函数名
    if ! source "$SCRIPT_DIR/../common/print_ascii.sh" "$func"; then
        echo "Error: Failed to load print_ascii.sh for $func"
        exit 1
    fi
    
    # 添加 5 行空行作为间隔
    printf '\n%.0s' {1..5}

    # 加载并执行对应的函数脚本
    if ! source "$SCRIPT_DIR/../serve/$func.sh"; then
        echo "Error: Failed to load $func.sh"
        exit 1
    fi
done
