	.file	"asm-offsets.c"
# GNU C11 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -march=x86-64 -O2 -std=gnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fcf-protection=none -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fno-stack-protector -fomit-frame-pointer -fno-stack-clash-protection -falign-functions=16 -fno-strict-overflow -fstack-check=no -fconserve-stack
	.text
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
# arch/x86/kernel/asm-offsets_64.c:29: 	ENTRY(bx);
#APP
# 29 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_bx $40 offsetof(struct pt_regs, bx)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:30: 	ENTRY(cx);
# 30 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_cx $88 offsetof(struct pt_regs, cx)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:31: 	ENTRY(dx);
# 31 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_dx $96 offsetof(struct pt_regs, dx)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:32: 	ENTRY(sp);
# 32 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_sp $152 offsetof(struct pt_regs, sp)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:33: 	ENTRY(bp);
# 33 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_bp $32 offsetof(struct pt_regs, bp)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:34: 	ENTRY(si);
# 34 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_si $104 offsetof(struct pt_regs, si)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:35: 	ENTRY(di);
# 35 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_di $112 offsetof(struct pt_regs, di)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:36: 	ENTRY(r8);
# 36 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_r8 $72 offsetof(struct pt_regs, r8)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:37: 	ENTRY(r9);
# 37 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_r9 $64 offsetof(struct pt_regs, r9)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:38: 	ENTRY(r10);
# 38 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_r10 $56 offsetof(struct pt_regs, r10)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:39: 	ENTRY(r11);
# 39 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_r11 $48 offsetof(struct pt_regs, r11)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:40: 	ENTRY(r12);
# 40 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_r12 $24 offsetof(struct pt_regs, r12)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:41: 	ENTRY(r13);
# 41 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_r13 $16 offsetof(struct pt_regs, r13)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:42: 	ENTRY(r14);
# 42 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_r14 $8 offsetof(struct pt_regs, r14)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:43: 	ENTRY(r15);
# 43 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_r15 $0 offsetof(struct pt_regs, r15)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:44: 	ENTRY(flags);
# 44 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->pt_regs_flags $144 offsetof(struct pt_regs, flags)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:45: 	BLANK();
# 45 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->"
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:49: 	ENTRY(cr0);
# 49 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->saved_context_cr0 $200 offsetof(struct saved_context, cr0)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:50: 	ENTRY(cr2);
# 50 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->saved_context_cr2 $208 offsetof(struct saved_context, cr2)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:51: 	ENTRY(cr3);
# 51 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->saved_context_cr3 $216 offsetof(struct saved_context, cr3)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:52: 	ENTRY(cr4);
# 52 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->saved_context_cr4 $224 offsetof(struct saved_context, cr4)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:53: 	ENTRY(gdt_desc);
# 53 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->saved_context_gdt_desc $266 offsetof(struct saved_context, gdt_desc)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:54: 	BLANK();
# 54 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->"
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:57: 	BLANK();
# 57 "arch/x86/kernel/asm-offsets_64.c" 1
	
.ascii "->"
# 0 "" 2
# arch/x86/kernel/asm-offsets_64.c:64: }
#NO_APP
	xorl	%eax, %eax	#
	ret	
	.size	main, .-main
	.text
	.p2align 4
	.type	common, @function
