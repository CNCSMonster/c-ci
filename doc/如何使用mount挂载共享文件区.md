```docker

要在容器中挂载实际操作系统的文件夹，您可以使用 Dockerfile 中的 VOLUME 命令或在运行容器时使用 -v 参数。

以下是使用 Dockerfile 的示例：

FROM ubuntu:latest

# 挂载点
VOLUME /path/to/host/folder

CMD ["/bin/bash"]
复制代码
在上述示例中，VOLUME 命令指定了要在容器中创建的挂载点 /path/to/host/folder。这将允许您将容器内的文件或目录与实际操作系统的文件夹进行关联。

要构建该 Dockerfile 并运行容器，可以使用以下命令：

docker build -t my-container .
docker run -it -v /path/on/host:/path/to/host/folder my-container
复制代码
其中 /path/on/host 是实际操作系统上的文件夹路径，/path/to/host/folder 是容器中的挂载点路径。通过 -v 参数，将实际操作系统的文件夹与容器中的挂载点进行映射。这样，容器中的文件更改也会反映在实际操作系统的文件夹中，反之亦然。

请注意，使用 VOLUME 命令在 Dockerfile 中创建的挂载点是匿名挂载点，因此在运行容器时需要手动指定要挂载的实际操作系统的文件夹路径。
```