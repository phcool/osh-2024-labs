savedcmd_arch/x86/kernel/cpu/built-in.a := rm -f arch/x86/kernel/cpu/built-in.a;  printf "arch/x86/kernel/cpu/%s " cacheinfo.o scattered.o topology.o common.o rdrand.o match.o bugs.o aperfmperf.o cpuid-deps.o umwait.o proc.o capflags.o powerflags.o feat_ctl.o intel.o intel_pconfig.o tsx.o intel_epb.o amd.o hygon.o centaur.o zhaoxin.o mtrr/built-in.a microcode/built-in.a perfctr-watchdog.o debugfs.o | xargs ar cDPrST arch/x86/kernel/cpu/built-in.a
