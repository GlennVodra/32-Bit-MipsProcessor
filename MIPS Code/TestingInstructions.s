.globl main
.text

main:   addi     $s0,$s0,10
        addi     $s1,$s1,12
		nop
		nop
		nop
		add      $t0,$s0,$s1
		and      $t1,$s0,$s1
		multu    $s0,$s1 
		or       $t3,$s0,$s1
		xor      $t4,$s0,$s1
		sub      $t5,$s0,$s1
		andi     $t6,$s1,65535
		ori      $t7,$s1,1
		xori     $t8,$s0,12
		nop
		nop
		nop
		sw       $t8,0($s1)
		nop
		nop
		nop
		nop
		lw      $t9,0($s1)