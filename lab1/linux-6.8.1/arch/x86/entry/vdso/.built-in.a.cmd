savedcmd_arch/x86/entry/vdso/built-in.a := rm -f arch/x86/entry/vdso/built-in.a;  printf "arch/x86/entry/vdso/%s " vma.o extable.o vdso-image-64.o | xargs ar cDPrST arch/x86/entry/vdso/built-in.a
