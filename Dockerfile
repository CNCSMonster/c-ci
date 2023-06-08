# 使用官方Python镜像作为基础镜像
FROM  cibase:1.0

# 设置工作目录
WORKDIR /test

#复制最新脚本
COPY ./test /test/

volume /test/data

# 开放端口,外界应该把实际端口映射到这个端口
EXPOSE 50051

# 安装依赖
# RUN pip install --no-cache-dir -r requirements.txt

# 设置环境变量
ENV PYTHONUNBUFFERED=1

CMD ["python3","server.py"]


