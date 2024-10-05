.set noreorder

main: jal     func
      addi    $t1, $zero, ret
      sw      $t0, 0($t1)
      .word 0xfeedfeed

func: 
      addiu $s3, $zero, arr2 # store the start of arr2 aka the end of arr1  
      addiu $s1, $zero, arr1 # load address of array (within delay slot, must be executed for correctness)
      addiu $s0, $zero, arr2 
loop: lw $t3, 0($s1)    # get value of array
      blez $t3, less    # start of the if statement -> see if less or equal to zero
      sll $t3, $t3, 2   # always get executed shift left by two
      sh  $t3, 0($s0)   # store halfword
      j   end           # skip the else case
less: 
      srl $t3, $t3, 2    
      sw  $t3, 0($s0) 
end: 
      addi $s1, $s1, 4
      bne $s3, $s1, loop
      addi $s0, $s0, 4
      jr $ra
      addi    $t0, $zero, 1
      

arr1: .word 0x00000029
      .word 0x00000000
      .word 0xffffd9d9
      .word 0x0012e40d
      .word 0x989fffa8
      .word 0x7ea66eaa
      .word 0x0000ffff
      .word 0x00000002
      .word 0xf0742458
      .word 0xfffffaaa    
arr2: .word 0x00000000
      .word 0x00000000
      .word 0x00000000
      .word 0x00000000
      .word 0x00000000
      .word 0x00000000
      .word 0x00000000
      .word 0x00000000
      .word 0x00000000
      .word 0x00000000 
ret:  .word 0x00000000   
  