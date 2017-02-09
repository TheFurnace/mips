.globl main
main:

.data 

arr: .word 89, 19, 91, 23, 31, 46, 3, 67, 17, 11, 43, 73
message: .asciiz "Index of the largest number: "

.text
#initial values stored in t0-3
#temp values stored in s0-3
#t0=A, t1=max, t2=maxIndex, t3=i 
#s0=i-12, s1=*A[i](index), s2=A[i](value), s3=A[i]-max

la		$t0, arr		        # store array in t0
addi	$t1, $zero, 0			# max = 0
addi	$t2, $zero, 0			# maxIndex = 0
addi	$t3, $zero, 0			# i = 0

# for (i=0; i<12; i++) {
STARTLOOP:
addi    $s0, $t3, -12           # Move the 12 to the left side of i<12 = i-12<0
bgez    $s0, ENDLOOP            # if (i-12)>=0 then i<12 is false and the loop ends

# if(A[i] > max) {
addi    $s1, $t3, 0             # multiply i by 4 before adding to array index
add     $s1, $s1, $s1           # double index
add     $s1, $s1, $s1           # double index again
add     $s1, $s1, $t0           # combine new index with array index
lw		$s2, 0($s1)		        # Load A[i]
sub     $s3, $s2, $t1           # Move the max to the left side of A[i]>max
blez    $s3, ENDIF              # If A[i]-max <=0 then A[i]>max is false

#code inside if
add     $t1, $s2, 0             # max = A[i]
add     $t2, $t3, 0             # maxIndex = i

# } end of if
ENDIF:


# } end of for
addi    $t3, $t3, 1             # i++
j STARTLOOP                     # jump to beginning of loop
ENDLOOP:

la      $a0, message            # store message in output register
li		$v0, 4		            # code for print string
syscall

addi    $a0, $t2, 0             # store result
li		$v0, 1		            # code for print int
syscall

li      $v0,10                  #exit code
syscall