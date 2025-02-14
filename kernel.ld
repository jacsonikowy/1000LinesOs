ENTRY(boot)

SECTIONS {
  /* Why 0x802 not 0x80 */
  . = 0x80200000;

  .text :{
    KEEP(*(.text.boot));
    *(.text .text.*);
  }

  .rodata : ALIGN(4) {
    *(.rodata .rodata.*);
  }

  .data : ALIGN(4) {
    *(.data .data.*);
  }

  .bss : ALIGN(4) {
    __bss = .; /* defining symbols */
    *(.bss .bss.* .sbss .sbss.*);
    __bss_end = .;
  }

  . = ALIGN(4);
  . += 128 * 1024; /* 128kB?? */
  __stack_top = .;

  . = ALIGN(4096);
  __free_ram = .;
  . += 64 * 1024 * 1024; /* 64MB */
  __free_ram_end = .;
}
