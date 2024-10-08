#include <stdio.h>
#include "MemoryStore.h"
#include "RegisterInfo.h"
#include "EndianHelpers.h"
#include <fstream>
#include <iostream>
using namespace std; 
// new comment test push
union REGS 
{
    RegisterInfo reg;
    uint32_t registers[32] {0};
};

union REGS regData;

// TODO: fill in the missing hex values of the OP_IDs (opcode
enum OP_IDS
{
    //R-type opcodes...
    OP_ZERO = 0x0, // zero
    //I-type opcodes...
    OP_ADDI = 0x8, // addi
    OP_ADDIU = 0x9, // addiu
    OP_ANDI = 0xc, // andi
    OP_BEQ = 0x4, // beq
    OP_BNE = 0x5, // bne
    OP_LBU = 0x24, // lbu
    OP_LHU = 0x25, // lhu
    OP_LUI = 0xf, // lui
    OP_LW = 0x23, // lw
    OP_ORI = 0xd, // ori
    OP_SLTI = 0xa, // slti
    OP_SLTIU = 0xb, // sltiu
    OP_SB = , 0x28// sb
    OP_SH = , 0x29// sh
    OP_SW = , 0x2b// sw
    OP_BLEZ = 0x6, // blez
    OP_BGTZ = 0x7, // bgtz
    //J-type opcodes...
    OP_J = , 0x2// j
    OP_JAL =  0x3// jal
};

// TODO: fill in the missing hex values of FUNCT_IDs (function IDs)
enum FUNCT_IDS
{
    FUN_ADD = 0x20, // add
    FUN_ADDU = 0x21, // add unsigned (addu)
    FUN_AND = 0x24, // and
    FUN_JR = 0x08, // jump register (jr)
    FUN_NOR = 0x27, // nor
    FUN_OR = 0x25, // or
    FUN_SLT = 0x2a, // set less than (slt)
    FUN_SLTU = 0x2b, // set less than unsigned (sltu)
    FUN_SLL = 0x00, // shift left logical (sll)
    FUN_SRL = 0x02, // shift right logical (srl)
    FUN_SUB = 0x22, // substract (sub)
    FUN_SUBU = 0x23 // substract unsigned (subu)
};

// extract specific bits [start, end] from a 32 bit instruction
uint extractBits(uint32_t instruction, int start, int end)
{
    int bitsToExtract = start - end + 1;
    uint32_t mask = (1 << bitsToExtract) - 1;
    uint32_t clipped = instruction >> end;
    return clipped & mask;
}

// sign extend smol to a 32 bit unsigned int
uint32_t signExt(uint16_t smol) 
{
    uint32_t x = smol;
    uint32_t extension = 0xffff0000;
    return (smol & 0x8000) ? x ^ extension : x;
}

// dump registers and memory
void dump(MemoryStore *myMem) {

    dumpRegisterState(regData.reg);
    dumpMemoryState(myMem);
}

int main(int argc, char** argv) {

    // open instruction file
    ifstream infile;
    infile.open(argv[1], ios::binary | ios::in);

    // get length of the file and read instruction file into a buffer
    infile.seekg(0, ios::end);
    int length = infile.tellg();
    infile.seekg (0, ios::beg);

    char *buf = new char[length];
    infile.read(buf, length);
    infile.close();

    // initialize memory store with buffer contents
    MemoryStore *myMem = createMemoryStore();
    int memLength = length / sizeof(buf[0]);
    int i;
    for (i = 0; i < memLength; i++) {
        myMem->setMemValue(i * BYTE_SIZE, buf[i], BYTE_SIZE);
    }

    // initialize registers and our program counter
    regData.reg = {};
    uint32_t PC = 0;
    bool err = false;
    
    // variables to handle branch delay slot execution
    bool encounteredBranch = false;
    bool executedDelaySlot = false; 
    uint32_t savedBranch = 0;       // saved (delayed) branch instruction
    uint32_t savedPC = 0;           // PC when the branch wa encountered (PC for the instruction in memory after the branch instruction)
    
    // start simulation
    // TODO: complete simulation loop and implement branch delay logic
    while (!err) {
        // fetch current instruction

        uint32_t instruction;
    
        myMem->getMemValue(PC, instruction, WORD_SIZE);

        // increment PC & reset zero register
        PC += 4;

        regData.registers[0] = 0;

        if (encounteredBranch && !executedDelaySlot) {
            // we are about to execute the delay slot
            executedDelaySlot = true;
        } else if (encounteredBranch && executedDelaySlot) {
            // we have execteud the delay slot, thus we want to now execute
            /// the branch that we have encountered
            instruction = savedBranch;
        }

        // check for halt instruction
        if (instruction == 0xfeedfeed) {
            dump(myMem);
            return 0;
        }

        // TODO: parse instruction by completing function calls to extractBits()
        // and set operands accordingly
        uint32_t opcode = extractBits(instruction, 31, 26);
        uint32_t rs = extractBits(instruction, 25, 21);
        uint32_t rt = extractBits(instruction, 20, 16);
        uint32_t rd = extractBits(instruction, 15, 11);
        uint32_t shamt = extractBits(instruction, 10, 6);
        uint32_t funct = extractBits(instruction, 5, 0);
        uint16_t immediate = extractBits(instruction, 15, 0);
        uint32_t address = extractBits(instruction, 25, 0);

        int32_t signExtImm = int32_t(immediate)
        uint32_t zeroExtImm = uint32_t(immediate)

        uint32_t branchAddr = (signExtImm << 2) + PC
        // address: 00000011111111111111111111111111
        // shift left 2: 00001111111111111111111111111100
        //           PC: 11010000000000000001000010000000
        // after extract:00000000000000000000000000001101
        // shift left: 11010000000000000000000000000000
        uint32_t jumpAddr = (address << 2) + (extractBits(PC, 31, 28) << 28) // assumes PC += 4 just happened

        // if (opcode == branc)
        // else if (opcode == jump)

        switch(opcode) {
            case OP_ZERO: // R-type instruction 
                switch(funct) {
                    case FUN_ADD:  
                        regData.registers[rd] = regData.registers[rs] + regData.registers[rt];
                        break;                       
                    case FUN_ADDU: 
                        regData.registers[rd] = regData.registers[rs] + regData.registers[rt];
                        break;
                    case FUN_AND: 
                        regData.registers[rd] = regData.registers[rs] & regData.registers[rt];
                        break;
                    case FUN_JR: 
                        PC = regData.registers[rs];
                        break;
                    case FUN_NOR: 
                        regData.registers[rd] =  ~(regData.registers[rs] | regData.registers[rt]); 
                        break;
                    case FUN_OR: 
                        regData.registers[rd] = regData.registers[rs] | regData.registers[rt];
                        break;
                    case FUN_SLT:
                        if (int32_t(regData.registers[rs]) < int32_t(regData.registers[rt])) {
                            regData.registers[rd] = 1;
                        } else {
                            regData.registers[rd] = 0;
                        }
                        break;
                    case FUN_SLTU: 
                        if (regData.registers[rs] < regData.registers[rt]){
                            regData[rd] = 1;
                        } else {
                            regData[rd] = 0;
                        }
                        break;
                    case FUN_SLL: 
                        regData.registers[rd] = regDat.registers[rt] << shamt;
                        break;
                    case FUN_SRL: 
                        regData.registers[rd] = regData.registers[rt] >>> shamt;
                        break;
                    case FUN_SUB:  
                        regData.registers[rd] = regData.registers[rs] - regData.registers[rt];
                        break;
                    case FUN_SUBU: 
                        regData.registers[rd] = regData.registers[rs] - regData.registers[rt];
                        break;
                    default:
                        fprintf(stderr, "\tIllegal operation...\n");
                        err = true;
                }
                break;
            case OP_ADDI: 
                regData.registers[rt] = regData.registers[rs] + signExtImm;
                break;
            case OP_ADDIU: 
                regData.registers[rt] = regData.registers[rs] + signExtImm;
                break;
            case OP_ANDI: 
                regData.registers[rt] = regData.registers[rs] & zeroExtImm;
                break;
            case OP_BEQ: 
                if (executedDelaySlot) {
                    if (regData.registers[rs] == regData.registers[rt]) {
                        PC = savedPC + branchAddr;
                    } else {
                        // instruction after the delay slot
                        PC = savedPC + 4;
                    }
                    encounteredBranch = false;
                    executedDelaySlot = false;
                } else {
                    encounteredBranch = true;
                    savedPC = PC;
                    savedBranch = instruction;
                }
                break;                
            case OP_BNE: 
                
            case OP_BLEZ: 
                if (executedDelaySlot) {
                    if (regData.registers[rs] <= 0) {
                        PC = savedPC + branchAddr;
                    } else {
                        // instruction after the delay slot
                        PC = savedPC + 4;
                    }
                    encounteredBranch = false;
                    executedDelaySlot = false;
                } else {
                    encounteredBranch = true;
                    savedPC = PC;
                    savedBranch = instruction;
                }   
            break;
            case OP_BGTZ:

                
            case OP_J:
                
            case OP_JAL: 
                
            case OP_LBU: 
                myMem->getMemValue(regData.registers[rs] + signExtImm, regData.registers[rt], BYTE_SIZE);
                break;
            case OP_LHU:
                myMem->getMemValue(regData.registers[rs] + signExtImm, regData.registers[rt], HALF_SIZE);  
                break;
            case OP_LUI: 
                regData.registers[rt] = immediate << 16;
                break;   
            case OP_LW: 
                myMem->getMemValue(regData.registers[rs] + signExtImm, regData.registers[rt], WORD_SIZE);  
                break;                
            case OP_ORI: 
                regData.registers[rt] = regData.registers[rs] | zeroExtImm;
                break;
            case OP_SLTI: 
                if (int32_t(regData.registers[rs])  < signExtImm) {
                    regData.registers[rt] = 1;
                } else {
                    regData.registers[rt] = 0;
                }
                break;
            case OP_SLTIU:
                if (regData.registers[rs] < signExtImm) {
                    regData.registers[rt] = 1;
                } else {
                    regData.registers[rt] = 0;
                }
                break;
            case OP_SB:  
                myMem->setMemValue(regData.registers[rs] + signExtImm, regData.registers[rt], BYTE_SIZE);
                break;
            case OP_SH: 
                myMem->setMemValue(regData.registers[rs] + signExtImm, regData.registers[rt], HALF_SIZE);
                break;
            case OP_SW: 
                myMem->setMemValue(regData.registers[rs] + signExtImm, regData.registers[rt], WORD_SIZE);
                break;
            default:
                fprintf(stderr, "\tIllegal operation...\n");
                err = true;
        }

    }

    // dump and exit with error
    dump(myMem);
    exit(127);
    return -1;  
}



