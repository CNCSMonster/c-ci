import os
import subprocess
import time
import mylog

# 



def get_all_file_paths(directory):
    file_paths = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            file_paths.append(file_path)
    return file_paths


# 测试某个文件夹下的内容,测试成功返回true,测试失败返回false
def test(path):
    # 测试过程中会先清理log的内容
    mylog.log("--------------test "+path+"--------------")
    testunits=[]   #通过名字进行一个set
    sysets=set()
    insets=set()
    outsets=set()
    files=get_all_file_paths(path)
    for file in files :
        # 去掉后缀名,判断是否一致
        basename, extension = os.path.splitext(file)
        if extension== ".sy":
            sysets.add(basename)
        elif extension==".in":
            insets.add(basename)
        elif extension==".out":
            outsets.add(basename)
    for basename in sysets:
        testunits.append(Unit(sy=basename+".sy"))
        end=testunits[-1]
        if basename in insets :
            end.input=basename+".in"
        if basename in outsets:
            end.out=basename+".out"
            
    num=0
    
    
    # 对testunits进行排序,按照首个字母下标进行升序排序
    testunits.sort(key=lambda v:v.order() )  
    
    total_std_exectime=0
    total_my_exectime=0
    
    for testunit in testunits :
        # print(testunit.order())
        # 统计执行时间,比较每个程序的执行时间,如果我们的程序比较好,在后面加上标记
        if not testunit.test():
            mylog.log("test "+path+ " fail! "+str(num)+"/"+str(len(testunits)))
            mylog.log("my cost:"+str(total_my_exectime))
            mylog.log("std cost:"+str(total_std_exectime))
            return False
        else:
            total_std_exectime+=testunit.std_exectime
            total_my_exectime+=testunit.my_exectime
        num+=1
    mylog.log("pass "+path)
    mylog.log("my  cost:"+str(total_my_exectime))
    mylog.log("std cost:"+str(total_std_exectime))
    return True

# 测试/test/data内所有文件夹里面的测试内容
def testall():
    mylog.log("-----------------------------------test all---------------------------------------")
    for _,dirs,_ in os.walk("/test/data"):
        for dir in dirs:
            dir="/test/data/"+dir
            if not test(dir):
                return False
    mylog.log("pass all test!")
    return True
            
def call_program_with_io(command=['./texe'],input_file="", output_file="",outputmod="a"):
    stdRet=None
    if input_file=="" and output_file=="":
        stdRet= subprocess.run(command)
    elif output_file=="":
        with open(input_file, 'r') as input_f:
            stdRet= subprocess.run(command, stdin=input_f, text=True)
    elif input_file=="":
        with open(output_file, outputmod) as output_f:
            stdRet= subprocess.run(command, stdout=output_f, text=True)
    else:   
        with open(input_file, 'r') as input_f:
            with open(output_file, outputmod) as output_f:
                stdRet= subprocess.run(command, stdin=input_f, stdout=output_f, text=True)
    return stdRet

import config
# 比较两个文件,输出不同之处在logFile中
def cmp_file(path1,path2,logFile=config.logPath):
    with open(path1, 'r') as f1:
        with open(path2,'r') as f2:
            with open(logFile,'w+') as f3:
                # 对于f1和f2,逐行对比
                numLines=0
                while True :
                    numLines+=1
                    line1=f1.readline()
                    line2=f2.readline()
                    # print(line1,line2)
                    if line1==line2 and line1=="" :
                        break
                    elif line1=="" or line2=="":
                        print("\nwant:",line1,"\nget :",line2,"\n@line:",numLines,"@charAt:",0,file=f3)
                        return False
                    # 否则就是正常读取到内容,对两个文件的内容进行比较
                    if line1==line2 :
                        continue
                    # 否则就是不同,统计两行不同的地方，并且对于不同的部分,开始着色便于快速定位
                    i=0
                    while i<len(line1)and i<len(line2):
                        if line1[i]==line2[i]:
                            i+=1
                            continue
                        break
                    print("\nwant:",line1,"\nget :",line2,file=f3)
                    j=0
                    while j<i+6:
                        print(" ",end='',file=f3)
                        j+=1
                    print("↑",file=f3)
                    print("\n@line:",numLines,"@charAt:",i,file=f3)
                    
                    return False
    return True
    
    
# 示例用法

