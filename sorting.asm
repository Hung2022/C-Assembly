# sorting.asm
#   A MIPS program that sorts an array of integers
#
# Author:
#   Titus Klinge
#   Hung Nguyen

######################################################################

.data
arr: .word 7, 2, 1, 3, 4, 5, 8, 6, 9, 0

######################################################################

.text
main:
    la $s0, arr             # $s0 holds address of arr
    li $s1, 10              # $s1 holds value of size
    
    move $a0, $s0           # calls isort(arr, size)
    move $a1, $s1
    jal isort

    move $a0, $s0           # calls the print function
    move $a1, $s1           # to print off all the
    jal print               # elements of arr

    li $v0, 17              # Ends the program via a
    syscall                 # system call

######################################################################

print:
    move $t0, $a0
    move $t1, $a1
    li   $v0, 1

    print_while:
        beq $t1, $zero, print_done
        
        lw $a0, 0($t0)      # since $v0 = 1, this
        syscall             # prints $a0 as an int

        addi $t0, $t0, 4    # arr = arr + 1
        addi $t1, $t1, -1   # size = size - 1

        j print_while

    print_done:
        jr $ra


######################################################################
# All of your solutions should go below
#
# NOTE: Any code that you modify above this line should be restored
#       before you submit your assignment
######################################################################

isort:
    addi $t5, $a1, 0		# save size/a1 in $t5
    addi $a1, $zero, 1		# set i = 1 and save it to a1
    
    Forloop:
    	bge $a1, $t5, Out	# if i > size True, jump to Out label if 1 > 10
    	
    	addi $sp, $sp, -8	# reserve 4 byte for $ra 
    	sw $a1, 0($sp)		# save a1 from insert_left
    	sw $ra, 4($sp)		# save ra from main
    
    	jal insert_left		# call insert_left
    	
    	lw $a1, 0($sp)		# restore/load a1 from isort
    	lw $ra, 4($sp)		# restore/load ra from main
    	addi $sp, $sp, 8	# restore stack pointer
    	
    	addi $a1, $a1, 1	# i + 1
    	
    	j Forloop		# jump back to loop 

    Out:
    	jr $ra  # Put your solution to isort here

######################################################################

insert_left:
    
    sll $t3, $a1, 2	#  2^2, i * 4. Replace t5 with a1 after test
    add $t3, $a0, $t3	#  Add arr to the position above. Replace with a0 after testing, s0 otherwise
    
    lw $t1, 0($t3)		# get the i item in arr
    lw $t0, -4($t3) 		# get the i - 1 item in arr 
    
    blt $a1, $zero, Exit	# if i < 0 True, Exit out of If statement
    bgt $t1, $t0, Exit		# if arr[i] > arr[i-1] True, Exit out of If statement
    		
    addi $sp, $sp, -4		# reserve 4 byte for $ra 
    sw $ra, 0($sp)		# save ra from isort
    
    jal swap		
    
    lw	$ra, 0($sp)		# restore/load ra from isort
    addi $sp, $sp, 4		# restore stack pointer
    				
    addi $a1, $a1, -1		# i -1
    j insert_left
    
    Exit:
    	jr $ra  # Put your solution to insert_left here

######################################################################

swap:

    sll $t3, $a1, 2	#  2^2, i * 4. Replace t5 with a1 after test
    add $t3, $a0, $t3	#  Add arr to the position above. Replace with a0 after testing, s0 otherwise

    lw $t1, 0($t3)	# get the i item in arr / temp
    lw $t0, -4($t3) 	# get the i - 1 item in arr 
    
    sw $t1, -4($t3)	# arr[i] = arr[i - 1]
    sw $t0, 0($t3)	# arr[i - 1] = temp
    
    jr $ra  # Put your solution to swap here
