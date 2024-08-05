# Compile the .S to .o (object) file
aarch64-linux-gnu-gcc -c boot.s -o boot.o

# Compile the main.c file
# -ffreestanding -> No stdlib (prints,etc)
# -mgeneral-regs-only -> Prevent compiler from using floating point regs and other advanced registers
aarch64-linux-gnu-gcc -std=c99 -ffreestanding -mgeneral-regs-only -c main.c

# Link everything with the .lds linker script(no stdlib)
# Name of the output linked object-> kernel
# Things to link boot.o, main.o
# Boot section always has to be linked first so that it is first in memory
aarch64-linux-gnu-ld -nostdlib -T link.lds -o kernel boot.o main.only

# Convert binary object to .img format
aarch64-linux-gnu-objcopy -O binary kernel kernel8.img