format MS64 COFF

include "win64ax.inc"

public main

extrn discord_init
extrn discord_run
extrn discord_create_message
extrn discord_set_on_message_create

section ".data" data readable writable
    array: 
        times 9 dq 0
    token db "TOKEN GOES HERE", 0

section ".text" code readable executable
proc handler uses rsi rdi
    mov rsi, rcx
    mov rdi, rdx
    sub rsp, 32
    mov rdx, [rdi + 24]
    cmp byte [rdx + 32], 0
    jz not_bot
    jmp skip
not_bot:
    mov rax, [rdi + 40]
    mov [array], rax
    mov rcx, rsi
    mov rdx, [rdi + 8]
    lea r8, [array]
    xor r9, r9
    call discord_create_message
skip:
    add rsp, 32
    ret
endp

proc main uses rsi
    sub rsp, 32
    lea rcx, [token]
    call discord_init
    mov rsi, rax
    mov rcx, rax
    lea rdx, [handler]
    call discord_set_on_message_create
    mov rcx, rsi
    call discord_run
    add rsp, 32
    ret
endp
