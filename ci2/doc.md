# 实际开发板上的ci

### 工作流设计

1. 挂载我们的一个目录到板子上指定位置，并且启动使用机上的监控程序监控开发板上挂载的文件夹中的ci.info文件

   使用机和开发板通过这个共享的目录进行交流

2. 板子上共享的文件夹中运行一个实时的监控程序spy.py，监控ci.info

3. 当监控到ci.info这个文件发生改变的时候，就会重新地执行一遍run.sh脚本，执行完成之后便会修改ci.info文件。 当检测到发生修改,则宿主机上就会执行local_run.sh脚本,把需要转移的输出,比如 时间,编译中间产物, 目标程序执行结果，标准目标程序执行结果转移出来，然后在使用机上执行对目标程序(从我们编译出的汇编得到的可执行程序)的执行解雇哦与标准目标程序(标准编译器直接编译源代码得到的结果) 进行对比,
   然后把对比结果输入到挂载目录外的当前目录下的一个文件中

### ci部署

1. 开发板上，登录后:

   ```
   mkdir ~/remote_mount_dir
   ```

2. 主机上,项目根目录下面使用命令行参数的形式执行load.sh脚本挂载 空文件夹(注意本地要用来挂载的文件夹要为空,要挂载的远程文件夹要存在)也就是`./ci2/load.sh <account> <local_mount_dir>  <remote_mount_dir> <mv_back_dir>` 具例如下:

   ```
   sudo mkdir ./ci2/local_mount_dir
   
   sudo mkdir ./ci2/out
   
   # 如果该目录已经挂载过了,还需要刷新下 
   #fusermount -u ./ci2/local_mount_dir
   
   ./ci2/reload.sh yjh@10.249.10.164 ./ci2/local_amount_dir /home/yjh/remote ./ci2/out
   ```

3. 开发板上,运行启动
   在开发板中设置挂载的文件夹为全可用(避免因为权限问题执行中断),然后在开发板上挂载的目录中执行:
   `python3 remote_spy.py`
   来启动开发板部分程序

### ci的使用