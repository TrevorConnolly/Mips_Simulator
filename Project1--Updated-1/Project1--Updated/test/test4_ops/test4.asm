main:
  # Test SUBU
  li $t4, 30          # Load immediate value into $t4
  li $t5, 10          # Load immediate value into $t5
  subu $t6, $t4, $t5  # Subtract $t5 from $t4, store result in $t6
  # Expected: $t6 = 20 (30 - 10)

  # Test ADDU
  li $t7, 15          # Load immediate value into $t7
  li $t8, 25          # Load immediate value into $t8
  addu $t9, $t7, $t8  # Add $t7 and $t8, store result in $t9
  # Expected: $t9 = 40 (15 + 25)

  # Test ADD with negative numbers
  li $t2, -15         # Load immediate value into $t0
  li $t1, 10          # Load immediate value into $t1
  add $t3, $t2, $t1   # Add $t0 and $t1, store result in $t2
  # Expected: $t2 = -5 (-15 + 10)

  # Test SUB with negative numbers
  li $s2, -20        
  li $s1, -10         
  sub $s3, $s2, $s1   

  .word 0xfeedfeed