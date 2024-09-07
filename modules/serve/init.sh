#!/bin/bash

# 定义要执行的函数列表
functions=(
    create_sudo_user    
    change_hostname     
    setup_zsh           
    install_exa         
    config_git          
    setup_github_ssh    
    setup_neovim        
    install_packages
)

# Check if TEST_ENV is false
if [ "$TEST_ENV" = false ]; then
    # Attempt to source the print_ascii.sh script
    if ! source "$SERVE_DIR/../common/print_ascii.sh" "serve_running"; then
        print_message "${RED}" "加载 print_ascii.sh 失败: serve_running"
        exit 1
    fi
    # 打印 5 行空行作为间隔
    printf '\n%.0s' {1..5}
    sleep 1
fi

for func in "${functions[@]}"; do
    # 加载并执行 print_ascii.sh 脚本，传入函数名
    if ! source "$SERVE_DIR/../common/print_ascii.sh" "$func"; then
        print_message $RED "加载 print_ascii.sh 失败: $func"
        exit 1
    fi
    
    # 打印 5 行空行作为间隔
    printf '\n%.0s' {1..5}

    # 加载并执行对应的客户端函数脚本
    if [ "$TEST_ENV" = true ]; then
        sleep 1
        print_message "$YELLOW" "测试环境: 跳过执行 $func..."
    else
        print_message "$YELLOW" "正在加载并执行 $func..."
        source "$SERVE_DIR/$func.sh"
        
        # 直接调用函数
        if declare -f "$func" &> /dev/null; then
            print_message "$YELLOW" "正在执行函数 $func..."
            sleep 1
            "$func"
        else
            print_message "$RED" "错误: 函数 '$func' 未定义。"
        fi
    fi
done
