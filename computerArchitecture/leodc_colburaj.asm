.data
	AList: .word 0:12
	ASize: .word 12
	TAList: .word 0:12
	TASize: .word 12
	endParen: .asciiz    ")\n"
	newLine: .asciiz     " \n"
	equals: .asciiz      " (="
	enter: .asciiz    "Enter a number: "
	auto: .asciiz     "\nAutomorphic numbers up to "
	morphic: .asciiz  " are:\n"
	tri: .asciiz "\nTri-automorphic numbers up to "
	again: .asciiz "Again? (enter y or n): "
	
.text 
beginning: 
	la   $a0, newLine     # load address of newLine
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
	la   $a0, enter     # load address of enter
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        li   $v0, 5	    # get number from user
        syscall			
        move    $s0, $v0	    # put number in s0 register
        
        la   $a0, auto     # load address of automorphic text
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
	li   $v0, 1	      # integer print
        addi $a0, $s0, 0      # load t4 (i) into a0 to print
        syscall	
        la   $a0, morphic     # load address of morphic text
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        la $t1, AList	      # load address of AList and store it in t1
        la $t2, TAList        # load address of TAList and store it in t2
        addi $t0, $zero, 1    # start incrementor (i) at 1
        addi $s1, $zero, 0    # counter for how many elements in automorphic array
        addi $s2, $zero, 0    # counter for how many elements in tri-automorphic array
loop1:	bge  $t0, $s0, printArrays	
	mult $t0, $t0		#squaring square
	mflo $a2	      # set squared object to a2 for function call
	addi $a1, $t0, 0      # set sqare to a1 for function call
	jal matchdigits		# call matchdigits method with square and squared
	bgtz $v1, addValueAuto  # add to the Automorphic list
loop1b: li $t3, 3	      #load 3 into register t3
	mult $a2, $t3		#multiply "squared" by 3 to test for tri-automorphy
	mflo $a2	     #set $a2 to be the new "squared" to compare against
	jal matchdigits	      #call matchdigits method with square and 3*squared
	bgtz $v1, addValueTri	#add to the tri-automorphic list
loop1c: addi $t0, $t0, 1    	# start incrementor (i) at 1
	b loop1
	
matchdigits: 
	addi $v1, $zero, 0    # set v1 as our boolean return value
	addi $t5, $zero, 10   # create temp variable
	addi $t7, $a1, 0      # create n variable
loop2:  blez $t7 endl2        # check that n is still above zero, if not, finish function
	div  $a2, $t5          # divide squared by temp to get remainder
	mfhi $t6 		# put remainder in t6
	beq $a1, $t6, true	#check that square and remainder are equal
	div $t7, $t7, 10	# set n to n/10
	mul $t5, $t5, 10        # set temp to temp*10
	b loop2
endl2:  
	jr $ra			#send back to original return address
	
true:	addi $v1, $zero, 1	# if true, set v1 to 1
	b endl2			#branch back to endl2
	
addValueAuto: sw $t0, ($t1) 	#store thing at t1 in t0
	addi $t1, $t1, 4	#increment t1 by 4
	addi $s1, $s1, 1	#increment s1 by 1
	b loop1b		# branch back to loop1b
	
addValueTri: sw $t0, ($t2) 	#store word at t2 in t0
	addi $t2, $t2, 4	# increment t2 by 4
	addi $s2, $s2, 1	# increment s2 by 1
	b loop1c		#branch back to loop1c
	
printArrays:
	addi $t3, $zero, 4   # set register t3 to 4
	mult  $s1, $t3       # multiply s1 by 4 to get offset
	mflo $t3	     # set t3 to offsets
	sub  $t1, $t1, $t3   #set array pointer back to original spot
printAuto: beqz $s1, printTri 	# if all values are printed, go to printTri

	lw $t4, ($t1)		#load word stored at t1 in t4
	li   $v0, 1	      # integer print
        addi $a0, $t4, 0    # load t4 into a0 to print
        syscall		      # PRINT
        la   $a0, equals     # load address of equals
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        mul $t5, $t4, $t4    #find sqared number to print
        
        li   $v0, 1	      # integer print
        addi $a0, $t5, 0    # load 2 into a0 to print
        syscall		      # PRINT
        la   $a0, endParen     # load address of endParen
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        
        addi $t1, $t1, 4      #increment t1 by 4
        addi $s1, $s1, -1	#decrement s1 by 1
        b printAuto		#branch to print Automorphic numbers
printTri: 
	la   $a0, tri     # load address of tri
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        li   $v0, 1	      # integer print
        addi $a0, $s0, 0      # load t4 (i) into a0 to print
        syscall	
        la   $a0, morphic     # load address of morphic text
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        addi $t3, $zero, 4   # set register t3 to 4
	mult  $s2, $t3       # multiply s1 by 4 to get offset
	mflo $t3	     # set t3 to offsets
	sub  $t2, $t2, $t3   #set array pointer back to original spot
printTria: beqz $s2, goAgain 	

	lw $t4, ($t2)		#store word at t2 in t4 
	li   $v0, 1	      # integer print
        addi $a0, $t4, 0    # load 2 into a0 to print
        syscall		      # PRINT
        la   $a0, equals     # load address of equals
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        mul $t5, $t4, $t4    #find sqared number to print
        mul $t5, $t5, 3      # multiply that squared number by three (for tri-automorphic)
        
        li   $v0, 1	      # integer print
        addi $a0, $t5, 0    # load t5 into a0 to print
        syscall		      # PRINT
        la   $a0, endParen     # load address of endParen
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        
        addi $t2, $t2, 4	#increment t2 by 4
        addi $s2, $s2, -1	#decrement s2 by 1
        b printTria
        
goAgain: 
	la   $a0, again     # load address of endParen
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        li    $v0, 12	    # get character from user
        syscall	
	beq $v0, 'y', beginning	#if user enters y, go back to beginning

        b end  #else end program

end:	li $v0, 10	#end program
        syscall
        
        
        
        
        