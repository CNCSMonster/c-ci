import ci_pb2;
import ci_pb2_grpc;
import grpc
import util

from concurrent import futures

class YourService(ci_pb2_grpc.GreeterServicer):
    def CallTest(self, request, context):
        # print(request.path)
        # 拿这个路径拼接成实际的测试路径
        path="/test/data/"+request.path
        # 进行测试
        retMsg=util.test(path)
        return ci_pb2.TestReply(retMsg=retMsg)

server = grpc.server(futures.ThreadPoolExecutor())
ci_pb2_grpc.add_GreeterServicer_to_server(YourService(), server)
server.add_insecure_port('[::]:50051')
server.start()

while True:
    a=2
    continue