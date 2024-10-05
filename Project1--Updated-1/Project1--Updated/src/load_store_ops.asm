# load the address for the first word in memory
addi $s1, $zero, 0x30
# load the address for the second word in memory
addi $s2, $zero, 0x34

# load from the first word in memory
lw $t0, 0($s1)
lhu $t1, 0($s1)
lbu $t2, 0($s1)

# test lui
lui $t3, 20

# load the second word
lw $s0, 0($s2)

# store the second word with different instructions
sw $s0, 4($s2)
sh $s0, 8($s2)
sb $s0, 12($s2)
.word 0xfeedfeed
.word 0x12345678
.word 0xabcd0748
