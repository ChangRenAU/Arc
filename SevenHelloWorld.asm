# My First MIPS program
# Author: Cecilia
# September 16, 2017
# Objective: demo program to show how to print out a string for 7 times

	.text

main : 	li $t0, 0
	li $t1, 7	
	j Loop			#call Loop subroutine

quit :	li $v0, 10			# specify Print String Service (#10)
	syscall				# syscall to execute requested service specified in Register $v0 (#10)
	
# Subroutine to print Hello World
	.data
out_string :	.asciiz "\nHello, World!\n"

	.text
Loop : beq $t0, $t1, quit
	addi $t0, $t0, 1
	j Hello


Hello : la $a0, out_string
	li $v0, 4			# specify Print String Service (#4)
	syscall				# syscall to execute requested service specified in Register $v0 (#4)
	j Loop				# jump to Loop		
		


