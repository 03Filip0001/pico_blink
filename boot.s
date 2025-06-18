.section .text.boot
.global _start

.thumb
.extern _stack_top

_start:

    ldr r0, =_stack_top
    mov sp, r0
    bl main

@ rst_clear:
@     ldr r0, =0x40023000
@     mov r1, #32
@     str r1, [r0]

@ rst_done:
@     ldr r0, =0x40020008
@     ldr r1, [r0]
@     cmp r1, #0
@     beq rst_done

@ gpio_fun_sio:
@     ldr r0, =0x4002807c
@     mov r1, #5
@     str r1, [r0]

@ gpio_out_en:
@     ldr r0, =0xd0000038
@     mov r1, #1
@     lsl r1, r1, #15
@     str r1, [r0]

@     ldr r0, =0xd0000018
@     str r1, [r0]


_halt:
    wfe
    b _halt

.balign 256
