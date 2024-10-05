.set noreorder

# we test branches such that we "branch" -> don't test fall throughs
# testing methodology includes checking each delay slot is executed
# then ensuring the correct branch occurs

# start by initializing values to use for comparisons -> use s registers for this purpose
main: addi $s0, $zero, 5
      addi $s1, $zero, 5 
      addi $s2, $zero, -3

# zero out delay slot registers (not really needed)
      add $s4, $zero, $zero     
      add $s5, $zero, $zero
      add $s6, $zero, $zero
      add $s7, $zero, $zero      



# start by testing beq
temp: beq $s0, $s1, bone
      addi $s4, $s4, 1 # delay slot (only executed ONCE)
      addi $t0, $zero, 1 # should never be executed

bone: addi $t9, $zero, 1 # ensure we have jumped
      bne $s0, $s2, btwo
      addi $s5, $s5, 1 # delay slot (only executed ONCE)
      addi $t1, $zero, 1 # should never be executed

btwo: addi $t8, $zero, 1 # ensure we have jumped
      bgtz $s0, bthr
      addi $s6, $s6, 1 # delay slot  (only executed ONCE)
      addi $t2, $zero, 1 # should never be executed

bthr: addi $t7, $zero, 1
      blez $s2, bfou
      addi $s7, $s7, 1 # delay slot (only executed ONCE)
      addi $t3, $zero, 1 # should never be executed

bfou: addi $t6, $zero, 1 # ensure we have jumped
.word 0xfeedfeed
