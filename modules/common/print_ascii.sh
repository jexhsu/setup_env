#!/bin/bash

# 获取当前脚本所在的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 确保传入了参数
if [ -z "$1" ]; then
    echo "Usage: $0 <name>"
    exit 1
fi

# 获取名称并定义起始和结束标记
name="$1"
name_start="${name}_start"
name_end="${name}_end"

echo "name: $name"

# 定义 ASCII 艺术文件的绝对路径
file="$SCRIPT_DIR/ascii_art.txt"

# 读取输入文件的内容
if ! ascii_art=$(awk -v start="$name_start" -v end="$name_end" '
    BEGIN {found=0}
    {
        if (index($0, start)) {found=1; next}
        if (index($0, end)) {found=0}
        if (found) {print}
    }
' "$file"); then
    echo "Error: Could not read from $file"
    exit 1
fi

# 获取终端宽度
terminal_width=$(tput cols)

# 处理每行并居中显示
while IFS= read -r line; do
    line_length=${#line}
    padding=$(( (terminal_width - line_length) / 2 ))
    printf "%*s\n" $((padding + line_length)) "$line"
done <<< "$ascii_art"
