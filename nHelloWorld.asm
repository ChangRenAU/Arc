# My second MIPS program
# Author: Cecilia
# September 16, 2017
# Objective: print out a string n times

.data
prompt: .asciiz "Enter an integer :\n"
range:	.asciiz "\nOut of range.\n"
out_string :	.asciiz "\nHello, World!\n"

.text

main:  	li $t2, 0
	j inputInt
 
quit: 
      # The program is finished. Exit.
      li   $v0, 10          # system call for exit
      syscall        

inputInt:  
      la $a0, prompt      # load address of prompt for syscall
      li $v0, 4           # specify Print String service (See MARS Help --> Tab System Calls)
      syscall             # System call to execute service # 4 (in Register $v0)
      li $v0, 51          # specify Read Integer service (#51)
      syscall             # System call to execute service # 51 (in Register $v0) : Read the number. After this instruction, the number read is in Register $a0.
      beq $a1, -2, quit
      li $v0,1
      syscall
      j Condition

Out_range: 		  #print range and request for input integer again
      la $a0, range       # prepare $a0 to print out the string result
      li $v0, 4		  # Specify String Print Service (#4)
      syscall
      j inputInt	

Condition:     
      add $s0, $a0, $zero	   # save $a0 in $s0
#      li $t0, 10
#      slt $t1, $s0, $t0		   
      bgt $s0,10, Out_range	#integer more than 10
#      slt $t1, $zero, $s0 	  
      blez  $s0, Out_range	#integer less than or equal to 0
      j Loop

Loop :  beq $t2, $s0, quit
	addi $t2, $t2, 1
	j Hello

Hello : la $a0, out_string
	li $v0, 4			# specify Print String Service (#4)
	syscall				# syscall to execute requested service specified in Register $v0 (#4)
	j Loop				# jump to Loop	

		

