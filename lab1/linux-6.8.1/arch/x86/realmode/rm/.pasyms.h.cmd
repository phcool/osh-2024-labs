savedcmd_arch/x86/realmode/rm/pasyms.h := nm arch/x86/realmode/rm/header.o arch/x86/realmode/rm/trampoline_64.o arch/x86/realmode/rm/stack.o arch/x86/realmode/rm/reboot.o | sed -n -r -e 's/^([0-9a-fA-F]+) [ABCDGRSTVW] (.+)$$/pa_\2 = \2;/p' | sort | uniq > arch/x86/realmode/rm/pasyms.h
