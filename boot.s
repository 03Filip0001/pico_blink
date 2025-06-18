.section .text.picobin_block, "a"
.global picobin_block
picobin_block:
    .word 0xffffded3


    .byte 0x42 // PICOBIN_BLOCK_ITEM_1BS_IMAGE_TYPE
    .byte 0x1 // item is 1 word
    // Try Before You Buy - 0 (not set)
    // Chip - b001 (RP2350)
    // reserved - 0b0
    // CPU - b000 (ARM)
    // reserved - 0b00
    // EXE Security - 0b10 (Secure mode)
    // Image Type - 0b0001 (EXE)
    .hword 0b0001000000100001

    // item 1 LAST

    .byte 0xff // PICOBIN_BLOCK_ITEM_2BS_LAST
    .hword 0x0001 // item is 1 word
    .byte 0 // pad

    // relative pointer to next block in loop
    // 0 means a link to itself, meaning there is no other block
    .word 0

    .word 0xab123579 // PICOBIN_BLOCK_MARKER_END

.section .text.boot, "ax"
.global _start

.thumb
.extern _stack_top

_start:
    @ ldr r0, =_stack_top
    @ mov sp, r0
    @ bl main

rst_clear:
    ldr r0, =0x40023000
    mov r1, #32
    str r1, [r0]

rst_done:
    ldr r0, =0x40020008
    ldr r1, [r0]
    cmp r1, #0
    beq rst_done

gpio_fun_sio:
    ldr r0, =0x4002807c
    mov r1, #5
    str r1, [r0]

gpio_out_en:
    ldr r0, =0xd0000038
    mov r1, #1
    lsl r1, r1, #15
    str r1, [r0]

    ldr r0, =0xd0000018
    str r1, [r0]


_halt:
    wfe
    b _halt

.balign 256
