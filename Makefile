compile: kernel.ld kernel.c
	riscv64-unknown-elf-gcc -Wall -Wextra -march=rv32imafd -mabi=ilp32 -T kernel.ld -ffreestanding -O2 -g3 -std=c11 -nostdlib -o kernel.elf kernel.c common.c

ld:
	riscv64-unknown-elf-ld -o 

run: kernel.elf
	qemu-system-riscv32 -nographic -serial mon:stdio -machine virt -bios default -kernel kernel.elf
	

clean:
	rm -rf kernel.elf kernel.o
