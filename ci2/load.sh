# 提供 以下参数
# 1.自身账号 2.自身挂载路径(全局路径,应该为一个空文件夹) 3.挂载的开发板路径(全局路径,需要提前创建好) 
# 4.结果路径 (执行时间等内容的路径)

account=$1
local_path=$2
remote_path=$3
back_dir=$4      #第四个参数是当前用例的执行结果的返回区域
time_limit=$5   #第五个参数时时间限制
# 执行结果的返回区域内建立一个out文件夹放置输出
# 执行结果的返回区域内建一个log文件用来存放比对结果
# 执行结果的返回区域内建立一个time文件用来放置档次测试执行时间

# 挂载文件夹
./ci2/shell/mount.sh $account $local_path $remote_path
# 把挂载位置写入配置
sudo rm "./ci2/ci.cnf"
sudo touch "./ci2/ci.cnf"
sudo echo $local_path >> "./ci2/ci.cnf"
sudo echo $back_dir >> "./ci2/ci.cnf"
sudo echo $time_limit >> "./ci2/ci.cnf"

sudo cp ./ci2/py/remote_spy.py   "$local_path/"
sudo cp ./ci2/shell/remote_run.sh "$local_path/"

