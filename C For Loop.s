.globl main
main:

.data
arr: .word 11, 22, 33, 44, 55, 66, 77, 88, 99, 10

.text

la		$s4, arr		        # Let $s4 = address of arr

addi	$s0, $zero, 0			# a=0
addi	$s1, $zero, 0			# i=0
STARTLOOP:
addi	$s2, $s1, -10			# $s2 = $s1 + -10
bgez    $s2, ENDLOOP            # branch if i>=10
add		$s6, $s1, $s1		    # tmp = 2i
add     $s6, $s6, $s6           # tmp = 4i
add     $s5, $s4, $s6           # compute address of arr[i]

lw		$s3, 0($s5)		        # load arr[i]
add     $s0, $s0, $s3           # add to a
addi	$s1, $s1, 1			    # $s1 = $s1 + 1
j STARTLOOP
ENDLOOP:

li		$v0, 10		            # $v0 = 10
syscall