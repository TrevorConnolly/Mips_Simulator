# load values to perform arithmetic instructions on
addi $s0, $zero, -78
addi $s1, $zero, 118
addi $s2, $zero, 74
addi $s3, $zero, -123

# test the add instruction pos+pos, neg+pos, neg+neg
add $s4, $s0, $s3 # neg+neg  (-78-123) = -201
add $s5, $s3, $s2 # pos+neg  (-123+74) = -49
add $s6, $s1, $s2 # pos+pos (74+118) = 192

# test the add unsigned instruction
addu $s7, $s1, $s2 #(74+118) = 192

# test the sub instruction with pos-pos, neg-pos, neg-neg, pos-neg
sub $t0, $s2, $s1  #(pos - pos) (74-118) = -44
sub $t1, $s0, $s2 #(neg-pos) (-78-74) -152
sub $t2, $s3, $s0 #(neg-neg) (-123 - (-78)) = -45
sub $t3, $s2, $s3 #(pos-neg) (74 + 123) = 197

# test the subtract unsigned button 
subu $t4, $s2, $s1  #(74-118) = -44

# test add immediate
addi $t5, $s1, -1 #(118 - 1) = 117
addi $t6, $s3, 2 #(-123 + 2) = -121

# test add immediate unsigned
addiu $t7, $s2, 2 #(74+2) = 76  
.word 0xfeedfeed
