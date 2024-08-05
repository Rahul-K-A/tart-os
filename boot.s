// .section defines a new section of the file
// .text indicates that the section contains executable code 
.section .text

// Make start accessible from outside the file (for linking)
.global start

start:
    // Kind of fuzzy for now, but check if the code is being executed
    // by the RPi's main core, and allow kernel entry only for that core
    mrs x1, mpidr_el1
    and x1, x1, #3
    // Note: cmp sets the zero flag if the operands are equal
    cmp x0, #0
    // Note: beq -> Jump to the function in operand if zero flag is set
    beq kernel_entry

// This function gets executed once the start function is done by non-main cores
// For non-main core, neutralize the core by looping infintely
end:
    // b instruction jumps to the section defined in operand
    b end


kernel_entry:
    // Move the stack pointer to mem loc 80000
    // Stack pointer grows downwards (decrements) with each addition to the stack
    mov sp, #0x80000
    // Store the location of line 28 (which calls the end function)in the Link register 
    // and begin executing the actual kernel
    bl KMain
    b end


