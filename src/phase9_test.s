

//This code is used to test RISC V Instruction set. The register x10 value is incremented with
//every instruction. If an instruction fails it jumps to FAIL sub routine and the value of x20
// is set to 1. The instruction number which failed can be seen in value of register x10. If all
// instructions worked correctly, it jumps to PASS sub routine and the value of x25 register is
// is set to 1 //


// Section .crt0 is always placed from address 0
    .section .crt0, "ax"


//Symbol start is used to obtain entry point information
_start:
    .global _start

    //Testing alu instruction addi: case 1//
    li x10, 1
    li x2, 10
    addi x1, x1, 10
    bne x1, x2, FAIL

    //Testing add: case 2//
    addi x10, x10, 1
    li x3, 20
    add x1, x1, x2
    bne x1, x3, FAIL

    //Test and: case 3//
    addi x10, x10, 1
    and x3, x1, x2
    bnez x3, FAIL
    li x4, -1			// x4 = 0xFFFFFFFF
    and x3, x4, x2
    bne x3, x2, FAIL
    and x3, x4, x0
    bnez x3, FAIL

    //Test or: case 4//
    addi x10, x10, 1
    li x3, 10
    or x5, x3, x2
    bne x5, x3, FAIL
    or x2, x4, x0
    bne x2, x4, FAIL

    //Test xor: case 5//
    addi x10, x10, 1
    xor x2, x2, x4
    bnez x2, FAIL
    xor x5, x3, x4
    beq x5, x3, FAIL
    xor x5, x5, x4
    bne x5, x3, FAIL

    //Test sub: case 6//
    addi x10, x10, 1
    li x2, 10
    sub x2, x2, x3
    bnez x2, FAIL

    //Test sll: case 7//
    addi x10, x10, 1
    li x2, 170
    mv x5, x2
    li x3, 2
    li x4, 680
    sll x2, x2, x3
    bne x2, x4, FAIL

    //Test sra: case 8//
    addi x10, x10, 1
    li x6,-25
    sra x6, x6, x3
    li x7,-7
    bne x6, x7, FAIL

    //Test srl: case 9//
    addi x10, x10, 1
    srl x2, x2, x3
    bne x2, x5, FAIL

    //Test slt: case 10//
    addi x10, x10, 1
    li x2, 1
    slt x6, x3, x5
    bne x6, x2, FAIL
    slt x6, x4, x5
    bnez x6, FAIL
    li x3, -1
    slt x6, x3, x0
    bne x6, x2, FAIL

    //Test sltu: case 11//
    addi x10, x10, 1
    sltu x6, x3, x0
    bnez x6, FAIL

    //Test andi: case 12//
    addi x10, x10, 1
    andi x4, x4, 0
    bnez x4, FAIL

    //Test ori: case 13//
    addi x10, x10, 1
    li x3, 0x55
    li x2, 0x50
    mv x4, x2
    ori x2, x2, 0x05
    bne x2, x3, FAIL

    //Test xori: case 14//
    addi x10, x10, 1
    xori x3, x3, 5
    bne x3, x4, FAIL

    //Test slti: case 15//
    addi x10, x10, 1
    li x4, 1
    slti x7, x3, 0x60
    bne x7, x4, FAIL
    slti x7, x3, 0x45
    bnez x7, FAIL
    slti x7, x3, -1
    bnez x7, FAIL

    //Test sltiu: case 16//
    addi x10, x10, 1
    sltiu x7, x3, -1
    bne x7, x4, FAIL

    //Test beq: case 17//
    addi x10, x10, 1
    li x3, 5
    mv x5, x3
    beq x5, x3, BEQ1
    j FAIL

BEQ1:
	addi x3, x3, 1		// Make different
	beq x5, x3, FAIL

    //Test bne: case 18//
    addi x10, x10, 1
    bne x5, x4, BNE1
    j FAIL

BNE1:
	mv x5, x4			// Make the same
	bne x5, x4, FAIL

    //Test blt: case 19//
    addi x10, x10, 1
    blt x4, x3, BLT1
    bgt x4, x3, FAIL
    beq x4, x3, FAIL

