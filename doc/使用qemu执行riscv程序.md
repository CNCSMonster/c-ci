### 一.如何使用qemu模拟执行riscv程序

```
qemu-riscv64 -L /usr/riscv64-linux-gnu ./texe < in > out
```

### 二.如何获取riscv执行程序后的返回值?

在使用QEMU模拟执行RISC-V程序时，你可以通过检查QEMU的退出状态来获取程序的返回值。QEMU会将程序的返回值作为其自己的退出状态返回给操作系统。

在Linux中，你可以使用 $? 变量来获取上一个命令的退出状态。

注意，QEMU的退出状态是一个整数，通常情况下，返回值为0表示程序正常退出，非零值表示程序异常退出。

### 如何下载qemu-riscv64

`apt install qemu-user`