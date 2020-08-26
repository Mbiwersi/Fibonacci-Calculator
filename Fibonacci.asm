#Author: Michael Biwersi
#Finding the nth Fibonacci number
#PRE: n>0

.data
prmpt: .asciiz "Type in a positive int to find the nth fibonacci number "
negPrmpt: .asciiz "You must enter an integer greater than or equal to 0, try agian "
the: .asciiz "The "
fibNum: .asciiz "th Fibonacci number is "
.text
la $a0, prmpt
li $v0, 4
syscall  #calling the prmpt

readInt:
li $v0, 5
syscall #reading the int

move $t0, $v0 #storing the users enter into $t0
slt $t1, $t0, $zero #checking if the entry is negative
beq $t1, 1, readNonNegInt
move $a0, $t0  #setting up for first call to fib
move $v0, $t0
jal Fib  #Orignal call to Fib
move $t3,$v0
j printInt

readNonNegInt:
la $a0, negPrmpt  #telling user to type a postive number
li $v0, 4
syscall
j readInt 

Fib:
beqz $a0,baseCaseZero   #base case for n=0
beq $a0,1,baseCaseOne   #base case for n=1
addi $sp, $sp, -4
sw $ra, 0($sp)
add $a0,$a0,-1  #(n-1)
jal Fib #calling Fib on $a0
addi $a0,$a0,1  #resetting n
lw $ra, 0($sp)
sw $v0,0($sp)

addi $sp,$sp,-4
sw $ra,0($sp)
addi $a0, $a0,-2  #(n-2)
jal Fib
addi $a0,$a0,2 #resetting n
lw $ra,0($sp)
addi $sp,$sp,4
lw $a1,0($sp)
addi $sp,$sp,4

add $v0,$v0,$a1
jr $ra

baseCaseZero:
li $v0,0
jr $ra

baseCaseOne:
li $v0, 1
jr $ra

printInt:
move $t3, $v0
la $a0, the
li $v0, 4
syscall
la $a0, ($t0)
li $v0, 1
syscall
la $a0, fibNum
li $v0, 4
syscall
la $a0, ($t3)
li $v0, 1
syscall

end:
li $v0,10
syscall