BLT1:
	blt x3, x4, FAIL

    //Test bgt: case 20//
    addi x10, x10, 1
    bgt x3, x4, BGT1
    blt x3, x4, FAIL
    beq x3, x4, FAIL

BGT1:
	bgt x4, x3, FAIL

    //Test bltu:case 21//
    addi x10, x10, 1
    li x1, -1
    bltu x5, x1, BLTU1
    bgt x5, x1, FAIL
    beq x5, x1, FAIL

BLTU1:
	bltu x1, x5, FAIL

    //Test bge: case 22//
    addi x10, x10, 1
    bge x5, x1, BGE1
    blt x5, x1, FAIL

BGE1:
	bge x1, x5, FAIL

    //Test bgeu: case 23//
    addi x10, x10, 1
    bgeu x1, x5, BGEU1
    blt x1, x5, FAIL

BGEU1:
	bgeu x5, x1, FAIL

    //Test slli: case 24//
    addi x10, x10, 1
    li x3, 0xAA
    mv x5, x3
    li x4, 0x2A8
    slli x3, x3, 2
    bne x3, x4, FAIL

    //Test srli: case 25//
    addi x10, x10, 1
    srli x3, x3, 2
    bne x3, x5, FAIL

    //Test srai: case 26//
    addi x10, x10, 1
    li x6, -125
    srai x6, x6, 4
    li x7,-8
    bne x6, x7, FAIL

    // Test lui: case 27//
    addi x10, x10, 1
    lui x8, 0x27835
    srli x7, x8, 20
    li x9, 0x278
    bne x7, x9, FAIL
    slli x8, x8, 12
    srli x8, x8, 24
    li x9, 0x35
    bne x8, x9, FAIL

    //Test jal: case 28//
    addi x10, x10, 1
    jal x3, SUB_ROUTINE
    j FAIL

//Set x20 to 1 if an instruction fails, instruction no. which failed is in x10//
FAIL:
    li x20, 1
    nop
    nop
    nop
    halt
    nop
    nop
    nop


AUIPC1: jalr x0, 0(x12)
	j FAIL

SUB_ROUTINE:
    //Test jr: case 29//
    addi x10, x10, 1
    jal x3, SUB_ROUTINE2

    // Test auipc: case 30//
    jal x12, AUIPC1
    auipc x13, 0x40
    lui x14, 0x40
    add x12, x12, x14
    bne x12, x13, FAIL

    //Test li: case 30//
    addi x10, x10, 1
    li x13, 0xAB
    and x19, x19, x0
    addi x19, x19, 0xAB
    bne x19, x13, FAIL

    //Test mv: case 31//
    addi x10, x10, 1
    mv x14, x13
    bne x13, x14, FAIL

    //Test not: case 32//
    addi x10, x10, 1
    lui x13, 0xAAAAA
    addi x13, x13, 0xAA
    lui x14, 0x55555
    addi x14, x14, 0x755
    addi x14, x14, 0x7FF
    addi x14, x14, 1
    not x14, x14
    bne x13, x14, FAIL

    //Test neg: case 33//
    addi x10, x10, 1
    addi x13, x13, 1
    not x14, x14
    neg x14, x14
    bne x13, x14, FAIL

    //Test seqz: case 34//
    addi x10, x10, 1
    li x1, 1
    seqz x5, x0
    bne x5, x1, FAIL

    //Test snez: case 35//
    addi x10, x10, 1
    snez x6, x5
    bne x6, x1, FAIL
    snez x6, x0
    bnez x6, FAIL

    //Test sltz: case 36//
    addi x10, x10, 1
    mv x2, x1
    neg x2, x2
    sltz x6, x2
    bne x6, x1, FAIL
    sltz x6, x1
    bnez x6, FAIL

    //Test sgtz: case 37//
    addi x10, x10, 1
    sgtz x6, x1
    bne x6, x1, FAIL
    sgtz x6, x2
    bnez x6, FAIL

    //Test beqz: case 38//
    addi x10, x10, 1
    beqz x0,SUB_ROUTINE3
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE3:
    //Test bnez: case 39//
    addi x10, x10, 1
    bnez x1, SUB_ROUTINE4
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE4:
    //Test blez: case 40//
    addi x10, x10, 1
    blez x2,SUB_ROUTINE5
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE5:
    blez x0,SUB_ROUTINE6
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE6:
    //Test bgez: case 41//
    addi x10, x10, 1
    bgez x1, SUB_ROUTINE7
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE7:
    bgez x0,SUB_ROUTINE8
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE8:
    //Test bltz: case 42//
    addi x10, x10, 1
    bltz x2,SUB_ROUTINE9
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE9:
    //Test bgtz: case 43//
    addi x10, x10, 1
    bgtz x1,SUB_ROUTINE10
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE10:
    //Test ble: case 44//
    addi x10, x10, 1
    ble x2, x1,SUB_ROUTINE11
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE11:
    //Test bgtu: case 45//
    addi x10, x10, 1
    bgtu x2, x1,SUB_ROUTINE12
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE12:
    //Test bleu: case 46//
    addi x10, x10, 1
    bleu x1, x2,SUB_ROUTINE13
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE13:
    //Test call: case 47//
    addi x10, x10, 1
    call SUB_ROUTINE14
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE14:
    //Test ret: case 48//
    addi x10, x10, 1
    call SUB_ROUTINE15
    j VECBR
    nop
    nop
    nop
    halt
    nop
    nop
    nop


