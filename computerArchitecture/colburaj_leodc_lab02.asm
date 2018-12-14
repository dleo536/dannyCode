.data
     number: .word 1000000000
     factors: .asciiz    "Factors of "
     sumEquals: .asciiz    "Sum = "   
     colon: .asciiz    ":\n"
     newLine: .asciiz    "\n"   
.text        
        lw $t1, number        #put number (n) to find prime factors of into register
        addi $t4, $zero, 3    # start incrementor (i) at 3, 1 and 2 are base cases
        
        la   $a0, factors     # load address of factors
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        li   $v0, 1	      # integer print
        addi $a0, $t1, 0      # load t4 (i) into a0 to print
        syscall		      # PRINT
        la   $a0, colon       # load address of colon
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        li   $v0, 1	      # integer print
        addi $a0, $zero, 1    # load 1 into a0 to print
        syscall		      # PRINT
        la   $a0, newLine     # load address of newLine
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        addi $t5, $zero, 1    # always add 1 to $t5 (sum)
        
loop:   div  $t2, $t1, 2      # divide number by 2 to find remainder
        mfhi $t3	      # put remainder in t3 (placeholder)
        bgtz $t3, loop2	      # if remainder is greater than 1, branch to loop2
        
        li   $v0, 1	      # integer print
        addi $a0, $zero, 2    # load 2 into a0 to print
        syscall		      # PRINT
        la   $a0, newLine     # load address of newLine
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        addi $t5, $t5, 2      # add 2 to sum 
        
        srl  $t1, $t1, 1      # divide by 2 with shift right logical (we know this will not result in a remainder)
        b loop                # branch unconditionally back to loop
loop2:  bgt  $t4, $t1, end    # branch if i is greater than n 
skip:	div  $t2, $t1, $t4    # divide n by i to find remainder
	mfhi $t3	      # put remainder in t3 (placeholder)
	beqz $t3, loop3       # if remainder = 0, send to loop 3 (print and update)
        addi $t4, $t4, 2      # increment i by 2
	b loop2		      # branch back unconditionally to loop 2 (after incrementing)
loop3:  li   $v0, 1	      # integer print
        addi $a0, $t4, 0      # load i into a0 to print
        syscall		      # PRINT
        la   $a0, newLine     # load address of newLine
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        
        add  $t5, $t5, $t4    # add i to sum
        
        div  $t1, $t1, $t4    # divide n by i
        b skip		      # skip back to check the remainder of n
end:    la   $a0, sumEquals   # load address of sumEquals
        li   $v0, 4           # specify Print String service
        syscall               # PRINT
        li   $v0, 1	      # integer print
        addi $a0, $t5, 0      # load $t5 (sum) into a0 to print
        syscall		      # PRINT
        
        li $v0, 10
        syscall

