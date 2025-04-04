%define ALIGN     (1 << 0)
%define MEMINFO   (1 << 1)
%define FLAGS     (ALIGN | MEMINFO)
%define MAGIC     0x1BADB002
%define CHECKSUM  -(MAGIC + FLAGS)

section .multiboot
    align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

section .bss
    align 16
stack_bottom:
    resb 16384 ; 16 KiB
stack_top:

section .text
    global _start
    _start:
        mov rsp, stack_top

        call _init

        call kernel_main
        cli
    .1:
        hlt
        jmp .1