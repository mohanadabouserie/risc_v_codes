#Note: this code is different from the one in the pdf because this code is made to verify the result

.data
A: .word 0x00000000
B: .word 0x00002222
C: .word 0x00001234
out: .string "The result value of A: "

.text
lw x2, A
lw x3, B
lw x4, C
beq x3, x0, ELSE
beq x0, x0, END

ELSE:
add x2, x4, x0

END:
la a0, out 
li a7, 4 
ecall

addi a0, x2, 0
li a7, 1
ecall