#Note: this code is different from the one in the pdf because this code is made to verify the result

.data
A: .word 0x00FFA5A5
B: .word 0xFFFF003C
N: .word 0xFFFFFFFF
out: .string "The result value of t1: "

.text
lw x22, N
lw t3, B
lw t2, A
xor x10, t2, t3             #XORing t2 and t3 and store the result in x10
xor t1, x10, x22           #getting !x10 (!(t2 XOR t3)) and store it in t1

la a0, out 
li a7, 4 
ecall

addi a0, t1, 0
li a7, 1
ecall