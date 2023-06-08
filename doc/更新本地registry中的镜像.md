# 更新registry中的镜像

### 一.使用docker tag打标签

### 二.使用docker rmi去掉镜像标签

去掉这个镜像所有标签后才会把这个镜像从仓库删除

### 三.往私有registry中上传image

往私有的registry中上传image

一定要给上传的镜像打上 `<your registry domain>/` 开头的标签

或者打上`<your registry ip address>:<port>/` 开头的标签

不然会默认上传到docker.io，而不是上传到你本地的registry中

