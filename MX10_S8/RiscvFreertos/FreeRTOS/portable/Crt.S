# Section expected at OCRAM + 0x10
# Section must have maximum of 16 bytes
.section .init
.global __reset_vector__ # export for linker script
__reset_vector__:
	1:
	j _start

# Section expected at OCRAM + 0x20
.section .exception
	# On exception, store all relevant registers on stack, call Hal_Exception routine, then restore registers from stack.
	# Hal_Exception returns a new stack pointer that for regular interrupts should be the argument stack pointer unchanged.
	# Operating Systems with Task Scheduling can switch tasks by returning a new valid stack pointer of a different task.
	# Irrelevant registers include zero(x0), sp(x2), gp(x3), tp(x4)
	# Relevant registers additionally include the instruction pointer at the time of interrupt: mepc
	# Total number of stored registers: 32 - 4 + 1 = 29
.global __exception_vector__ # export for linker script
__exception_vector__:
	addi sp, sp, -29*4
	sw x1, 0 * 4(sp)
	sw x5, 1 * 4(sp)
	sw x6, 2 * 4(sp)
	sw x7, 3 * 4(sp)
	sw x8, 4 * 4(sp)
	sw x9, 5 * 4(sp)
	sw x10, 6 * 4(sp)
	sw x11, 7 * 4(sp)
	sw x12, 8 * 4(sp)
	sw x13, 9 * 4(sp)
	sw x14, 10 * 4(sp)
	sw x15, 11 * 4(sp)
	sw x16, 12 * 4(sp)
	sw x17, 13 * 4(sp)
	sw x18, 14 * 4(sp)
	sw x19, 15 * 4(sp)
	sw x20, 16  * 4(sp)
	sw x21, 17  * 4(sp)
	sw x22, 18  * 4(sp)
	sw x23, 19  * 4(sp)
	sw x24, 20  * 4(sp)
	sw x25, 21  * 4(sp)
	sw x26, 22  * 4(sp)
	sw x27, 23  * 4(sp)
	sw x28, 24  * 4(sp)
	sw x29, 25  * 4(sp)
	sw x30, 26  * 4(sp)
	sw x31, 27  * 4(sp)

	csrr a1, mepc
	sw a1, 28  * 4(sp)
	mv a0, sp
	csrr a2, mcause
	jal Hal_Exception

	mv sp, a0
	lw a0, 28  * 4(sp)
	csrw mepc, a0

	lw x1, 0 * 4(sp)
	lw x5, 1 * 4(sp)
	lw x6, 2 * 4(sp)
	lw x7, 3 * 4(sp)
	lw x8, 4 * 4(sp)
	lw x9, 5 * 4(sp)
	lw x10, 6 * 4(sp)
	lw x11, 7 * 4(sp)
	lw x12, 8 * 4(sp)
	lw x13, 9 * 4(sp)
	lw x14, 10 * 4(sp)
	lw x15, 11 * 4(sp)
	lw x16, 12 * 4(sp)
	lw x17, 13 * 4(sp)
	lw x18, 14 * 4(sp)
	lw x19, 15 * 4(sp)
	lw x20, 16 * 4(sp)
	lw x21, 17 * 4(sp)
	lw x22, 18 * 4(sp)
	lw x23, 19 * 4(sp)
	lw x24, 20 * 4(sp)
	lw x25, 21 * 4(sp)
	lw x26, 22 * 4(sp)
	lw x27, 23 * 4(sp)
	lw x28, 24 * 4(sp)
	lw x29, 25 * 4(sp)
	lw x30, 26 * 4(sp)
	lw x31, 27 * 4(sp)

	addi sp, sp, 29*4
	mret

.section .text

_start:
	# Initialize all registers with 0
	addi x1, zero, 0
	addi x2, zero, 0
	addi x3, zero, 0
	addi x4, zero, 0
	addi x5, zero, 0
	addi x6, zero, 0
	addi x7, zero, 0
	addi x8, zero, 0
	addi x9, zero, 0
	addi x10, zero, 0
	addi x11, zero, 0
	addi x12, zero, 0
	addi x13, zero, 0
	addi x14, zero, 0
	addi x15, zero, 0
	addi x16, zero, 0
	addi x17, zero, 0
	addi x18, zero, 0
	addi x19, zero, 0
	addi x20, zero, 0
	addi x21, zero, 0
	addi x22, zero, 0
	addi x23, zero, 0
	addi x24, zero, 0
	addi x25, zero, 0
	addi x26, zero, 0
	addi x27, zero, 0
	addi x28, zero, 0
	addi x29, zero, 0
	addi x30, zero, 0
	addi x31, zero, 0
	# Load stack and global pointer
	la  sp, _sp
	la gp, _gp
	jal main
1:	j 1b
