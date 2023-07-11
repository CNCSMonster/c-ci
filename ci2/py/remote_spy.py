import os
import time
import subprocess

def check_file_modification(filename):
    # 获取文件的初始修改时间
    initial_modification_time = os.path.getmtime(filename)
    print(initial_modification_time)
    while True:
        # 获取当前的修改时间
        current_modification_time = os.path.getmtime(filename)
        if current_modification_time == initial_modification_time:
            time.sleep(0.5)
            continue
        print("remote run")
        subprocess.run(['bash','./remote_run.sh'],check=True)
        initial_modification_time = os.path.getmtime(filename)
        # 更新初始修改时间

if __name__ == "__main__":
    filename = "./ci.info"
    check_file_modification(filename)