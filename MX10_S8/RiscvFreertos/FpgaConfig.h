#ifndef FPGACONFIG_H
#define FPGACONFIG_H

#include <stdint.h>

#include "Uart.h"

#define CLK_FREQ 25000000UL // 25 MHz

#define MEMADDR_OCRAM     ((uintptr_t)(0x00000000))
#define MEMADDR_IRQCONTROLLER ((uintptr_t)(0x00010000))
#define MEMADDR_PIO       ((uintptr_t)(0x00010100))
#define MEMADDR_UART      ((uintptr_t)(0x00010200))

#define IRQ_UART 0

#ifndef DBUILD_VERSION
#define DBUILD_VERSION "git undefined"
#endif

#ifndef DBUILD_DATE
#define DBUILD_DATE "date undefined"
#endif

typedef volatile struct {
	uint32_t port;
	uint32_t direction;
	uint32_t _reserved1;
	uint32_t _reserved2;
	uint32_t outset;
	uint32_t outclear;
} Pio;

/* InterruptController

	The InterruptController serves as a simple replacement for the PLIC/CLINT.
	It provides handling for external, soft and timer interrupts.
	External interrupts are connected via Qsys and assert the IRQ_M_EXT signal to the
	core when a bit in both <pending> and <enabled> is high.
	<pending> can be read anytime and shows all current asserted interrupts,
	even if the interrupt is not enabled.
	<mtimeh_latch> is set to the current <mtimeh> value whenever <mtime> (low) is read,
	this is used to snapshot the 64-bit register and read it with 32-bit access without any changes.
	Similary mtimecmp can be written with a 64-bit value at once.
	First <mtimecmph_latch> is written with bits 63 to 32, then <mtimecmp_latch> is written
	with bit 31 to 0. Writing <mtimecmp_latch> writes directly to <mtimecmp>
	and copies the 32-bits of the high-register in the same cycle.
	While mtime is greater or equal to mtimecmp, the IRQ_M_TMR signal is asserted.
	Finally while the register <softinterupt> is holding a value equal nonzero,
	the IRQ_M_SFT signal is asserted. It takes approx. 4 instructions after the write
	until the core is interrupted.

*/

typedef volatile struct {
	uint32_t pending; // R
	uint32_t enabled; // RW
	uint32_t mtime; // RW
	uint32_t mtimeh; // RW
	uint32_t mtimeh_latch; // R
	uint32_t mtimecmp; // RW
	uint32_t mtimecmph; // RW
	uint32_t mtimecmp_latch; // W
	uint32_t mtimecmph_latch; // RW
	uint32_t softinterrupt; // RW
} InterruptController;

extern Pio* g_Pio;
extern Uart* g_Uart;
extern InterruptController* g_InterruptController;

#endif // FPGACONFIG_H
