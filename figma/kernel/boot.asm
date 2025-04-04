[BITS 32]
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

section .text
global _start
extern kernel_main

_start:
    cli
    mov esp, stack_top

    call enable_paging

    lgdt [gdt64_pointer]

    ; Enable long mode in EFER MSR
    mov ecx, 0xC0000080
    rdmsr
    or eax, (1 << 8)
    wrmsr

    ; Enable PAE
    mov eax, cr4
    or eax, (1 << 5)
    mov cr4, eax

    ; Enable paging
    mov eax, cr0
    or eax, (1 << 31)
    mov cr0, eax

    ; Far jump to 64-bit mode
    jmp 0x08:long_mode_entry

enable_paging:
    ; Set up page tables
    mov eax, pml4_table
    mov cr3, eax
    ret

[BITS 64]
long_mode_entry:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov rsp, stack_top
    call kernel_main
.hang:
    hlt
    jmp .hang

section .rodata
gdt64:
    dq 0                          ; Null descriptor
    dq 0x00af9a000000ffff         ; Code segment
    dq 0x00af92000000ffff         ; Data segment

gdt64_pointer:
    dw gdt64_end - gdt64 - 1
    dd gdt64                      ; low 32 bits of address
    dd 0                          ; high 32 bits

gdt64_end:

section .bss
align 4096
pml4_table:
    resq 512
pdpt_table:
    resq 512
pd_table:
    resq 512

align 16
stack_bottom:
    resb 16384
stack_top:
