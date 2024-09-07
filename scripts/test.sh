#!/bin/bash

# 设置 TEST_ENV 变量
export TEST_ENV=true  

# 获取当前脚本所在的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载初始环境
source "$SCRIPT_DIR/init.sh"

# 定义一个函数用于运行指定的 init.sh 脚本
run_init_script() {
    local init_script="$1"
    # 加载并执行 print_ascii.sh 脚本，传入函数名
    if ! source "$SERVE_DIR/../common/print_ascii.sh" "$2"; then
        print_message $RED "加载 print_ascii.sh 失败: $2"
        exit 1
    fi
    # 打印 5 行空行作为间隔
    printf '\n%.0s' {1..5}
    sleep 1
    if ! source "$init_script"; then
        print_message "${RED}" "运行初始化脚本失败: $init_script"
        return 1
    fi
    print_message "${GREEN}" "初始化脚本成功完成:"
}

# 运行 serve 和 client 的 init.sh 脚本
run_init_script "$SERVE_DIR/init.sh" "serve_test"
run_init_script "$CLIENT_DIR/init.sh" "client_test"
