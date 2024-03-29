# My Fourth MIPS program
# Author: Cecilia
# September 20, 2017
# Objective: string length, put in lowercase a string, and delete m characters from a string s starting from position p. 
# A menu to choose from: a) function length, b) put in lowercase, c) delete characters, or d) quit.

	.data 

menu:		.asciiz "\n Menu:\n\n Enter a number to choose function.\n 1) Function length\n 2) Put in lowercase\n 3) Delete characters\n 4) Quit\n"
prompt_input:	.asciiz " Please enter a string:\n" 

inputString: 	.space 512

num: 		.asciiz " Please enter the number of charaters to delete:\n "
position: 	.asciiz " Please enter the position :\n "


	.text
	
main :  j Menu

quit: 	li $v0, 10 
	syscall			#specify Print String Service (#10) : exit
	
Menu:	la $a0,menu		#Print the menu
	li $v0,4
	syscall
	
	li $v0,51	
	syscall			#Display the dialog for menu
	
	beq $a0,1, Stringlength
	beq $a0,2, PutInLowercase
	beq $a0,3, DeleteChars
	beq $a0,4, quit
	beq $a1,-2, quit
	
	j main			#Startover form the Menu
	
Stringlength:			#function 1 length 
	la   $a0, prompt_input
	li   $v0, 4
	syscall
	 
	la   $a0, inputString	#load the address of input string
	li   $a1, 512		#maximum number of characters to read
	li   $v0, 8		#syscall to read string
	syscall

	li $s0, 0		# counter to count the length
	
	la   $a0, inputString
	
loop_length:   
	lb   $t1, 0($a0)	#load the first character of the string     	
	beqz $t1, exit_length	#if all characters are loaded, exit loop
	addi $a0, $a0, 1	#the next character
	addi $s0, $s0, 1	#length increased by 1
	j loop_length 	 
	
exit_length:	
	sub    $s0, $s0, 1	#actual length should be 1 less than the current # in $s0
	move   $a0, $s0		#$a0 = integer to print
	li   $v0, 1		#syscall to print integer
	syscall	
	
      	jal Menu
      	
      	
PutInLowercase:			# function 2  Put in Lowercase
      	la   $a0, prompt_input
	li   $v0, 4
	syscall
	 
	la   $a0, inputString
	li   $a1, 512
	li   $v0, 8
	syscall
	
#	la   $a0, inputString	#no need
	
loop_lower:   
	lb   $t1, 0($a0)
	move $t2, $a0		#record the original loc
	addi $a0, $a0, 1
	beqz $t1, exit_lower	
	li   $t0, 0x5A		#ascii code greater than the last uppercase letter
	bgt  $t1, $t0, loop_lower	#if t1 > t0 i.e.the char in $t1 is not an uppercase letter, do nothing & startover loop
	li   $t0, 0x41		#ascii code less than the first uppercase letter
	blt  $t1, $t0, loop_lower	#if t1 < t0 i.e.the char in $t1 is not an uppercase letter,do nothing & startover loop

	# Lowercase	 
	addi  $t1, $t1, 0x20
	sb    $t1, ($t2)	#save the lowercase char back into the loc where it was loaded($t2)
	jal   loop_lower
	
exit_lower:
	la   $a0, inputString	
	li   $v0, 4
	syscall	
	
      	jal Menu
      	     	
DeleteChars:			# function 3 Delete Characters
	la   $a0, prompt_input
	li   $v0, 4
	syscall
	 
	la   $a0, inputString
	li   $a1, 512
	li   $v0, 8
	syscall
	
	move $s0, $a0		#store the address of string into $s0
	
	la   $a0, num		#prompt the user to input the # of char to delete
	li   $v0, 4
	syscall
	 
	li   $v0, 5		#read the abovementioned #
	syscall
	
	move $s1, $v0     	#store the # into $s1
	
	la   $a0, position	#prompt the user to input the starting position of string to delete
	li   $v0, 4
	syscall

	li   $v0, 5
	syscall	
	
	move $s2, $v0    	#store the position into $s2
		  
	move $t0, $s1     	#counter		
	
	move $t1, $s0		#$t1 = address of str
	add  $t1, $t1, $s2	
	sub  $t1, $t1, 1	#store the address of start position into $t1    address of str + position - 1
	add  $t2, $t1, $s1	#store the address of end position into $t2    address of str + position + num
	
loop_delete:
	lb   $t3, 0($t2)	
	sb   $t3, 0($t1)	
	addi $t1, $t1, 1
	addi $t2, $t2, 1	#ignore the chars between start pos and end pos, save the char after end pos to start pos one by one
	sub  $t0, $t0, 0	#???
	beqz $t3, exit_delete	
	jal loop_delete
	
exit_delete:
	move $a0, $s0
	li   $v0, 4
	syscall
	
	jal Menu	

