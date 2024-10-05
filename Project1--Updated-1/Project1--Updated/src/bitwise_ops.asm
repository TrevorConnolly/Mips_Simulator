main: addi $t0, $zero, 43 # expected result bitwise 00101011
      addi $t1, $zero,  5 # expected result bitwise 00000101 
      or   $t2, $t1, $t0  # expected result bitwise 00101111 
      nor   $t3, $t1, $t0 # expected result bitwise 11010000
      and   $t4, $t1, $t0 # expected result bitwise 00000001
      andi  $t5, $t0, 5   # expected result bitwise 00000001 
      ori   $t6, $t0, 5   # expected result bitwise 00101111 
      sll   $t7, $t0, 2   # expected result bitwise 10101100
      srl   $t8, $t0, 2   # expected result bitwise 00001010
.word 0xfeedfeed
