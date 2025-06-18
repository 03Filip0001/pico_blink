.section .text.boot
.global _start

.thumb
.extern _stack_top

_start:
    ldr r0, =_stack_top
    mov sp, r0
    bl main


_halt:
    wfe
    b _halt

.balign 256
