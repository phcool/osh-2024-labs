savedcmd_arch/x86/built-in.a := rm -f arch/x86/built-in.a;  printf "arch/x86/%s " entry/built-in.a events/built-in.a realmode/built-in.a kernel/built-in.a mm/built-in.a crypto/built-in.a platform/built-in.a net/built-in.a | xargs ar cDPrST arch/x86/built-in.a
