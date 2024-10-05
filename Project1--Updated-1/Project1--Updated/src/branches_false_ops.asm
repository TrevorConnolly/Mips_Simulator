.set noreorder
# test the branches for the specific case when we fall through
# zero out the delay slot registers

# start by initializing values to use for comparisons -> use s registers for this purpose
main: addi $s0, $zero, 5
      addi $s1, $zero, 5 
      addi $s2, $zero, -3

# zero out delay slot registers (not really needed)
      add $s4, $zero, $zero     
      add $s5, $zero, $zero
      add $s6, $zero, $zero
      add $s7, $zero, $zero      

# make sure to fall through here
temp: beq $s1, $s2, bone
      addi $s4, $s4, 1 # delay slot ( always should be executed)
      addi $t0, $t0, 1 # ensure that we fall through because the comparison is false

bone: bne $s0, $s1, btwo
      addi $s5, $s5, 1  # delay slot (always should be executed)
      addi $t1, $t1, 1 # ensure that we fall through because the comparison is false

btwo: bgtz $s2, bthr 
      addi $s6, $s6, 1 # delay slot (always should be executed)
      addi $t2, $t2, 1  # ensure we fall through

bthr: blez $s0, bfou
      addi $s7, $s7, 1 # delay slot (always should be executed)
      addi $t3, $t3, 1 # ensure we always fall through

bfou: 
.word 0xfeedfeed

