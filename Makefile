CC = riscv64-unknown-elf-gcc
OBJCOPY = riscv64-unknown-elf-objcopy

CFLAGS = -ffreestanding -O2 -Wall -Wextra -nostdlib

all: kernel.elf shell.bin

kernel.elf: kernel.c kernel.ld common.c
	$(CC) $(CFLAGS) -march=rv32imafd -mabi=ilp32 -T kernel.ld -g3 -std=c11 -o $@ kernel.c common.c

shell.elf: shell.c user.c user.ld
	$(CC) $(CFLAGS) -T user.ld -o $@ shell.c user.c common.c

shell.bin: shell.elf
	$(OBJCOPY) --set-section-flags .bss=alloc,contents -O binary $< $@

shell.bin.o: shell.bin
	$(OBJCOPY) -Ibinary -Oelf32-littleriscv $< $@


run: kernel.elf
	qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios default -kernel kernel.elf
	

clean:
	rm -rf kernel.elf kernel.o
