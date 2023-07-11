# 文件夹路径

function walk_through(){
    folder_path=$1

    # 遍历文件夹并获取文件名
    files=$(find "$folder_path" -type f -printf "%f\n")

    # 按字典顺序排序文件名
    sorted_files=$(echo "$files" | sort)

    # 输出排序后的文件名
    echo "$sorted_files"
}