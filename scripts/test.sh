#!/bin/bash

# 获取当前脚本所在的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载颜色脚本
source "$SCRIPT_DIR/../modules/common/colors.sh"

# 定义函数以获取所有脚本名（不包括 init.sh 和扩展名）
get_function_names() {
    local dir="$1"
    find "$dir" -maxdepth 1 -name "*.sh" ! -name "init.sh" -exec basename {} .sh \;
}

# 获取 serve 和 client 的函数名
serve_functions=($(get_function_names "$SCRIPT_DIR/../modules/serve"))
client_functions=($(get_function_names "$SCRIPT_DIR/../modules/client"))

# 函数用于执行脚本并显示初始页面
run_scripts() {
    local functions=("$@")
    for func in "${functions[@]}"; do
        # 加载并执行 print_ascii.sh 脚本，传入函数名
        echo -e "${YELLOW}正在加载 print_ascii.sh for $func...${NC}"
        if ! source "$SCRIPT_DIR/../modules/common/print_ascii.sh" "$func"; then
            echo -e "${RED}错误: 加载 print_ascii.sh 失败 for $func${NC}"
            continue  # 继续下一个函数
        fi

        # 添加 5 行空行作为间隔
        printf '\n%.0s' {1..5}

        # 加载并执行对应的函数脚本
        echo -e "${YELLOW}正在加载 $func.sh...${NC}"
        SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        if ! source "$SCRIPT_DIR/../modules/serve/$func.sh"; then
            echo -e "${RED}错误: 加载 $func.sh 失败${NC}"
            continue  # 继续下一个函数
        fi

        # 检查函数是否已定义
        echo -e "${YELLOW}检查函数 $func 是否已定义...${NC}"
        if ! declare -f "$func" &> /dev/null; then
            echo -e "${RED}错误: 函数 '$func' 未定义。${NC}"
            continue  # 继续下一个函数
        fi

        # 执行函数并捕获错误
        echo -e "${YELLOW}正在执行函数 $func...${NC}"
        if ! "$func"; then
            echo -e "${RED}错误: 执行 $func 失败。${NC}"
            # 删除 common 目录中的路径
            echo -e "${YELLOW}正在删除 common 目录中的路径...${NC}"
            SCRIPT_DIR="${SCRIPT_DIR/\/common/}"  # 从路径中删除 common
            continue  # 继续下一个函数
        fi

        echo -e "${GREEN}函数 $func 执行成功！${NC}"
    done
}

# 执行 serve 和 client 的脚本
echo -e "${YELLOW}正在运行 serve 脚本...${NC}"
run_scripts "${serve_functions[@]}"

echo -e "${YELLOW}正在运行 client 脚本...${NC}"
run_scripts "${client_functions[@]}"