common:
# arch/x86/kernel/asm-offsets.c:36: 	BLANK();
#APP
# 36 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->"
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:37: 	OFFSET(TASK_threadsp, task_struct, thread.sp);
# 37 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TASK_threadsp $1944 offsetof(struct task_struct, thread.sp)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:42: 	BLANK();
# 42 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->"
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:43: 	OFFSET(pbe_address, pbe, address);
# 43 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->pbe_address $0 offsetof(struct pbe, address)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:44: 	OFFSET(pbe_orig_address, pbe, orig_address);
# 44 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->pbe_orig_address $8 offsetof(struct pbe, orig_address)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:45: 	OFFSET(pbe_next, pbe, next);
# 45 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->pbe_next $16 offsetof(struct pbe, next)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:70: 	BLANK();
# 70 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->"
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:71: 	OFFSET(TDX_MODULE_rcx, tdx_module_args, rcx);
# 71 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_rcx $0 offsetof(struct tdx_module_args, rcx)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:72: 	OFFSET(TDX_MODULE_rdx, tdx_module_args, rdx);
# 72 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_rdx $8 offsetof(struct tdx_module_args, rdx)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:73: 	OFFSET(TDX_MODULE_r8,  tdx_module_args, r8);
# 73 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_r8 $16 offsetof(struct tdx_module_args, r8)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:74: 	OFFSET(TDX_MODULE_r9,  tdx_module_args, r9);
# 74 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_r9 $24 offsetof(struct tdx_module_args, r9)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:75: 	OFFSET(TDX_MODULE_r10, tdx_module_args, r10);
# 75 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_r10 $32 offsetof(struct tdx_module_args, r10)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:76: 	OFFSET(TDX_MODULE_r11, tdx_module_args, r11);
# 76 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_r11 $40 offsetof(struct tdx_module_args, r11)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:77: 	OFFSET(TDX_MODULE_r12, tdx_module_args, r12);
# 77 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_r12 $48 offsetof(struct tdx_module_args, r12)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:78: 	OFFSET(TDX_MODULE_r13, tdx_module_args, r13);
# 78 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_r13 $56 offsetof(struct tdx_module_args, r13)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:79: 	OFFSET(TDX_MODULE_r14, tdx_module_args, r14);
# 79 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_r14 $64 offsetof(struct tdx_module_args, r14)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:80: 	OFFSET(TDX_MODULE_r15, tdx_module_args, r15);
# 80 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_r15 $72 offsetof(struct tdx_module_args, r15)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:81: 	OFFSET(TDX_MODULE_rbx, tdx_module_args, rbx);
# 81 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_rbx $80 offsetof(struct tdx_module_args, rbx)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:82: 	OFFSET(TDX_MODULE_rdi, tdx_module_args, rdi);
# 82 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_rdi $88 offsetof(struct tdx_module_args, rdi)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:83: 	OFFSET(TDX_MODULE_rsi, tdx_module_args, rsi);
# 83 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TDX_MODULE_rsi $96 offsetof(struct tdx_module_args, rsi)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:85: 	BLANK();
# 85 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->"
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:86: 	OFFSET(BP_scratch, boot_params, scratch);
# 86 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->BP_scratch $484 offsetof(struct boot_params, scratch)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:87: 	OFFSET(BP_secure_boot, boot_params, secure_boot);
# 87 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->BP_secure_boot $492 offsetof(struct boot_params, secure_boot)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:88: 	OFFSET(BP_loadflags, boot_params, hdr.loadflags);
# 88 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->BP_loadflags $529 offsetof(struct boot_params, hdr.loadflags)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:89: 	OFFSET(BP_hardware_subarch, boot_params, hdr.hardware_subarch);
# 89 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->BP_hardware_subarch $572 offsetof(struct boot_params, hdr.hardware_subarch)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:90: 	OFFSET(BP_version, boot_params, hdr.version);
# 90 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->BP_version $518 offsetof(struct boot_params, hdr.version)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:91: 	OFFSET(BP_kernel_alignment, boot_params, hdr.kernel_alignment);
# 91 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->BP_kernel_alignment $560 offsetof(struct boot_params, hdr.kernel_alignment)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:92: 	OFFSET(BP_init_size, boot_params, hdr.init_size);
# 92 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->BP_init_size $608 offsetof(struct boot_params, hdr.init_size)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:93: 	OFFSET(BP_pref_address, boot_params, hdr.pref_address);
# 93 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->BP_pref_address $600 offsetof(struct boot_params, hdr.pref_address)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:95: 	BLANK();
# 95 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->"
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:96: 	DEFINE(PTREGS_SIZE, sizeof(struct pt_regs));
# 96 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->PTREGS_SIZE $168 sizeof(struct pt_regs)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:99: 	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);
# 99 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TLB_STATE_user_pcid_flush_mask $22 offsetof(struct tlb_state, user_pcid_flush_mask)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:102: 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
# 102 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->CPU_ENTRY_AREA_entry_stack $4096 offsetof(struct cpu_entry_area, entry_stack_page)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:103: 	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
# 103 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->SIZEOF_entry_stack $4096 sizeof(struct entry_stack)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:104: 	DEFINE(MASK_entry_stack, (~(sizeof(struct entry_stack) - 1)));
# 104 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->MASK_entry_stack $-4096 (~(sizeof(struct entry_stack) - 1))"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:107: 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
# 107 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TSS_sp0 $4 offsetof(struct tss_struct, x86_tss.sp0)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:108: 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
# 108 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TSS_sp1 $12 offsetof(struct tss_struct, x86_tss.sp1)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:109: 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
# 109 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->TSS_sp2 $20 offsetof(struct tss_struct, x86_tss.sp2)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:110: 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
# 110 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->X86_top_of_stack $16 offsetof(struct pcpu_hot, top_of_stack)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:111: 	OFFSET(X86_current_task, pcpu_hot, current_task);
# 111 "arch/x86/kernel/asm-offsets.c" 1
	
.ascii "->X86_current_task $0 offsetof(struct pcpu_hot, current_task)"	#
# 0 "" 2
# arch/x86/kernel/asm-offsets.c:123: }
#NO_APP
	ret	
	.size	common, .-common
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
