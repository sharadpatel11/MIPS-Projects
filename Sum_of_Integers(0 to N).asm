#Name: Sharad Patel
#program Name: Sum of Integers

############################################################################
# Functional Description:
# A program to find the Sum of the Integers from 1 to N, where N is a value
# input from the keyboard.
############################################################################
# Cross References:
# v0: N,
# t0: Sum
###########################################################################

	.data
prompt: .asciiz  "\n Please input a value for N = "
fp:     .asciiz  "\n You entered a floating point number. Therefore, it has been trancated to "
result: .asciiz  "\n The sum of the integers from 1 to N is "
bye:    .asciiz  "\n **** Adios Amigo - Have a good day ****"
	.globl main
	.text
main:	
	li	$v0, 4		# system call code for Print String
	la	$a0, prompt	# load address of prompt into $a0
	syscall 		# print the prompt message
	
	li	$v0, 6		#system call code for read floating point number
	syscall			#reads the value of N into $v0
	
	#blez	$v0, end	# branch to end if $v0 <= 0. It doesn't matter because it will always equal to 6
	li	$t0, 0		# clear register $t0 to zero

	#move the floating point number entered into an integer
	mfc1 $t1, $f0
	srl  $t2, $t1, 23
	add  $s3, $t2, -127 #subtract 127 to get the exponent
	sll  $t4, $t1, 9 #shift exponent and sign bit
	srl  $t5, $t4, 9 #shift back to original position so all the previous bits become zero
	add  $t6, $t5, 8388608 #add implied bit to bit number 8
	add  $t7, $s3, 9 #add 9 to the exponent 
	sllv $s4, $t6, $t7 #shift left 9 plus the exponent
	rol  $t4, $t6, $t7 #rotate the bits left by $t7 to get the integer part
	li   $t5, 31 
	sub  $t2, $t5, $s3 #shift left to 31 to zero out other bits
	sllv $t5, $t4, $t2 #zero out fraction part
	srlv $s5, $t5, $t2 #integer is set
	move $v0, $s5 #move the integer into $v0

	li   $t0, 0 #zero ouot $t0
	blez $t1, end #branch to end if it is less than or equal to 0
	beqz $s4, loop #if it is equal to 0 then loop

	li 	$v0, 4 		# system call code for Print String
	la 	$a0, fp		# load address of message into $a0
	syscall			# print the string

	li 	$v0, 1		# system call code for Print Integer
	move 	$a0, $s5	# move the integer to be printed to $a0
	syscall			# print the truncated number
	move $v0, $s5 #move the integr into $v0

loop:
	add 	$t0, $t0, $v0	# sum of integers in register $t0
	addi 	$v0, $v0, -1	# summing integers in reverse order
	bnez	$v0, loop	# branch to loop if $v0 is != zero
	
	li 	$v0, 4 		# system call code for Print String
	la 	$a0, result	# load address of message into $a0
	syscall			# print the string
	
	li 	$v0, 1		# system call code for Print Integer
	move 	$a0, $t0	# move value to be printed to $a0
	syscall			# print sum of integers
	b main			# branch to main
		
end:	li	$v0, 4		# system call code for Print String
	la	$a0, bye	# load address of msg. into $a0
	syscall			# print the string
	
	li	$v0, 10		# terminate program run and
	syscall 		# return control to system	
		