SUB_ROUTINE15:
    ret
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop

VECBR:
    //Test jalr: case 49//
	addi x10, x10, 1
	li x11, 8			// Vector distance in bytes
	li x9, 403			// Initial value
	li x8, 1706			// Final x9 value
	auipc x13, 1		// Get the current PC + 0x1000
	addi x13, x13, 0x800	// Subtract 0x800
	addi x13, x13, 0x808	// Subtract 0x800 - result is original PC + 8
	addi x5, x13, 32	// Loop limit relative to PC
VECLOOP:
	jalr x3, 28(x13)	// Jump to vector table (this instruction address x13 + 28)
	add x13, x13, x11	// Step through the table
	bne x13, x5, VECLOOP
	bne x9, x8, FAIL
	j SUB_ROUTINE16

VECTBL0:				// Vector table entry 0 - address x13 + 28
	addi x9, x9, 17		// x9 = 420
	jalr x0, 0(x3)		// Return
VECTBL1:
	slli x9, x9, 2		// x9 = 1680
	jalr x0, 0(x3)		// Return
VECTBL2:
	addi x9, x9, -827	// x9 = 853
	jalr x0, 0(x3)		// Return
VECTBL3:
	slli x9, x9, 1		// x9 = 1706
	jalr x0, 0(x3)		// Return

SUB_ROUTINE16:
    //Test lw and sw, memory conflict: case 50//
    addi x26, x0, 0			// Set up memory base address
    addi x10, x10, 1
    sw x10, 0x7CC(x26)
//    nop					// FIXME!!
    lw x11, 0x7CC(x26)
//    nop					// FIXME!!
//    nop					// FIXME!!
//    nop					// FIXME!!
    bne x11, x10, FAIL
    lw x12, 0(x0)			// Read location 0
    beq x11, x12, FAIL		// Fail if memory address always 0


    //Test lbu and sb: case 51//
    addi x10, x10, 1
    li x13, 0xFF
    addi x26, x26, 1		// x26 = 1
    addi x27, x26, 4		// x27 = 5
    sb x13, 0x7CC(x27)
//    nop					// FIXME!!
    lbu x14, 0x7D0(x26)
//    nop					// FIXME!!
//    nop					// FIXME!!
//    nop					// FIXME!!
    bne x14, x13, FAIL

    //Test lhu and sh:case 52//
    addi x10, x10, 1
    addi x26, x26, 1		// x26 = 2
    addi x27, x26, 4		// x27 = 6
    li x13, 0x355
    sh x13, 0x7CC(x27)
//    nop					// FIXME!!
    lhu x14, 0x7D0(x26)
