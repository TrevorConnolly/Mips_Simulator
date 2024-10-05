# test the slt operations. for each operation, write tests that output 0 and one
# for each operation test the use of negative numbers 

# first load values into registers
addi $s0, $zero, -10
addi $s1, $zero, 3
addi $s2, $zero, 15
addi $s3, $zero, -7

# try to do slt, should work fine with signed values
slt $s4, $s0, $s1 # (-10 < 3) = 1 (true) 
slt $s5, $s1, $s0 # (3 < -10) = 0 (false) 
slt $s6, $s3, $s0 # (-7 < -10) = 0 (false)


# test slt for just unsigned values
sltu $s7, $s1, $s0  # (3 < -10) -> if treating unsigned, value should be true (1)
sltu $t0, $s2, $s1 # (15 < 3) -> false



# test slti, where immediate can be a positive or neg value (treat signed)
slti $t1, $s1, -9 # (3 < -9) = false
slti $t2, $s1, 50 # (3 < 50) = true
slti $t3, $s3, -10 # (-7 < -10) = false
slti $t4, $s3, 3 # (-7 < 3) = true

# test sltiu, where immediate value should only be treated as unsigned
sltiu $t5, $s1, -2 # (3 < -2 ) -> true in the case of unsigned
sltiu $t6, $s1, 1 # (3 < 1 ) -> should be false
sltiu $t7, $s1, 5 # (3 < 5 ) -> should be true
.word 0xfeedfeed
