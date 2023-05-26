# 使用python的subprocess调用子进程编写脚本

### 注意事项

subprocess.run的command的参数列表中不能够使用重定位符>> / >,无效!应该使用该函数的stdin和stdout参数