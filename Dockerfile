# 使用官方Python镜像作为基础镜像
FROM  debian:bookworm

# 设置工作目录
WORKDIR /test

# 将test目录下的所有文件拷贝到容器的 /app 目录下
COPY ./test /test

# run apt-get install -y qemu-system

# copy /etc/apt/sources.list /etc/apt/sources.list

volume /test/data

# RUN apt update

# RUN apt-get update 

# RUN apt install qemu-user



# 安装依赖
# RUN pip install --no-cache-dir -r requirements.txt

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 开放端口
EXPOSE 5000


CMD ["/bin/bash"]

