
.globl main
.text

main:   addi    $t0,$zero,0
        addi    $t1,$zero,1
		addi    $t2,$zero,1005
		nop
		nop
		nop
		sw      $t1,0($t2)
        add	    $t0,$t1,$t0
		nop
		nop
		nop
        addi    $t2,$t2,1		
		nop
		nop
		nop
		sw      $t0,0($t2)
        add	    $t1,$t0,$t1
		nop
		nop
		nop
		addi    $t2,$t2,1
		nop
		nop
		nop
		sw      $t1,0($t2)
        add	    $t0,$t1,$t0
		nop
		nop
		nop
		addi    $t2,$t2,1
		nop
		nop
		nop
		sw      $t0,0($t2)
        add	    $t1,$t0,$t1
		nop
		nop
		nop
		addi    $t2,$t2,1
		nop
		nop
		nop
		sw      $t1,0($t2)
        add	    $t0,$t1,$t0
		nop
		nop
		nop
		addi    $t2,$t2,1
		nop
		nop
		nop
		sw      $t0,0($t2)
        add	    $t1,$t0,$t1
		nop
		nop
		nop
		addi    $t2,$t2,1
		nop
		nop
		nop
		sw      $t1,0($t2)
        add	    $t0,$t1,$t0
		nop
		nop
		nop
		addi    $t2,$t2,1
		nop
		nop
		nop
		sw      $t0,0($t2)
        add	    $t1,$t0,$t1
		nop
		nop
		nop
		addi    $t2,$t2,1
		nop
		nop
		nop
		sw      $t1,0($t2)
        add	    $t0,$t1,$t0
		nop
		nop
		nop
		addi    $t2,$t2,1
		nop
		nop
		nop
		nop
		sw      $t0,0($t2)
		nop
		nop
		nop
		nop
		
