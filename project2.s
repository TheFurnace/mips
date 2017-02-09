.data
ask_int: .asciiz "\Please enter an integer: "
ask_int2: .asciiz "\Please enter a second integer: "
gcd_is: .asciiz "\The GCD of these two integers is: "
lcm_is: .asciiz "\The LCM of these two integers is: "

n1: .word 4
n2: .word 4

.text
main: 

#Ask for first int
la          $a0, ask_int            #Load first message
li          $v0, 4                  #code: display string
syscall
#Take first int input
la          $a0, n1                 #load empty address for n1
la          $a1, n1                 #load length of empty address
li          $v0, 5                  #code: n1 int
syscall

#Ask for second int
la          $a0, ask_int            #Load second message
li          $v0, 4                  #code: display string
syscall
#Take second int input
la          $a0, n2                 #load empty address for n2
la          $a1, n2                 #load length of empty address
li          $v0, 5                  #code: n2 int
syscall

#call GCD subroutine
la          $a0, n1                 #load first input argument
la          $a1, n2                 #load second input argument
jal         GCD                     #Jump to subroutine GCD
move        $v0, $s0                #Save first result

#call LCM subroutine
la          $a0, n1                 #load first input argument
la          $a1, n2                 #load second input argument
jal         LCM                     #Jump to subroutine LCM
move        $v0, $s1                #Save second result

#Print GCD
la          $a0, gcd_is             #Load gcd answer message
li          $v0, 4                  #code: string output
syscall

move        $a0, $s0                #Load gcd
li          $v0, 1                  #code: int output
syscall

#print LCM
la          $a0, lcm_is             #Load lcm answer message
li          $v0, 4                  #code: string output
syscall

move        $a0, $s1                #Load lcm
li          $v0, 1                  #code: int output


li		    $v0, 10		            #code: end program
syscall

#GCD subroutine
GCD:
addi        $sp, -12                #Make space on stack
sw          $a0, 0($sp)             #Save n1 on stack @ 0$sp
sw          $a1, 4($sp)             #Save n2 on stack @ 4$sp
sw          $ra, 8($sp)             #Save return address @ 8$sp

move        $t0, $a0                #Move argument to temporary register (t0 = n1)
move        $t1, $a1                #Move argument to temporary register (t1 = n2)

bnez        $t1, ENDIF              #If (n2 == 0)
move        $v0, $t0                #return n1  
jr          $ra                     #return to subroutine call origin     

ENDIF:                              #Else
lw          $a0, 4($sp)             #Load n2 into argument
div         $t0, $t1                #n1%n2
mfhi        $a1                     #remainder into argument
jal         GCD                     #Call GCD recursively

lw          $ra, 8($sp)             #get return address from stack
addi        $sp, 12                 #drop used stack
jr          $ra                     #return to subroutine call origin
#end routine



#LCM subroutine
LCM:
addi        $sp, -12                #Make space on stack
sw          $a0, 0($sp)             #Save n1 on stack @ 0$sp
sw          $a1, 4($sp)             #Save n2 on stack @ 4$sp
sw          $ra, 8($sp)             #Save return address @ 8$sp

move        $t0, $a0                #Move argument to temporary register (t0 = n1)
move        $t1, $a1                #Move argument to temporary register (t1 = n2)

div         $t0, $t1                #n1%n2
mfhi        $t2                     #store result in t2 = n1%n2

jal         GCD                     #Call GCD with same input arguments as LCM (n1,n2)
move        $v0, $t3                #store result of GCD in t3 = GCD(n1,n1)

div         $t2, $t3                #perform division (n1%n2)/GCD(n1,n2)
mflo        $v0                     #v0 = (n1%n2)/GCD(n1,n2)

lw          $ra, 8($sp)             #load return address
addi        $sp, 12                 #return memory to stack

jr          $ra                     #return to subroutine call origin
#end routine