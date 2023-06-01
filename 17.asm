#Assumptions: a = s0  ,  b = s1  ,  i = t0  ,  base address for D = s2 
#program design:
# 1) Initialize a counter x10 with a value of 10, which is the boundary for the loop.
# 2) Enter into a loop with the label 'Loop'.
# 3) Check if the value of register s1 (which contains the value of variable 'b') is greater than or equal to x10. If it is, jump to the label 'EXIT' and exit the loop.
# 4) If the value of s1 is less than x10, perform the following operations:
#       a) Multiply the value of s1 by 4 and store the result in register x3. This is done by using the slli (shift left logical immediate) instruction.
#       b) Add the value of s2 (which contains the base address of array D) and x3 to calculate the address of the ith element in array D. Store this address in register x4.
#       c) Add the values of s0 (which contains the value of variable 'a') and s1 to calculate the value of (a + b). Store this result in register x20.
#       d) Store the value of x20 in the memory location pointed by x4. This is done by using the sw (store word) instruction.
#       e) Increment the value of b by 1. This is done by using the addi (add immediate) instruction to add 1 to the value of x1 (which contains the value of variable 'b').
#       f) Jump to the label 'Loop' unconditionally. This is done by using the beq (branch if equal) instruction with the same source and target labels.

#Note: the upcoming four lines are not included in the pdf because they are made here to test the results only
.data
array: .word 0,0,0,0,0,0,0,0,0,0 
.text
la s2, array


addi x10, x0, 10       #x10 is the boundary of the for loop
Loop:
bge s1, x10, EXIT      #if b>= 10, move to EXIT
slli x3, s1, 2         #x3 = b * 4
add x4, s2, x3         #Address of element i in the array = x4 = s2 + x3
add x20, s0, s1        #x20 = a + b
sw x20, 0(x4)          #D[b] = x20
addi s1, s1, 1         #b = b + 1;
beq x0, x0, Loop       #unconditional jump to Loop

EXIT:
