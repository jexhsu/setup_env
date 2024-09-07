#!/bin/bash

# 定义需要执行的函数列表
functions=(
    setup_ssh_connection
)

if [ "$TEST_ENV" = false ]; then
    # Attempt to source the print_ascii.sh script
    if ! source "$CLIENT_DIR/../common/print_ascii.sh" "client_running"; then
        print_message "${RED}" "加载 print_ascii.sh 失败: client_running"
        exit 1
    fi
    # 打印 5 行空行作为间隔
    printf '\n%.0s' {1..5}
    sleep 1
fi


for func in "${functions[@]}"; do
    # 加载并执行 print_ascii.sh 脚本，传入函数名
    if ! source "$CLIENT_DIR/../common/print_ascii.sh" "$func"; then
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
        source "$CLIENT_DIR/../modules/client/$func.sh"
        
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