# 测试单元
class Unit:
    # 注意，下面名称之间不能冲突
    compiler="/test/data/compiler" #指定自己要使用的编译器
    # compiler="riscv64-linux-gnu-gcc"
    stdcompiler="riscv64-linux-gnu-gcc" #指定对比使用的标准编译器
    asmbler="as"  #指定使用的汇编器
    linker="ld"   #指定使用的链接器
    tmp="/test/data/tmp.c"   #临时使用的文件名,用来保存预编译处理前结果,应为.c以遍通过编译器检测
    lib="/test/data/sylib.c"   #使用的库文件
    macroToRm="/test/t.h"   #用来替换的宏
    tasm="/test/data/t.s"  #目标汇编
    tin="/test/data/tin"  #目标可执行程序的输入路径
    tout="/test/data/tout" #目标可执行程序的输出路径
    tsrc="/test/data/t.c"   #目标sy程序
    texe="/test/data/texe" #目标可执行程序的路径
    myexe="/test/data/mexe"    #我们可执行程序的路径
    myasm="/test/data/myasm.s"  #我们的汇编路径
    myout="/test/data/mout"    #我们输出的路径
    logfile="/test/data/exe.log"    #查看的路径
    timeout=config.max_timeout  #设计个执行超时时间
    
    std_exectime=10000  #统计标准编译器编译出来的目标程序的执行时间
    my_exectime=10000     #统计目标程序执行时间
    
    def __init__(self,input="",out="",sy=""):
        self.input=input
        self.out=out
        self.sy=sy

   
    def order(self):
        # 排序要用，获取该测试单元的文件编号
        str1=self.sy.split("/")[-1]
        str1=str1.split("_")[0]
        return int(str1,10)
    
    # 测试该测试单元,执行前应该先指定使用的编译器
    def test(self):
        # 复制对应路径的内容到当前路径下
        if self.input!="":
            subprocess.run(["cp",self.input,self.tin])
        subprocess.run(["cp",self.out,self.tout])
        call_program_with_io(["echo","#include \"../t.h\""],output_file=self.tmp,outputmod="w")
        call_program_with_io(['cat',self.sy],output_file= self.tmp,outputmod="a")
        # 先对源代码进行预处理,去掉宏
        subprocess.run([self.stdcompiler,"-E","-P",self.tmp,"-o",self.tsrc])
        
        stdRet=None
        myRet=None
        #标准编译过程
        try:
            # 先编译出汇编
            call_program_with_io(['echo',"#include \"/test/data/sylib.h\""],output_file=self.tmp,outputmod="w")
            call_program_with_io(['cat',self.tsrc],output_file=self.tmp,outputmod="a")
            subprocess.run([self.stdcompiler,self.tmp,"-S",'-o',self.tasm],timeout=self.timeout)
            subprocess.run([self.stdcompiler,"-o",self.texe,self.tasm,self.lib],timeout=self.timeout)
        except:
            mylog.log(self.stdcompiler+" fail to compile at "+self.sy)
            # return False  #TODO ,暂时不使用标准编译器,
        # 我们的编译过程
        try:
            # TODO compiler testcase.sysy -S -o testcase.s
            with open(config.logPath,"a+") as f:
                myRet=subprocess.run([self.compiler,self.tsrc,"-S","-o",self.myasm],stderr=f,timeout=self.timeout)
                if myRet.returncode!=0:
                    mylog.log(myRet.stderr)
                    mylog.log("compiler fail to compile at "+self.sy)
                    return False
                myRet=subprocess.run([self.stdcompiler,"-o",self.myexe,self.myasm,self.lib],stderr=f,timeout=self.timeout)
                if myRet.returncode!=0:
                    mylog.log(myRet.stderr)
                    mylog.log("compiler fail to compile at "+self.sy)
                    return False
        except:
            mylog.log(self.compiler+" compile timeout at "+self.sy)
            return False
        
        try:
            if self.input!='':
                # TODO,统计执行时间，
                start_time = time.time()
                # 如果需要输入文件时
                # 执行标准编译器编译出来的程序
                stdRet=call_program_with_io(["qemu-riscv64","-L","/usr/riscv64-linux-gnu",self.texe],input_file=self.tin,output_file=self.tout,outputmod="w")
                end_time=time.time()
                self.std_exectime=end_time-start_time
                #执行用我们的编译器编译出来的程序
                start_time=time.time()
                myRet=call_program_with_io(["qemu-riscv64","-L","/usr/riscv64-linux-gnu",self.myexe],input_file=self.tin,output_file=self.myout,outputmod="w")
                end_time=time.time()
                self.my_exectime=end_time-start_time
            else:
                # 执行标准编译器编译出来的程序
                start_time = time.time()
                stdRet=call_program_with_io(["qemu-riscv64","-L","/usr/riscv64-linux-gnu",self.texe],output_file=self.tout,outputmod="w")
                end_time=time.time()
                self.std_exectime=end_time-start_time
                #执行用我们的编译器编译出来的程序
                start_time=time.time()
                myRet=call_program_with_io(["qemu-riscv64","-L","/usr/riscv64-linux-gnu",self.myexe],output_file=self.myout,outputmod="w")
                end_time=time.time()
                self.my_exectime=end_time-start_time
            # 把两个函数的返回值写入到函数结尾
        except:
            mylog.log("exe run time out at"+self.sy)
            return False
        # 把返回值写入l两个文件末尾
        # with open(self.tout,"")
        # if os.stat(self.tout).st_size == 0:
        #     call_program_with_io(["echo",str(stdRet)],output_file=self.tout,outputmod="a")
        # else:
        #     with open(self.tout,"a") as f:
        #         print("\n"+str(stdRet),file=f)
        call_program_with_io(["echo",str(stdRet.returncode)],output_file=self.tout,outputmod="a")
        call_program_with_io(["echo",str(myRet.returncode)],output_file=self.myout,outputmod="a")
        # 最后比较两个函数的返回值
        
        # TODO,用后来者去比对
        # if not cmp_file(self.tout,self.myout): #比较两个文件执行的输出,把比较结果输出到logfile中
        #     mylog.log("fail at "+self.sy)
        #     # 如果失败的话,提示失败原因
        #     return False
        if not cmp_file(self.out,self.myout):
            mylog.log("fail at "+self.sy)
            # 如果失败的话,提示失败原因
            return False
        logStr="pass "+self.sy+"\t\tmycost:"+str(self.my_exectime)+"\t\tstdcost:"+str(self.std_exectime)+""
        mylog.log(logStr,level=2)
        return True
   
if __name__ =="__main__":
    test("./data/functional")
    