# 用来催动git下载一个程序的脚本

import subprocess

if __name__=="__main__":
    while True :
        retCode=subprocess.run(["git","clone","https://github.com/gcc-mirror/gcc.git"]).returncode
        if retCode!=0 :
            print(retCode)
            continue
        break