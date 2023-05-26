# 定义自己的log过程,生成日志
# 因为程序流程比较简单，不指定log级别，只指定log输出的文件位置

# 进行log

import config

def log(msg,level=1,outPath=config.logPath):
    with open(outPath,"w+") as f:
        if level<=config.level:
            print(msg,file=f)
