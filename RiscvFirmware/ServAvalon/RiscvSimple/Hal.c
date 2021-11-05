#include "Hal.h"

static VoidFunc Hal_ExtIrqCallback[C_INTERRUPTS];
static VoidFunc Hal_TimerIrqCallback;
static VoidFunc Hal_SoftIrqCallback;

void Hal_SetExtIrqHandler(uint32_t irq, VoidFunc callback) {
	Hal_ExtIrqCallback[irq] = callback;
}

void Hal_SetTimerIrqHandler(VoidFunc callback) {
	Hal_TimerIrqCallback = callback;
}

void Hal_SetSoftIrqHandler(VoidFunc callback) {
	Hal_SoftIrqCallback = callback;
}

void Hal_EnableInterrupt(uint32_t irq) {
	Hal_EnableInterrupts(1 << irq);
}

void Hal_DisableInterrupt(uint32_t irq) {
	Hal_DisableInterrupts(1 << irq);
}

void Hal_EnableInterrupts(uint32_t mask) {
	g_InterruptController->ext_enable |= mask;
}

void Hal_DisableInterrupts(uint32_t mask) {
	g_InterruptController->ext_enable &= ~mask;
}

void Hal_Delay(uint32_t cycles) {
	uint32_t startTick = Hal_ReadTime32();
	while ((Hal_ReadTime32() - startTick) < cycles);
}

void Hal_TimerStart(uint64_t value) {
	Hal_DisableMachineInterrupt(IRQ_M_TIMER);
	uint64_t mtime;
	mtime = g_InterruptController->mtime;
	mtime |= (uint64_t)g_InterruptController->mtimeh << 32ULL;
	mtime += value;
	g_InterruptController->mtimecmph = (uint32_t)(mtime >> 32ULL);
	g_InterruptController->mtimecmp = (uint32_t)mtime;
	Hal_EnableMachineInterrupt(IRQ_M_TIMER);
}

void Hal_TimerStop() {
	Hal_DisableMachineInterrupt(IRQ_M_TIMER);
}

void Hal_RaiseSoftInterrupt() {
	g_InterruptController->softinterrupt = 1;
}

void Hal_ClearSoftInterrupt() {
	g_InterruptController->softinterrupt = 0;
}

void Hal_EnableMachineInterrupt(uint32_t irq) {
	g_InterruptController->w_menable_set = irq;
}

void Hal_DisableMachineInterrupt(uint32_t irq) {
	g_InterruptController->w_menable_clr = irq;
}

uint32_t Hal_ReadTime32() {
	return g_InterruptController->mtime;
}

uint64_t Hal_ReadTime64() {
	uint64_t mtime;
	mtime = g_InterruptController->mtime;
	mtime |= (uint64_t)g_InterruptController->mtimeh << 32ULL;
	return mtime;
}

// Called from Crt.S

uintptr_t Hal_Exception(uintptr_t stack, uintptr_t addr, uint32_t mcause) {

	if (mcause != 0x80000007) {
		UartWrite(g_Uart, "TRAP\n    stack    ");
		UartWriteHex32(g_Uart, stack, true);
		UartWrite(g_Uart, "    mepc     ");
		UartWriteHex32(g_Uart, addr, true);
		UartWrite(g_Uart, "    mcause   ");
		UartWriteHex32(g_Uart, mcause, true);
		UartWrite(g_Uart, "    irq en   ");
		UartWriteHex32(g_Uart, g_InterruptController->ext_enable, true);
		UartWrite(g_Uart, "    irq pen  ");
		UartWriteHex32(g_Uart, g_InterruptController->ext_pending, true);
		UartWrite(g_Uart, "    mtval    ");
		UartWriteHex32(g_Uart, read_csr(mtval),true);
		UartWrite(g_Uart, "    mbadaddr ");
		UartWriteHex32(g_Uart, read_csr(mbadaddr), true);
		while(1);
	}

	uint32_t icause = g_InterruptController->r_menable & g_InterruptController->r_mpending;

	if (icause & IRQ_M_SOFT) {
		if (Hal_SoftIrqCallback) Hal_SoftIrqCallback();
	}

	if (icause & IRQ_M_TIMER) {
		if (Hal_TimerIrqCallback) Hal_TimerIrqCallback();
	}

	if (icause & IRQ_M_EXT) {
		uint32_t ecause = g_InterruptController->ext_enable & g_InterruptController->ext_pending;
		for (uint32_t i = 0; i < C_INTERRUPTS; ++i) {
			if ((ecause & (1 << i)) && Hal_ExtIrqCallback[i]) {
				Hal_ExtIrqCallback[i]();
			}
		}
	}

	return stack;

}
