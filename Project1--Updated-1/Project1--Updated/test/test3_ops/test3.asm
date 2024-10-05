main:
  # Test NOR
  li $t0, 0x0F0F0F0F  # Load immediate value into $t0
  li $t1, 0xF0F0F0F0  # Load immediate value into $t1
  nor $t2, $t0, $t1   # NOR $t0 and $t1, store result in $t2
  # Expected: $t2 = 0x00000000 (NOR of 0x0F0F0F0F and 0xF0F0F0F0)

  # Test OR
  or $t3, $t0, $t1    # OR $t0 and $t1, store result in $t3
  # Expected: $t3 = 0xFFFFFFFF (OR of 0x0F0F0F0F and 0xF0F0F0F0)

  # Test SLT
  li $t4, -10         # Load immediate value into $t4
  li $t5, 20          # Load immediate value into $t5
  slt $t6, $t4, $t5   # Set $t6 to 1 if $t4 < $t5, else 0
  # Expected: $t6 = 1 (-10 < 20)

  # Test SLTU
  li $t7, 10          # Load immediate value into $t7
  li $t8, -20         # Load immediate value into $t8
  sltu $t9, $t7, $t8  # Set $t9 to 1 if $t7 < $t8 (unsigned), else 0
  # Expected: $t9 = 0 (10 is not less than -20 in unsigned comparison)

  # Test SLL
  li $s0, 1           # Load immediate value into $t0
  sll $s1, $s0, 4     # Shift $t0 left by 4 bits, store result in $t1
  # Expected: $s1 = 0x00000010 (1 << 4)

  # Test SRL
  li $s2, 16          # Load immediate value into $t2
  srl $s3, $s2, 2     # Shift $t2 right by 2 bits, store result in $t3
  # Expected: $s3 = 0x00000004 (16 >> 2)

  .word 0xfeedfeed