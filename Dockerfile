# 使用官方Python镜像作为基础镜像
FROM  iroazh/clang-riscv64

# 设置工作目录
WORKDIR /test

# 将test目录下的所有文件拷贝到容器的 /app 目录下
COPY ./test /test

# run apt-get install -y qemu-system

volume /test/data

# 安装依赖
# RUN pip install --no-cache-dir -r requirements.txt

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 开放端口
EXPOSE 5000


CMD ["/bin/bash"]

