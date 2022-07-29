	.global main

	.text
	.align 3
handler:
	ldr x8, [x1, 24]
	ldr x8, [x8, 32]
	cbz x8, not_bot
	ret
not_bot:
	adrp x3, msg
	add x3, x3, :lo12:msg
	ldr x2, [x1, 40]
	ldr x1, [x1, 8]
	str x2, [x3]
	mov x2, x3
	mov x3, xzr
	b discord_create_message

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
	.align 3
token:
	.string "TOKEN GOES HERE"
	.align 3
msg:
	.quad 0
	.byte 0
	.zero 7
	.quad 0, 0, 0, 0, 0, 0, 0
