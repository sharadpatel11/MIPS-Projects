#Name: Sharad Patel
#program Name: Reverse String

############################################################################
# Functional Description:
# A program to reverse the string given by the user
# input from the keyboard.
############################################################################

.data
string1: .space 5
string2: .space 5
str1: .asciiz " \n Enter a String: "
str2: .asciiz " \n Returning string is: "
.text

la  $a0, str1   #load in the instructions for the user
li  $v0, 4      #print sting
syscall

li  $v0, 8      #read string
li  $a1, 5      #length = 5 so we can store 4 characters
la  $a0, string1 #load in the inputed word
syscall

#load each character into $t0-$t3
lb  $t0, 0($a0)
lb  $t1, 1($a0)
lb  $t2, 2($a0)
lb  $t3, 3($a0)

#allocate each charcter on the stake
add $sp, $sp, -4
sb  $t0, 0($sp)
sb  $t1, 1($sp)
sb  $t2, 2($sp)
sb  $t3, 3($sp)

#deallocate each charcter in reverse order from the stake
lb  $s0, 3($sp)  
lb  $s1, 2($sp)
lb  $s2, 1($sp)
lb  $s3, 0($sp)
add $sp, $sp, 4

#assign the charcters to string2 in reverse order
la  $t5, string2 #assign string2 to $t5 
sb  $s3, 3($t5)  #then store each charcter in reverse order to $t5
sb  $s2, 2($t5)
sb  $s1, 1($t5)
sb  $s0, 0($t5)

#output the returniong statement
li  $v0, 4    #print string 
la  $a0, str2 #load in the instructions
syscall

#output the reversed string
li  $v0, 4    #print string
move $a0, $t5 #move the reversed string into $a0
syscall