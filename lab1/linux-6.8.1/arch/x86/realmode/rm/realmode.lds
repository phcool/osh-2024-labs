/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * This header exists to force full rebuild when the compiler is upgraded.
 *
 * When fixdep scans this, it will find this string "CONFIG_CC_VERSION_TEXT"
 * and add dependency on include/config/CC_VERSION_TEXT, which is touched
 * by Kconfig when the version string from the compiler changes.
 */
/* SPDX-License-Identifier: GPL-2.0 */
/*
 * Automatically generated file; DO NOT EDIT.
 * Linux/x86 6.8.1 Kernel Configuration
 */
/*
 * The use of "&&" / "||" is limited in certain expressions.
 * The following enable to calculate "and" / "or" with macro expansion only.
 */
/*
 * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
 * these only work with boolean and tristate options.
 */
/*
 * Getting something that works in C and CPP for an arg that may or may
 * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
 * we match on the placeholder define, insert the "0," for arg1 and generate
 * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
 * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
 * the last step cherry picks the 2nd arg, we get a zero.
 */
/*
 * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
 * otherwise. For boolean options, this is equivalent to
 * IS_ENABLED(CONFIG_FOO).
 */
/*
 * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
 * otherwise.  CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1" in
 * autoconf.h.
 */
/*
 * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
 * code can call a function defined in code compiled based on CONFIG_FOO.
 * This is similar to IS_ENABLED(), but returns false when invoked from
 * built-in code when CONFIG_FOO is set to 'm'.
 */
/*
 * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
 * 0 otherwise.  Note that CONFIG_FOO=y results in "#define CONFIG_FOO 1" in
 * autoconf.h, while CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1".
 */
/* SPDX-License-Identifier: GPL-2.0 */
/*
 * realmode.lds.S
 *
 * Linker script for the real-mode code
 */
/* SPDX-License-Identifier: GPL-2.0 */
/* SPDX-License-Identifier: GPL-2.0 */
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/* const.h: Macros for dealing with constants.  */
/* Some constant macros are used in both assembler and
 * C code.  Therefore we cannot annotate them always with
 * 'UL' and other type specifiers unilaterally.  We
 * use the following macros to deal with this.
 *
 * Similarly, _AT() will cast an expression with a type in C, but
 * leave it unchanged in asm.
 */
/* SPDX-License-Identifier: GPL-2.0 */
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/*
 * int-ll64 is used everywhere now.
 */
/* SPDX-License-Identifier: GPL-2.0 */
/*
 * asm-generic/int-ll64.h
 *
 * Integer declarations for architectures which use "long long"
 * for 64-bit types.
 */
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/*
 * asm-generic/int-ll64.h
 *
 * Integer declarations for architectures which use "long long"
 * for 64-bit types.
 */
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/* SPDX-License-Identifier: GPL-2.0 */
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/*
 * FIXME: The check currently breaks x86-64 build, so it's
 * temporarily disabled. Please fix x86-64 and reenable
 */
/*
 * small_const_nbits(n) is true precisely when it is known at compile-time
 * that BITMAP_SIZE(n) is 1, i.e. 1 <= n <= BITS_PER_LONG. This allows
 * various bit/bitmap APIs to provide a fast inline implementation. Bitmaps
 * of size 0 are very rare, and a compile-time-known-size 0 is most likely
 * a sign of error. They will be handled correctly by the bit/bitmap APIs,
 * but using the out-of-line functions, so that the inline implementations
 * can unconditionally dereference the pointer(s).
 */
/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * AMD Memory Encryption Support
 *
 * Copyright (C) 2016 Advanced Micro Devices, Inc.
 *
 * Author: Tom Lendacky <thomas.lendacky@amd.com>
 */
/* PAGE_SHIFT determines the page size */
/* Cast P*D_MASK to a signed type so that it is sign-extended if
   virtual addresses are 32-bits but physical addresses are larger
   (ie, 32-bit PAE). */
/* SPDX-License-Identifier: GPL-2.0 */
/*
 * The index for the tss.ist[] array. The hardware limit is 7 entries.
 */
/*
 * Set __PAGE_OFFSET to the most negative possible address +
 * PGDIR_SIZE*17 (pgd slot 273).
 *
 * The gap is to allow a space for LDT remap for PTI (1 pgd slot) and space for
 * a hypervisor (16 slots). Choosing 16 slots for a hypervisor is arbitrary,
 * but it's what Xen requires.
 */
/* See Documentation/arch/x86/x86_64/mm.rst for a description of the memory map. */
/* See task_size_max() in <asm/page_64.h> */
/* This decides where the kernel will search for a free chunk of vm
 * space during mmap's.
 */
/*
 * In spite of the name, KERNEL_IMAGE_SIZE is a limit on the maximum virtual
 * address for the kernel image, rather than the limit on the size itself.
 * This can be at most 1 GiB, due to the fixmap living in the next 1 GiB (see
 * level2_kernel_pgt in arch/x86/kernel/head_64.S).
 *
 * On KASLR use 1 GiB by default, leaving 1 GiB for modules once the
 * page tables are fully set up.
 *
 * If KASLR is disabled we can shrink it to 0.5 GiB and increase the size
 * of the modules area to 1.5 GiB.
 */
OUTPUT_FORMAT("elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(pa_text_start)
SECTIONS
{
 real_mode_seg = 0;
 . = 0;
 .header : {
  pa_real_mode_base = .;
  *(.header)
 }
 . = ALIGN(4);
 .rodata : {
  *(.rodata)
  *(.rodata.*)
  . = ALIGN(16);
  video_cards = .;
  *(.videocards)
  video_cards_end = .;
 }
 . = ALIGN((1 << 12));
 pa_text_start = .;
 .text : {
  *(.text)
  *(.text.*)
 }
 .text32 : {
  *(.text32)
  *(.text32.*)
 }
 .text64 : {
  *(.text64)
  *(.text64.*)
 }
 pa_ro_end = .;
 . = ALIGN((1 << 12));
 .data : {
  *(.data)
  *(.data.*)
 }
 . = ALIGN(128);
 .bss : {
  *(.bss*)
 }
 /* End signature for integrity checking */
 . = ALIGN(4);
 .signature : {
  *(.signature)
 }
 /DISCARD/ : {
  *(.note*)
  *(.debug*)
 }
pa_HEAP = HEAP;
pa_end_signature = end_signature;
pa_heap_end = heap_end;
pa_machine_real_restart_asm = machine_real_restart_asm;
pa_machine_real_restart_gdt = machine_real_restart_gdt;
pa_machine_real_restart_idt = machine_real_restart_idt;
pa_machine_real_restart_paging_off = machine_real_restart_paging_off;
pa_pa_trampoline_compat = pa_trampoline_compat;
pa_real_mode_header = real_mode_header;
pa_rm_heap = rm_heap;
pa_rm_stack = rm_stack;
pa_rm_stack_end = rm_stack_end;
pa_startup_32 = startup_32;
pa_startup_64 = startup_64;
pa_tr_compat = tr_compat;
pa_tr_cr4 = tr_cr4;
pa_tr_efer = tr_efer;
pa_tr_flags = tr_flags;
pa_tr_gdt = tr_gdt;
pa_tr_gdt64 = tr_gdt64;
pa_tr_lock = tr_lock;
pa_trampoline_header = trampoline_header;
pa_trampoline_pgd = trampoline_pgd;
pa_trampoline_start = trampoline_start;
pa_trampoline_start64 = trampoline_start64;
}
