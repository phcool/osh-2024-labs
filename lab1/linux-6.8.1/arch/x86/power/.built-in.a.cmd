savedcmd_arch/x86/power/built-in.a := rm -f arch/x86/power/built-in.a;  printf "arch/x86/power/%s " cpu.o | xargs ar cDPrST arch/x86/power/built-in.a
