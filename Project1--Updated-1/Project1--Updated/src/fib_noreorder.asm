# Compute first twelve Fibonacci numbers and put in array
    .set noreorder
main: 
      la   $t0, arr         # load address of array
      la   $t5, arrsize         # load address of size variable
      lw   $t5, 0($t5)      # load array size
      li   $t2, 1           # 1 is first and second Fib. number
      sw   $t2, 0($t0)      # F[0] = 1
      sw   $t2, 4($t0)      # F[1] = F[0] = 1
      addi $t1, $t5, -2     # Counter for loop, will execute (size-2) times
loop: 
      lw   $t3, 0($t0)      # Get value from array F[n] 
      lw   $t4, 4($t0)      # Get value from array F[n+1]
      add  $t2, $t3, $t4    # $t2 = F[n] + F[n+1]
      sw   $t2, 8($t0)      # Store F[n+2] = F[n] + F[n+1] in array
      addi $t1, $t1, -1     # decrement loop counter
      bgtz $t1, loop        # repeat if not finished yet.
      addi $t0, $t0, 4      # increment address of Fib. number source
      .word 0xfeedfeed
arr:  
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0xc             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
      .word 0x0             # size of "array"
arrsize:      
      .word 0xc             # size of "array"
      