#Assuming the base addresses of arrays A and B are in registers x20 and x21 respectively and that variable n is in register x22

#Note: the upcoming six lines are not included in the pdf because they are made here to test the results only
.data
A: .word 0,1,200,3
B: .word 300,100,200,8,7,9,10,11,12,13,14 
.text
la x20, A
la x21, B

addi x22, x0, 200    #n = 200
lw x1, 8(x20)        #storing the value of A[2] in x1
lw x2, 8(x21)        #storing the value of B[2] in x2
add x3, x1, x2       #x3 = A[2] + B[2]
lw x4, 16(x21)       #storing the value of B[4] in x4
add x5, x22, x4      #x5 = B[4] + n
addi x6, x5, -7      #x6 = x5 – 7 = B[4] + n - 7
div x7, x3, x6       #x7 = x3/x6 = (A[2] + B[2]) / (B[4] + n - 7)
sw x7, 40(x21),      #B[10] = x7 = (A[2] + B[2]) / (B[4] + n - 7)
