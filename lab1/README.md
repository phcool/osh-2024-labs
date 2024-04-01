文件结构中，bzImage文件位于linux-6.8.1/arch/x86_64/boot/bzImage
大小为3MB

phase2中的测试，打包为了initrd.cpio.gz，可以直接在lab1目录下输入命令

    qemu-system-x86_64 -kernel linux-6.8.1/arch/x86_64/boot/bzImage -initrd initrd.cpio.gz

phase3中的测试，打包为了initrd_.cpio.gz，可以直接在lab1目录下输入命令

    qemu-system-x86_64 -kernel linux-6.8.1/arch/x86_64/boot/bzImage -initrd initrd_.cpio.gz

其中phase3中的测试文件init.c的内容，
分为了两次系统调用，第一次参数为1，小于字符串的长度，故打印
the length is not enough
第二次参数为100，大于字符串长度，打印原字符串

