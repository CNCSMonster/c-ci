logPath="/test/data/log"
failLogPath="/test/data/fail.log"
timePath="/test/data/time"
level=2



def get_max_timeout():  #设计个执行超时时间
    try:
        with open(timePath,"r") as f:
            time=f.readline()
            time=int(time,10)
            return time
    except:
        return 20
    # 读取/test/data/下面的配置文件中的时间信息

if __name__=="__main__":
    print(get_max_timeout())