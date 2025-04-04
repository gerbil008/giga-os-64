/* The bootloader will look at this image and start execution at the symbol
   designated at the entry point. */
ENTRY(_start)

/* Tell where the various sections of the object files will be put in the final
   kernel image. */
SECTIONS
{
    /* Begin putting sections at 1 MiB, a conventional place for kernels to be
       loaded at by the bootloader. */
    . = 1M;

    /* First put the multiboot header, as it is required to be put very early
       early in the image or the bootloader won't recognize the file format.
       Next we'll put the .text section. */
    .text BLOCK(4K) : ALIGN(4K)
    {
        *( .multiboot )          /* Multiboot header for GRUB compatibility */
        *( .text )               /* Kernel code */
    }

    /* Read-only data section for strings and constants. */
    .rodata BLOCK(4K) : ALIGN(4K)
    {
        *( .rodata )             /* Read-only data (strings, constants) */
    }

    /* Read-write data section for initialized variables. */
    .data BLOCK(4K) : ALIGN(4K)
    {
        *( .data )               /* Initialized data */
    }

    /* Read-write data section for uninitialized variables (BSS). */
    .bss BLOCK(4K) : ALIGN(4K)
    {
        *( COMMON )              /* Uninitialized global variables */
        *( .bss )                /* BSS section (uninitialized) */
    }

    /* Align to a 4KB boundary for page table structures (optional, depending on architecture). */
    . = ALIGN(4096);
    /* For 64-bit, you may want to reserve space for page tables or kernel structures here. */

    /* Kernel will be loaded at this address for 64-bit execution. */
    . = 2M;                    /* Setting 2 MiB as a possible new address (for kernel data, etc.) */
}
/* The bootloader will look at this image and start execution at the symbol
   designated at the entry point. */
ENTRY(_start)

/* Tell where the various sections of the object files will be put in the final
   kernel image. */
SECTIONS
{
    /* Begin putting sections at 1 MiB, a conventional place for kernels to be
       loaded at by the bootloader. */
    . = 1M;

    /* First put the multiboot header, as it is required to be put very early
       early in the image or the bootloader won't recognize the file format.
       Next we'll put the .text section. */
    .text BLOCK(4K) : ALIGN(4K)
    {
        *( .multiboot )          /* Multiboot header for GRUB compatibility */
        *( .text )               /* Kernel code */
    }

    /* Read-only data section for strings and constants. */
    .rodata BLOCK(4K) : ALIGN(4K)
    {
        *( .rodata )             /* Read-only data (strings, constants) */
    }

    /* Read-write data section for initialized variables. */
    .data BLOCK(4K) : ALIGN(4K)
    {
        *( .data )               /* Initialized data */
    }

    /* Read-write data section for uninitialized variables (BSS). */
    .bss BLOCK(4K) : ALIGN(4K)
    {
        *( COMMON )              /* Uninitialized global variables */
        *( .bss )                /* BSS section (uninitialized) */
    }

    /* Align to a 4KB boundary for page table structures (optional, depending on architecture). */
    . = ALIGN(4096);
    /* For 64-bit, you may want to reserve space for page tables or kernel structures here. */

    /* Kernel will be loaded at this address for 64-bit execution. */
    . = 2M;                    /* Setting 2 MiB as a possible new address (for kernel data, etc.) */
}
