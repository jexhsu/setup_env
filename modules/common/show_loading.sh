# 定义显示加载动画的函数
show_loading() {
    echo -n "Loading"
    for i in {1..3}; do
        sleep 1
        echo -n "."
    done
    echo ""
}