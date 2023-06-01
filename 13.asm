#Assume that the input number will be stored in x5. 

#Program design:
# 1) Define the necessary data items in the .data section of the code. Here, the output message, input number, and three different strings are defined as output, input, even, odd_prime, and odd_notprime, respectively.
# 2) Start the .text section and define the main function.
# 3) Print the output message on the console using the la and li instructions.
# 4) Read the input number entered by the user and store it in the input memory location using the la and li instructions.
# 5) Copy the input value from the input memory location to the x5 register using the add instruction.
# 6) Initialize the loop iterator, i, to 3 by adding 3 to the x0 register and storing it in the x6 register.
# 7) Divide the input number by 2 using the srli instruction and store it in the x7 register to use it as the loop boundary for finding if the number is prime or not.
# 8) Check if the last bit of the input number is 0 or 1 using the andi instruction. If the last bit is 1, then jump to the ODD label to check if it is a prime number. Otherwise, print "It is an even number" using the la and li instructions.
# 9) If the input number is even, print "It is an even number" using the la and li instructions, and jump to the EXIT label using the beq instruction.
# 10) If the input number is odd, check if it is a prime number by iterating from 3 to the value of (input number / 2) using a loop. If the input number is not prime, print "It is an odd and not prime number" using the la and li instructions and jump to the EXIT label.
# 11) If the input number is odd and prime, print "It is an odd and prime number" using the la and li instructions and jump to the EXIT label.

.data 
output: .string "Please enter an integer: " 
input: .word 0 
even: .string "It is an even number" 
odd_prime: .string "It is an odd and prime number" 
odd_notprime: .string "It is an odd and not prime number" 

.text
main:
  #display the first output message to the user
  la a0, output
  li a7, 4
  ecall
  #take the input integer from the user and store it in a0
  la a0, input
  li a7, 5
  ecall 

  add x5, x0, a0             #the input value stored in x5
  addi x6, x0, 3             #the loop in ODD has an iterator let’s assume it is i. Here I initialized i = 3
  srli x7, x5, 1             #divide the input number by 2 and store it in x7 to use it as the loop boundary for finding if the number is prime or not
  andi x1, x5, 1             #anding the last bit of the number with 1 to see if it is even or odd
  addi x2, x0, 1             #store 1 in x2
  beq x1, x2, ODD            #if x1 = 1, then the number is odd
  #diplaying to the user that the number is even
  la a0, even
  li a7, 4
  ecall

  beq x0, x0, EXIT           #unconditionl jump to EXIT

ODD:
  blt x7, x6, ODD_PRIME      #check if boundary < i, if true then we will jump
  rem x8, x5, x6             #divide x5 by x6 and store the remainder in x8
  beq x8, x0, ODD_NOT_PRIME  #if the remainder is 0, then x5 isn’t prime
  addi x6, x6, 1             #increment i by one
  beq x0, x0, ODD            #unconditionl jump to ODD 
  
ODD_NOT_PRIME:
  #displaying to the user that the number is odd but not prime
  la a0, odd_notprime
  li a7, 4
  ecall
  
  beq x0, x0, EXIT           #unconditionl jump to EXIT

ODD_PRIME:
  #displaying to the user that the number is odd and prime
  la a0, odd_prime
  li a7, 4
  ecall
  
  beq x0, x0, EXIT           #unconditionl jump to EXIT

EXIT:
