#ifndef FPGACONFIG_H
#define FPGACONFIG_H

#include <stdint.h>

#include "Uart.h"

#define CLK_FREQ 25000000UL // 25 MHz

#define MEMADDR_OCRAM               ((uintptr_t)(0x00000000))
#define MEMADDR_INTERRUPTCONTROLLER ((uintptr_t)(0x00010000))
#define MEMADDR_PIO                 ((uintptr_t)(0x00010100))
#define MEMADDR_UART                ((uintptr_t)(0x00010200))

#define C_INTERRUPTS 8
#define IRQ_UART 0

#ifndef DBUILD_VERSION
#define DBUILD_VERSION "git undefined"
#endif

#ifndef DBUILD_DATE
#define DBUILD_DATE "date undefined"
#endif

typedef volatile struct t_Pio {
	uint32_t port;
	uint32_t direction;
	uint32_t _reserved1;
	uint32_t _reserved2;
	uint32_t outset;
	uint32_t outclear;
} Pio;

/* InterruptController

	The InterruptController serves as a simple replacement for the PLIC/CLINT.
	It combines up to 32 external, software and the timer interrupt in one signal,
	which is connected to the only interrupt SERV supports.
	Furthermore it provides the mtime and rdtime functionality with a 33 to 64 configurable bit timer.
	Machine level interupts (0x04 = SOFT, 0x08 = TIMER, 0x40 = EXTERNAL) are enabled
	by writing <w_menable_set> and disabled by writing <w_menable_clr> with a bit mask.
	Writes with 0 bits are ignored on these 2 registers. Reading these registers returns
	the enabled machine level interrupts <r_menable> and the pending interrupts <r_mpending>.
	The core is interrupted if a bit in both registers is '1'.
	Similar functionality is provided for the external interrupts.
	<ext_enable> can be read and written normally, writes to <ext_pending> are ignored.
	<mtime> and <mtimeh> implement the hardware counter. On reset it is set to 0, then on every
	sysclk it is incremented. Writes to these registers are ignored.
	Reading <mtimeh> actually reads an internal latch that is updated with the real
	value whenever <mtime> is read. This way the entire value can be read in effectively
	one instruction without timer rollover.
	<mtimecmp> and <mtimecmph> implement timer interrupt functionality.
	Whenever the value <mtime+h> is greater than or equal to <mtimecmp+h>,
	the TIMER bit (0x02) is set in <r_mpending>. Writes to these are registers use a latch.
	Writing to <mtimecmph> writes only to an internal latch, writing to <mtimecmp> then writes
	the lower 32 bit and the value from the latch to the actual register, this way a value
	larger than 33 bit can be written in one instruction.
	Reading <mtimecmp> and <mtimecmph> works normally.
	Last but not least <softinterrupt> provides functionality to trigger an interrupt from software.
	Iff <softinterrupt> is nonzero then the SOFT bit in <r_mpending> is set and a reading
	the register yields 0x01.

*/

typedef volatile struct t_InterruptController {
	union {
		uint32_t w_menable_set; // W
		uint32_t r_menable; // R
	};
	union {
		uint32_t w_menable_clr; // W
		uint32_t r_mpending; // R
	};
	uint32_t ext_enable; // RW
	uint32_t ext_pending; // R
	uint32_t mtime; // R
	uint32_t mtimeh; // R
	uint32_t mtimecmp; // RW
	uint32_t mtimecmph; // RW
	uint32_t softinterrupt; // RW
} InterruptController;

extern Pio* g_Pio;
extern Uart* g_Uart;
extern InterruptController* g_InterruptController;

#endif // FPGACONFIG_H
