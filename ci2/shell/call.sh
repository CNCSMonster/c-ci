# 调用本地的compiler编译程序 ,陆续执行目标路径内的用例并移出结果
# 从ci.cnf里面读取需要的路径,
# 参数
# 输入的路径,


# 启动远程测试的函数        (远程测试会自动监听)
function start_test(){
    # 第一个参数是挂载的文件夹地址
    mount_dir=$1
    info_path="$1/ci.info"
    cur_time=$(date)
    echo "call at $cur_time" >> "$info_path"
}

# 判断路径名是函数名还是文件夹名
function check_path_type() {
    path="$1"
    if [ -d "$path" ]; then
        echo "1"        #文件夹名字
    else 
        echo "2"    #文件名
    fi
}

# 比较两个文件的不同

# 启动
#!/bin/bash
# 文件路径
file_path="./ci2/ci.cnf"
# 读取文件的前四行并存储到Shell变量中
local_path=$(sed -n '1p' "$file_path")
back_dir=$(sed -n '2p' "$file_path")

# 输出变量的值
echo "local_path: $local_path"
echo "back_dir: $back_dir"
# 主要代码 

#!/bin/bash
# 文件夹路径


for arg in "$@"; do
  
  echo "参数: $arg"
done