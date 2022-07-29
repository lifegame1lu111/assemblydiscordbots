.global main

.text
handler:
	stp x29, x30, [sp, -16]!
	mov x19, x0
	mov x20, x1
	ldr x1, [x1, 24]
	ldr x1, [x1, 32]
	tst x1, x1
	b.eq not_bot
	b bot
not_bot:
	adrp x3, msg
	add x3, x3, :lo12:msg
	mov x0, x19
	ldr x1, [x20, 8]
	ldr x2, [x20, 40]
	str x2, [x3]
	mov x2, x3
	mov x3, xzr
	bl discord_create_message
bot:	
	ldp x29, x30, [sp], 16
	ret

main:
	stp x29, x30, [sp, -16]!
	adrp x0, token
	add x0, x0, :lo12:token
	bl discord_init
	mov x19, x0
	adrp x1, handler
	add x1, x1, :lo12:handler
	bl discord_set_on_message_create
	mov x0, x19
	bl discord_run
	ldp x29, x30, [sp], 16
	ret

.data
token:
	.string "TOKEN GOES HERE"
	.align 4
msg:
	.quad 0
	.byte 0
	.align 3
	.quad 0, 0, 0, 0, 0, 0, 0	
