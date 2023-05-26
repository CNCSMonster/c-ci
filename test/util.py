import os
import subprocess
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
    for testunit in testunits :
        if not testunit.test():
            mylog.log("test "+path+ " fail! "+num+"/"+len(testunits))
            return False
        num+=1
    mylog.log("test "+path+" fail!")
    return True

            
def call_program_with_io(command=['./texe'],input_file="", output_file="",outputmod="w+"):
    if input_file=="" and output_file=="":
        return subprocess.run(command).returncode
    elif output_file=="":
        with open(input_file, 'r') as input_f:
            return subprocess.run(command, stdin=input_f, text=True).returncode
    elif input_file=="":
        with open(output_file, outputmod) as output_f:
            return subprocess.run(command, stdout=output_f, text=True).returncode
    else:   
        with open(input_file, 'r') as input_f:
            with open(output_file, outputmod) as output_f:
                return subprocess.run(command, stdin=input_f, stdout=output_f, text=True).returncode

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
    tin="/test/data/tin"  #目标可执行程序的输入路径
    tout="/test/data/tout" #目标可执行程序的输出路径
    tsrc="/test/data/t.c"   #目标sy程序
    texe="/test/data/texe" #目标可执行程序的路径
    myexe="/test/data/mexe"    #我们可执行程序的路径
    myasm="/test/data/myasm.s"  #我们的汇编路径
    myout="/test/data/mout"    #我们输出的路径
    logfile="/test/data/exe.log"    #查看的路径
    timeout=1000000  #设计个执行超时时间
    
    
    def __init__(self,input="",out="",sy=""):
        self.input=input
        self.out=out
        self.sy=sy

   
    
    # 测试该测试单元,执行前应该先指定使用的编译器
    def test(self):
        # 复制对应路径的内容到当前路径下
        subprocess.run(["cp",self.input,self.tin])
        subprocess.run(["cp",self.out,self.tout])
        subprocess.run(["touch",self.tmp])
        call_program_with_io(["echo","#include \"../t.h\""],output_file=self.tmp)
        call_program_with_io(['cat',self.sy],output_file= self.tmp)
        # 先对源代码进行预处理,去掉宏
        subprocess.run([self.stdcompiler,"-E","-P",self.tmp,"-o",self.tsrc])
        
        #标准编译过程
        try:
            subprocess.run([self.stdcompiler,"-o",self.texe,self.tsrc,self.lib],timeout=self.timeout)
        except:
            mylog.log(self.stdcompiler+" fail to compile")
            return False
        # 我们的编译过程
        try:
            # TODO compiler testcase.sysy -S -o testcase.s
            subprocess.run([self.compiler,self.tsrc,"-S","-o",self.myasm],timeout=self.timeout)
            subprocess.run([self.stdcompiler,"-o",self.myexe,self.myasm,self.lib],timeout=self.timeout)
        except:
            mylog.log(self.compiler+" fail to compile")
            return False
        stdRet=0
        myRet=0
        try:
            if self.input!='':
                # 如果需要输入文件时
                # 执行标准编译器编译出来的程序
                stdRet=call_program_with_io(["qemu-riscv64","-L","/usr/riscv64-linux-gnu",self.texe],input_file=self.tin,output_file=self.tout,outputmod="w")
                #执行用我们的编译器编译出来的程序
                myRet=call_program_with_io(["qemu-riscv64","-L","/usr/riscv64-linux-gnu",self.myexe],input_file=self.tin,output_file=self.myout,outputmod="w")
            else:
                # 执行标准编译器编译出来的程序
                stdRet=call_program_with_io(["qemu-riscv64","-L","/usr/riscv64-linux-gnu",self.texe],output_file=self.tout,outputmod="w")
                #执行用我们的编译器编译出来的程序
                myRet=call_program_with_io(["qemu-riscv64","-L","/usr/riscv64-linux-gnu",self.myexe],output_file=self.myout,outputmod="w")
            # 把两个函数的返回值写入到函数结尾
        except:
            mylog.log("exe run time out")
            return False
        # 把返回值写入l两个文件末尾
        call_program_with_io(["echo",str(stdRet)],output_file=self.tout)
        call_program_with_io(["echo",str(myRet)],output_file=self.myout)
        # 最后比较两个函数的返回值
        if not cmp_file(self.tout,self.myout): #比较两个文件执行的输出,把比较结果输出到logfile中
            return False
        mylog.log("pass",self.sy,level=2)
        return True
    
a =Unit(sy="./data/t.c",input="./data/in",out="./data/out")

a.test()
# cmp_file("a.txt","b.txt","0.txt") #test
