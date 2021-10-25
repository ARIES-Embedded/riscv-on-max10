#ifndef HAL_H
#define HAL_H

#include <stdint.h>

#define IRQ_TIMER 0
#define IRQ_BADINSTR 1
#define IRQ_MEMERROR 2

typedef void(*VoidFunc)(void);

// Located in Hal.c

void Hal_SetExtIrqHandler(uint32_t irq, VoidFunc callback);
void Hal_EnableInterrupt(uint32_t irq);
void Hal_DisableInterrupt(uint32_t irq);
void Hal_Delay(uint32_t cycles);

// Located in Hal.S

void Hal_EnableInterrupts(uint32_t mask);
void Hal_DisableInterrupts(uint32_t mask);
void Hal_TimerStart(uint32_t value);
uint32_t Hal_TimerRead();
void Hal_TimerStop();
uint32_t Hal_ReadTime32();
uint64_t Hal_ReadTime64();

// Private function called from Crt.S, not to be called directly
	// uintptr_t Hal_Exception(uintptr_t stack, uintptr_t addr, uint32_t irq);


#endif // HAL_H
