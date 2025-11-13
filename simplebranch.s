main:
	ori s0, x0, 0x123
	nop
	nop
	j skip
	nop
	nop
	li s0, 0xffffffff

skip:
	ori s1, x0, 0x123
	nop
	nop
	beq s0, s1, skip2
	li s0, 0xffffffff

skip2:
	jal fun
	ori s3, x0, 0x123
	nop
	nop	
	beq s0, x0, exit
	nop
	nop
	ori s4, x0, 0x123
	nop
	nop
	j exit

fun:
	ori s2, x0, 0x123
	jr ra

exit:
	wfi

