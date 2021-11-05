#ifndef FPGACONFIG_H
#define FPGACONFIG_H

#include <stdint.h>

#include "Uart.h"

#define CLK_FREQ 25000000UL

#define MEMADDR_OCRAM ((uintptr_t)(0x00000000))
#define MEMADDR_PIO ((uintptr_t)(0x00010100))
#define MEMADDR_UART ((uintptr_t)(0x00010200))

#define IRQ_UART 3

#ifndef DBUILD_VERSION
#define DBUILD_VERSION "version undefined"
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

extern Pio* g_Pio;
extern Uart* g_Uart;

#endif // FPGACONFIG_H
