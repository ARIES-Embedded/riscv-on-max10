#include <stdint.h>

#include "Hal.h"
#include "FpgaConfig.h"

static VoidFunc Hal_ExtIrqCallback[32];

void Hal_SetExtIrqHandler(uint32_t irq, VoidFunc callback) {
	Hal_ExtIrqCallback[irq] = callback;
}

void Hal_EnableInterrupt(uint32_t irq) {
	Hal_EnableInterrupts(1 << irq);
}

void Hal_DisableInterrupt(uint32_t irq) {
	Hal_DisableInterrupts(1 << irq);
}

void Hal_Delay(uint32_t cycles) {
	uint32_t startTick = Hal_ReadTime32();
	while ((Hal_ReadTime32() - startTick) < cycles);
}

// Forward Declaration for Port.c
extern uintptr_t SystemInterruptHandler(uintptr_t stack);

// Called from Crt.S
uintptr_t Hal_Exception(uintptr_t stack, uintptr_t addr, uint32_t irq) {

	if ((irq & (1 << IRQ_BADINSTR)) || (irq & (1 << IRQ_MEMERROR))) {
		UartWrite(g_Uart, "TRAP\n    stack  ");
		UartWriteHex32(g_Uart, stack, true);
		UartWrite(g_Uart, "    q0     ");
		UartWriteHex32(g_Uart, addr, true);
		UartWrite(g_Uart, "    irq    ");
		UartWriteHex32(g_Uart, irq, true);
		while(1);
	}

	if (irq & (1 << IRQ_TIMER)) {
		stack = SystemInterruptHandler(stack);
	}

	for (uint32_t i = 3; i < 32; ++i) {
		if ((irq & (1 << i)) && Hal_ExtIrqCallback[i]) {
			Hal_ExtIrqCallback[i]();
		}
	}

	return stack;

}
