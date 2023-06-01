#Assume x1 contains the base address for an array and x10 contains the size of the array.
#Assume that the size of the array is 10

#program design:
# 1) In the .data section, three variables are defined - output, array, max_out, and min_out. The output variable is a string that prompts the user to enter ten elements of an array. The array variable is an array of 10 words initialized with zero. The max_out and min_out variables are strings that will be used later to output the maximum and minimum values in the array.
# 2) In the .text section, the main function is defined. It starts with displaying the output message to the user using the la, li, and ecall instructions.
# 3) The input values are taken from the user and stored in the array using the loop_i loop. The loop_i loop iterates 10 times and uses the ecall instruction with a7=5 to read an integer from the user and store it in the current element of the array. The addi instruction is used to increment the pointer to the array.
# 4) The pointer x1 is set to point to the first element of the array, and two variables, x6 and x7, are initialized to hold the minimum and maximum values in the array, respectively.
# 5) A loop is initiated using the Loop label. The loop compares the current index i with the size of the array (10) using the bge instruction. If i is greater than or equal to 10, the loop exits and control is transferred to the EXIT label.
# 6) The slli instruction is used to compute the address of the current element in the array. The lw instruction is then used to load the current element into x5.
# 7) Two branches are used to compare x5 with the current minimum (x6) and maximum (x7) values. If x5 is less than x6, control is transferred to the Min label, where x6 is updated with the value of x5. If x5 is greater than x7, control is transferred to the Max label, where x7 is updated with the value of x5.
# 8) The loop index i is incremented using the addi instruction, and control is transferred back to the Loop label using the beq instruction.
# 9) The Min and Max labels update the minimum and maximum values and then transfer control back to the Loop label.
# 10) The EXIT label is reached after the loop has iterated through all elements of the array. The max_out and min_out messages are displayed to the user using the la, li, and ecall instructions. The maximum and minimum values are displayed using the addi, li, and ecall instructions.
# 11) The program terminates after displaying the maximum and minimum values.

.data 
output: .string "Please enter the elements of an array of size 10:\n" 
array: .word 0,0,0,0,0,0,0,0,0,0 
max_out: .string "The maximum number in the array is: "
min_out: .string "\nThe minimum number in the array is: "

.text
main:
  #displaying the first output message to the user
  la x1, array 	
  la a0, output    
  li a7, 4  
  ecall
  # taking the input values from the user
  addi t0, x1, 40
  Loop_i:
    li a7, 5
    ecall
    sw a0, 0(x1)
    addi x1, x1, 4
    bne t0, x1, Loop_i
    
  addi x1, x1, -40    #make x1 point to the first element of the array
  addi x10, x0, 10    #initialize the size of the array to 10
  lw x6, 0(x1)        #put first element of the array in x6 which will hold the min value
  lw x7, 0(x1)        #put first element of the array in x7 which will hold the max value
  addi x2, x0, 1      #the loop has an iterator let’s assume it is i. Here I initialized i = 1
  
Loop:
  bge x2, x10, EXIT   #if i >= the size of the array, move to EXIT
  slli x3, x2, 2      #x3 = i * 4
  add x4, x1, x3      #Address of element i in the array = x4 = x1 + x3
  lw x5, 0(x4)        #x5 = A[i]
  blt x5, x6, Min     #if x5 < x6 which is the minimum, move to Min
  blt x7, x5, Max     #if x7 which is the maximum < x5, move to Max
  addi x2, x2, 1      #i = i + 1;
  beq x0, x0, Loop    #unconditional jump to Loop
  
Min:
  add x6, x5, x0      #update the minimum with the value of x5
  beq x0, x0, Loop    #unconditional jump to Loop
  
Max:
  add x7, x5, x0      #update the maximum with the value of x5
  beq x0, x0, Loop    #unconditional jump to Loop
  
EXIT:
#displaying the maximum number of the array to the user
la a0, max_out  
li a7, 4 
ecall

addi a0, x7, 0 
li a7,1 
ecall 
#displaying the minimum number of the array to the user
la a0, min_out 
li a7, 4 
ecall

addi a0, x6, 0
li a7, 1
ecall

