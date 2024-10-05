.set noreorder
main:
  # Test BEQ
  li $t1, 15
  li $t2, 15          
  beq $t1, $t2, label1 
  add $t3, $t1, $t2
  li $t1, 10

label1:
  # Test BNE
  li $t4, 30         
  li $t5, 5         
  bne $t4, $t5, label2
  li $t6, -2
  li $t5, 10 
  .word 0xfeedfeed

label2:
  # Test BLEZ 
  blez $t6, label3         
  li $t7, 25    
  li $t3, 10 
  .word 0xfeedfeed      

label3:
  # Test BGTZ
  bgtz $t7, label 4 
  li $t8, 20

label4:
  li $t9, 25
  .word 0xfeedfeed