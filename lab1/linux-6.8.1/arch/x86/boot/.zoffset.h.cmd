savedcmd_arch/x86/boot/zoffset.h := nm arch/x86/boot/compressed/vmlinux | sed -n -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/$(pound)define ZO_\2 0x\1/p' > arch/x86/boot/zoffset.h
