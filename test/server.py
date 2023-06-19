import ci_pb2;
import ci_pb2_grpc;
import grpc
import util

from concurrent import futures

class YourService(ci_pb2_grpc.GreeterServicer):
    def CallTest(self, request, context):
        # print(request.path)
        path:str=request.path
        if path=="all":
            retMsg=util.testall()
            return ci_pb2.TestReply(retMsg=str(retMsg))
        flag,path=path.split("#")
        # 对flag进行拆分
        flag=int(flag,10)
        ifOpt=False
        ifPer=False
        ifUpdCompiler=False
        if flag%10==1 :
            ifOpt=True
        if int(flag/10)%10==1:
            ifPer=True
        if int(flag/100)==1:
            ifUpdCompiler=True
        
        print(flag,path,ifUpdCompiler,ifPer,ifOpt)
        # 拿这个路径拼接成实际的测试路径
        path="/test/data/"+path
        if not ifPer:
            retMsg=util.test(path)
        else:
            retMsg=util.test_per(path)
        return ci_pb2.TestReply(retMsg=str(path))

server = grpc.server(futures.ThreadPoolExecutor())
ci_pb2_grpc.add_GreeterServicer_to_server(YourService(), server)
server.add_insecure_port('[::]:50051')
server.start()

while True:
    a=2
    continue