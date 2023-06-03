# 用来催动git下载一个程序的脚本

import subprocess

if __name__=="__main__":
    # subprocess.run(["cd","llvm"])
    while True :
        retCode=subprocess.run(["git","clone","https://github.com/llvm-mirror/llvm"]).returncode
        if retCode!=0 :
            print(retCode)
            continue
        break