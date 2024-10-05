.set noreorder

# we test the jump operations. 
# test with the following for each jump operation 
# fixed delay slot and ensure that delay slot gets executed ( use the s registers)
# secondly, ensure we jump to the correct place  ( use the t registers)

# zero out delay slot registers (not really needed)
      add $s0, $zero, $zero     
      add $s1, $zero, $zero
      add $s2, $zero, $zero
  
main:  j jone  
       addi $s0, $s0, 1      # specify a delay slot instruction
       addi $t0, $zero, 1      # this value should never executed

jone:  addi $t8, $zero, 1      # jumped succesfully
       addi $t9, $zero, jreg   # load the address of jreg
       jr $t9
       addi $s1, $s1, 1      # delay slot, should be executed
       addi $t1, $zero, 1      # should NOT be executed

jreg:  addi $t7, $zero, 1      # jumped successfully
       jal jlink 
       addi $s2, $s2, 1      # delay slot, should be executed
       addi $t2, $zero, 1      # should not be executed

jlink: addi $t6, $zero, 1       # jumped successfully
.word 0xfeedfeed