//    nop					// FIXME!!
//    nop					// FIXME!!
//    nop					// FIXME!!
    bne x14, x13, FAIL

    //Test lb: case 53//
    addi x10, x10, 1
    li x13, 0xFA
    addi x27, x26, 9		// x27 = 11
    addi x26, x26, 1		// x26 = 3
    sb x13, 0x7D4(x26)
//    nop					// FIXME!!
    lb x15, 0x7CC(x27)
//    nop					// FIXME!!
//    nop					// FIXME!!
//    nop					// FIXME!!
    andi x15, x15, 0xFF
    bne x15, x13, FAIL

    //Test lh: case 54//
    addi x10, x10, 1
    lui x14, 0x0000F
    addi x14, x14, 0x73A
    addi x27, x26, 11		// x27 = 14
    addi x26, x26, 3		// x26 = 6
    sh x14, 0x7D8(x26)
    //nop					// FIXME!!
    lh x15, 0x7D0(x27)
    lui x16, 0x0000F
    addi x16, x16, 0x7FF
    addi x16, x16, 0x7FF
    addi x16, x16, 1
    and x15, x15, x16
    bne x15, x14, FAIL

    // Test load dependency stall: case 55
    addi x10, x10, 1
    li x8, 65				// x8 <- 65
    sw x10, 0x7CC(x0)		// Memory <- 34
//    nop					// FIXME!!
	lw x8, 0x7CC(x0)			// x8 <- 34
//    nop					// FIXME!!
//    nop					// FIXME!!
//    nop					// FIXME!!
	add x9, x8, x0			// x9 <- 34 (stall)
	bne x9, x10, FAIL

    // Test multiple read/write: case 56
    addi x10, x10, 1
    li x26, 20
    addi x27, x26, 4
    addi x28, x27, 4
    addi x29, x28, 4
    lui x13, 0x55555
    addi x13, x13, 0x555	// x13 = 0x55555555
    xori x14, x13, 0xFFF	// X14 = 0xAAAAAAAA
    addi x15, x13, 0x333
    addi x16, x14, 0x333
    sw x13, 0x7D0(x26)
    sw x14, 0x7D0(x27)
    sw x15, 0x7D0(x28)
    sw x16, 0x7D0(x29)
  //  nop
    lw x2, 0x7D0(x29)
    lw x3, 0x7D0(x28)
    lw x4, 0x7D0(x27)
    lw x5, 0x7D0(x26)
    bne x5, x13, FAIL
    bne x4, x14, FAIL
    bne x3, x15, FAIL
    bne x2, x16, FAIL

    // Test byte write: case 57
    addi x10, x10, 1
    li x13, 0x12
    li x14, 0x34
    li x15, 0x56
    li x16, 0x78
    lui x17, 0x78563
    addi x17, x17, 0x412	// Result = 0x78453412
    addi x26, x26, 0x7CC
    sb x13, 4(x26)
    sb x14, 5(x26)
    sb x15, 6(x26)
    sb x16, 7(x26)
    nop
    lw x18, 4(x26)
    bne x18, x17, FAIL

    // Exercise branches for Phase 9: case 58
    addi x10, x10, 1

    li x1, 0				// Outer loop counter
    li x2, 50				// Outer loop limit
    li x6, 51				// For bge test
    li x4, 50				// Inner loop limit
LOOP1:						// Outer loop
	li x3, 0					// Inner loop counter
LOOP2:						// Inner loop
	addi x3, x3, 1			// Increment inner
	jal x7, TEST1			// x7 points to TEST1
TEST1:						// Exercise JAL
	 jalr x0, 4(x7) 		// x7 + 4 points to TEST2
TEST2:
	bge x3, x6, FAIL		// Should never branch
	bne x3, x4, LOOP2
	addi x1, x1, 1			// Increment outer
	bne x1, x2, LOOP1

	j PASS
	nop
	nop
	nop
	nop
	halt
	nop
	nop
	nop


SUB_ROUTINE2:
    jr x3
    j FAIL

    nop
    nop
    nop
    halt
    nop
    nop
    nop

PASS:
    addi x25, x25, 1 //set x25 to 1 is all intsructions are working correctly
    nop
    nop
    nop
    halt			// PASS if we halt here
    nop
    nop
    nop



