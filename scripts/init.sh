# 获取当前脚本所在的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载 config.sh 文件
source "$SCRIPT_DIR/../config/config.sh"

# 加载公共模块
source "$COMMON_DIR/init.sh"