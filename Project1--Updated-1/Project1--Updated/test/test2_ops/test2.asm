# Compute first twelve Fibonacci numbers and put in array
main: # load address of size variable
      la   $t2, 1
      la   $t3, 3
      jal  assign
      sub  $t4, $t3, $t2    
      la   $t5, 4           # 1 is first and second Fib. number
      .word 0xfeedfeed
assign:
      la   $t2, 5
      la   $t3, 6
      jr   $ra
      