# Assumptions: a = s0  ,  b = s1  ,  i = t0  ,  base address for D = s2 
#program design:
# 1) t0 is used to store the current value of the loop counter i, and x10 is used to store the boundary value of the loop.
# 2) The code enters a loop by creating a label called Loop:. This label marks the beginning of the loop.
# 3) The code checks if the current value of i is greater than or equal to the boundary value. If this condition is true, the code jumps to the EXIT label to exit the loop.
# 4) If the condition in step 3 is false, the code executes the body of the loop, which adds the value of s0 to s1 and increments the value of i by 1.
# 5) After executing the loop body, the code jumps back to the Loop: label to repeat the loop.
addi t0, x0, 0          #Here I initialized i = 0
addi x10, x0, 10        #x10 is the boundary of the for loop
Loop:
bge t0, x10, EXIT       #if i >= the boundary, move to EXIT
add s1, s1, s0          #b+=a
addi t0, t0, 1          #i = i + 1;
beq x0, x0, Loop        #unconditional jump to Loop
EXIT:
