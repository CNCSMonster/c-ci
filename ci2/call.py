import os

def get_all_file_paths(directory):
    file_paths = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            file_paths.append(file_path)
    return file_paths

# 获取所有测试单元,并按照字典顺序进行排序


# 测试单元
class Unit:
    # 默认超时时间2000毫秒
    def __init__(self,input="",sy="",timeout=2000):
        self.input=input
        self.sy=sy
        self.timeout=timeout
    # 测试该测试单元,执行前应该先指定使用的编译器
    def test(self):
        
        return False
   

if __name__=='__main__':
    # 传入命令行参数,文件夹名或者文件名
    pass