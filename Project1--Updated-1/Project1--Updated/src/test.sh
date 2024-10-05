# compile the sim.cpp simulator
g++ -o sim sim.cpp UtilityFunctions.o

# fib.asm
mips-linux-gnu-as fib.asm -o fib.elf
mips-linux-gnu-objcopy fib.elf -j .text -O binary fib.bin

sim fib.bin

diff reg_state.out fib_reg_state.out
diff mem_state.out fib_mem_state.out

# arithmetic_ops.asm
mips-linux-gnu-as arithmetic_ops.asm -o arithmetic_ops.elf
mips-linux-gnu-objcopy arithmetic_ops.elf -j .text -O binary arithmetic_ops.bin


sim arithmetic_ops.bin


diff reg_state.out arithmetic_ops_reg_state.out
diff mem_state.out arithmetic_ops_mem_state.out

# bitwise_ops.asm 
mips-linux-gnu-as bitwise_ops.asm -o bitwise_ops.elf
mips-linux-gnu-objcopy bitwise_ops.elf -j .text -O binary bitwise_ops.bin

sim bitwise_ops.bin

diff reg_state.out bitwise_ops_reg_state.out
diff mem_state.out bitwise_ops_mem_state.out

# slt_ops.asm
mips-linux-gnu-as slt_ops.asm -o slt_ops.elf
mips-linux-gnu-objcopy slt_ops.elf -j .text -O binary slt_ops.bin

sim slt_ops.bin

diff reg_state.out slt_ops_reg_state.out
diff mem_state.out slt_ops_mem_state.out

# jump_ops.asm
mips-linux-gnu-as jump_ops.asm -o jump_ops.elf
mips-linux-gnu-objcopy jump_ops.elf -j .text -O binary jump_ops.bin

sim jump_ops.bin

diff reg_state.out jump_ops_reg_state.out
diff mem_state.out jump_ops_mem_state.out


# branches_false_ops.asm

mips-linux-gnu-as branches_false_ops.asm -o branches_false_ops.elf
mips-linux-gnu-objcopy branches_false_ops.elf -j .text -O binary branches_false_ops.bin

sim branches_false_ops.bin

diff reg_state.out branches_false_ops_reg_state.out
diff mem_state.out branches_false_ops_mem_state.out

# branches_true_ops

mips-linux-gnu-as branches_true_ops.asm -o branches_true_ops.elf
mips-linux-gnu-objcopy branches_true_ops.elf -j .text -O binary branches_true_ops.bin

sim branches_true_ops.bin

diff reg_state.out branches_true_ops_reg_state.out
diff mem_state.out branches_true_ops_mem_state.out

# load_store_ops

mips-linux-gnu-as load_store_ops.asm -o load_store_ops.elf
mips-linux-gnu-objcopy load_store_ops.elf -j .text -O binary load_store_ops.bin

sim load_store_ops.bin

diff reg_state.out load_store_ops_reg_state.out
diff mem_state.out load_store_ops_mem_state.out


# noreorder fib

mips-linux-gnu-as fib_noreorder.asm -o fib_noreorder.elf
mips-linux-gnu-objcopy fib_noreorder.elf -j .text -O binary fib_noreorder.bin

sim fib_noreorder.bin

diff reg_state.out fib_noreorder_reg_state.out
diff mem_state.out fib_noreorder_mem_state.out



rm -f *.elf *.bin reg_state.out mem_state.out






