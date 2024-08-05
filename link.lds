/* Defines the start function defined in boot.s as
    the entry point of the executable */
ENTRY(start)
SECTIONS
{
    /* Load code at 0x80000 */
    . = 0x80000;

    .text :
    {
        *(.text)
    }

    /* Load Read-only data after the code */
    .rodata : 
    {
        *(.rodata)
    }

    /* Load the general data section next and align the data memory to 16bits */
    . = ALIGN(16);
    .data :
    {
        *(.data)
    }

    /* Load the bss section (storage for global and static variables)last */
    .bss :
    {
        *(.bss)
    }
}