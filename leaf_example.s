leaf_example:
addi	$sp, $sp, -4		# $sp = $sp + -4
sw		$s0, 0($sp)		    # 
add		$t0, $a0, $a1		# $t0 = $a0 + $a1
add		$t1, $a2, $a3		# $t1 = $a2 + $a3
sub		$s0, $t0, $t1		# &$s0 - $t0, $t1
add     $v0, $s0, $zero 
lw		$s0, 0($sp)         # 
addi    $sp, $sp, 4
jr      $ra