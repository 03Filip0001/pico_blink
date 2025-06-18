ENTRY(_start)

MEMORY{
    FLASH (rx) : ORIGIN = 0x10000000, LENGTH = 4M
    RAM   (rwx): ORIGIN = 0x20000000, LENGTH = 520K
}

_stack_top = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS {
    .boot : ALIGN(256){ 
        KEEP(*(.text.boot))
    } > FLASH
    
    .text : { 
        KEEP(*(.text*)) 
    } > FLASH
  
    .rodata : { 
        *(.rodata*) 
    } > FLASH  

    .data : { 
        *(.data*) 
    } > RAM AT > FLASH

    .bss : { 
        *(.bss*) *(COMMON) 
    } > RAM
}