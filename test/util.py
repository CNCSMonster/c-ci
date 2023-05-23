import os
import subprocess

def get_all_file_paths(directory):
    file_paths = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            file_paths.append(file_path)
    return file_paths




def call_program_with_io(command=['./texe'],input_file="0.in", output_file="0.out"):
    with open(input_file, 'r') as input_f:
        with open(output_file, 'w') as output_f:
            subprocess.run(command, stdin=input_f, stdout=output_f, text=True)



# 比较两个文件,输出不同之处在logFile中
def cmp_file(path1,path2,logFile):
    with open(path1, 'r') as f1:
        with open(path2,'r') as f2:
            with open(logFile,'w') as f3:
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
#

# 测试单元
class Unit:
    compiler="" #指定自己要使用的编译器
    stdcompiler="riscv64-linux-gnu-gcc" #指定对比使用的标准编译器
    asmbler="as"  #指定使用的汇编器
    linker="ld"   #指定使用的链接器
    tin="/test/data/tin"  #目标可执行程序的输入路径
    tout="/test/data/tout" #目标可执行程序的输出路径
    tsrc="/test/data/t.c"   #目标sy程序
    texe="/test/data/texe" #目标可执行程序的路径
    myexe="/test/data/mexe"    #我们可执行程序的路径
    myasm="/test/data/myasm.s"  #我们的汇编路径
    myout="/test/data/mout"    #我们输出的路径
    
    
    def __init__(self,input="",out="",sy=""):
        self.input=input
        self.out=out
        self.sy=sy
    # 测试该测试单元,执行前应该先指定使用的编译器
    def test(self):
        # 复制对应路径的内容到当前路径下
        subprocess.run(["cp",self.input,self.tin])
        subprocess.run(["cp",self.out,self.tout])
        subprocess.run(["echo",self.sy,">>",self.tsrc])
        
        #标准编译过程
        try:
            subprocess.run([self.stdcompiler,"-o",self.texe,self.tsrc,"/test/data/libsysy.a"])
        except:
            print(self.stdcompiler,"fail to compile")
            return False
        # 我们的编译过程
        try:
            # TODO
            subprocess.run([self.compiler,"-c",self.myasm,self.tsrc])
            subprocess.run([self.stdcompiler,""])
        except:
            print(self.compiler,"fail to compile")
            return False
            
        return True
    
    
a =Unit()

# cmp_file("a.txt","b.txt","0.txt") #test
