# compiler ci

为编译器比赛进行的dockerfile搭建和自动化测试脚本搭建

### 使用方式

因为只支持http,所以需要修改配置重启docker允许不安全pull

```
sudo touch f/etc/docker/daemon.json

sudo echo '{ "insecure-registries":["10.249.12.83:5000"] }' > /etc/docker/daemon.json

sudo systemctl restart docker
```

登录拉取

```
# 登录(应该不登录也可以pull)
docker login 10.249.12.83:5000
# 获取镜像(获取当时最新版本的镜像)
docker pull 10.249.12.83:5000/riscv-ci:1.0
```

运行且挂载文件

```
docker run -it --name ci -d -v <your data folder>:/test/data 10.249.12.83:5000/riscv-ci:1.0
```

上面的替换成你自己的测试数据位置,里面的内容格式应该如该仓库的/data路径中的内容,(或者如该链接中的内容一样[公开样例与运行时库 · master · CSC-Compiler / Compiler2022 · GitLab (](https://gitlab.eduxiji.net/nscscc/compiler2022/-/tree/master/%E5%85%AC%E5%BC%80%E6%A0%B7%E4%BE%8B%E4%B8%8E%E8%BF%90%E8%A1%8C%E6%97%B6%E5%BA%93)[eduxiji.net](http://eduxiji.net)[)](https://gitlab.eduxiji.net/nscscc/compiler2022/-/tree/master/%E5%85%AC%E5%BC%80%E6%A0%B7%E4%BE%8B%E4%B8%8E%E8%BF%90%E8%A1%8C%E6%97%B6%E5%BA%93)) 然后你就可以在容器外部进行更改数据来测试 ps:编译编译器产生的程序应该放到之中

交互式进入容器,使用test中的测试脚本来测试

```
#交互式进入运行的容器(避免多次重新启动容器)
docker exec -it ci /bin/bash
# 容器中使用下列命令
# 测试所有数据
python test_all.py 

# 测试 final_performance中用例
python test_ff.py

# ... 测试代码实现见该测试仓库中的/test
# 测试的结果也会输出保存到<your data folder>中
```

### 准备具有测试工具的基础image

使用的一个python3的基础image,然后下载了交叉编译工具链已经qemu-riscv64

### 编写测试脚本

### 搭建局域网内的docker registry

下载运行一个docker registry即可